import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'data.dart';
import 'download_list_item.dart';

class DownloadFile extends StatefulWidget {
  const DownloadFile({Key? key}) : super(key: key);

  @override
  State<DownloadFile> createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {

  List<TaskInfo>? _tasks;
  late List<ItemHolder> _items;
  late bool _showContent;
  late bool _permissionReady;
  late bool _saveInPublicStorage;
  late String _localPath;
  final ReceivePort _port = ReceivePort();

  _getPath()async{
    await getExternalStorageDirectory().then((value){
      _localPath = value!.path;
    });
  }

  @override
  void initState() {
    _getPath();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback, step: 1);

    _showContent = false;
    _permissionReady = false;
    _saveInPublicStorage = false;

    _prepare();
    super.initState();
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = data[1] as DownloadTaskStatus;
      final progress = data[2] as int;

      debugPrint(
        'Callback on UI isolate: '
            'task ($taskId) is in status ($status) and process ($progress)',
      );

      if (_tasks != null && _tasks!.isNotEmpty) {
        final task = _tasks!.firstWhere((task) => task.taskId == taskId);
        setState(() {
          task
            ..status = status
            ..progress = progress;
        });
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id,
      DownloadTaskStatus status,
      int progress,
      ) {
    debugPrint(
      'Callback on background isolate: '
          'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }

  Widget _buildDownloadList() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        ..._items.map(
              (item) {
            final task = item.task;
            if (task == null) {
              return Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  item.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              );
            }

            return DownloadListItem(
              data: item,
              onTap: (task) async {
                final success = await _openDownloadedFile(task);
                if (!success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cannot open this file'),
                    ),
                  );
                }
              },
              onActionTap: (task) {
                if (task.status == DownloadTaskStatus.undefined) {
                  _requestDownload(task);
                } else if (task.status == DownloadTaskStatus.running) {
                  _pauseDownload(task);
                } else if (task.status == DownloadTaskStatus.paused) {
                  _resumeDownload(task);
                } else if (task.status == DownloadTaskStatus.complete ||
                    task.status == DownloadTaskStatus.canceled) {
                  _delete(task);
                } else if (task.status == DownloadTaskStatus.failed) {
                  _retryDownload(task);
                }
              },
              onCancel: _delete,
            );
          },
        ),
      ],
    );
  }

  Widget _buildNoPermissionWarning() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Grant storage permission to continue',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, fontSize: 18),
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: _retryRequestPermission,
            child: const Text(
              'Retry',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      // await _prepareSaveDir();
    }

    setState(() {
      _permissionReady = hasGranted;
    });
  }

  Future<void> _requestDownload(TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      headers: {'auth': 'test_for_sql_encoding'},
      savedDir: _localPath,
      saveInPublicStorage: _saveInPublicStorage,
    );
  }

  Future<void> _pauseDownload(TaskInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId!);
  }

  Future<void> _resumeDownload(TaskInfo task) async {
    final newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  Future<void> _retryDownload(TaskInfo task) async {
    final newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(TaskInfo? task) async {
    final taskId = task?.taskId;
    if (taskId == null) {
      return false;
    }

    return FlutterDownloader.open(taskId: taskId);
  }

  Future<void> _delete(TaskInfo task) async {
    await FlutterDownloader.remove(
      taskId: task.taskId!,
      shouldDeleteContent: true,
    );
    await _prepare();
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt > 28) {
        return true;
      }

      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }

  Future<void> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      debugPrint('No tasks were retrieved from the database.');
      return;
    }

    int count = 0;
    _tasks = [];
    _items = [];

    _tasks!.addAll(
      DownloadItems.documents.map(
            (document) => TaskInfo(name: document.name, link: document.url),
      ),
    );

    _items.add(ItemHolder(name: 'Documents'));
    for (var i = count; i < _tasks!.length; i++) {
      _items.add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    _tasks!.addAll(
      DownloadItems.images
          .map((image) => TaskInfo(name: image.name, link: image.url)),
    );

    _items.add(ItemHolder(name: 'Images'));
    for (var i = count; i < _tasks!.length; i++) {
      _items.add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    _tasks!.addAll(
      DownloadItems.videos
          .map((video) => TaskInfo(name: video.name, link: video.url)),
    );

    _items.add(ItemHolder(name: 'Videos'));
    for (var i = count; i < _tasks!.length; i++) {
      _items.add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    _tasks!.addAll(
      DownloadItems.apks
          .map((video) => TaskInfo(name: video.name, link: video.url)),
    );

    _items.add(ItemHolder(name: 'APKs'));
    for (var i = count; i < _tasks!.length; i++) {
      _items.add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    for (final task in tasks) {
      for (final info in _tasks!) {
        if (info.link == task.url) {
          info
            ..taskId = task.taskId
            ..status = task.status
            ..progress = task.progress;
        }
      }
    }

    _permissionReady = await _checkPermission();

    setState(() {
      _showContent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      if (!_showContent) {
        return const Center(child: CircularProgressIndicator());
      }
      return _permissionReady
          ? _buildDownloadList()
          : _buildNoPermissionWarning();
    });
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }
}

class ItemHolder {
  ItemHolder({this.name, this.task});

  final String? name;
  final TaskInfo? task;
}

class TaskInfo {
  TaskInfo({this.name, this.link});

  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;
}
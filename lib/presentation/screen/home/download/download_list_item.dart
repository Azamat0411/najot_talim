import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:najot_talim/core/component/flash/flash.dart';
import 'package:najot_talim/core/component/flash/flash_widget.dart';
import 'package:najot_talim/core/constant/app_colors.dart';

import 'download_file.dart';

class DownloadListItem extends StatelessWidget with WidgetsBindingObserver {
  const DownloadListItem({
    super.key,
    this.data,
    this.onTap,
    this.onActionTap,
    this.onCancel,
  });

  final ItemHolder? data;
  final Function(TaskInfo?)? onTap;
  final Function(TaskInfo)? onActionTap;
  final Function(TaskInfo)? onCancel;

  Widget _leading(TaskInfo task) {
    Widget item = const SizedBox();
    if (task.status == DownloadTaskStatus.undefined) {
      item = IconButton(
        splashRadius: 25,
        padding: EdgeInsets.zero,
        onPressed: () => onActionTap?.call(task),
        constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
        icon: const Icon(Icons.file_download),
        tooltip: 'Start',
      );
    } else if (task.status == DownloadTaskStatus.running) {
      item = Row(
        children: [
          IconButton(
            splashRadius: 25,
            padding: EdgeInsets.zero,
            onPressed: () => onActionTap?.call(task),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(Icons.pause, color: Colors.yellow),
            tooltip: 'Pause',
          ),
        ],
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      item = Row(
        children: [
          IconButton(
            splashRadius: 25,
            padding: EdgeInsets.zero,
            onPressed: () => onActionTap?.call(task),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(Icons.play_arrow, color: Colors.green),
            tooltip: 'Resume',
          ),
        ],
      );
    }
    if (task.status == DownloadTaskStatus.complete) {
      item = Icon(Icons.done_all, color: kPrimaryGreenColor);
    }
    return SizedBox(
      width: 40,
      height: 40,
      child: item,
    );
  }

  Widget _buildTrailing(TaskInfo task) {
    Widget item = const SizedBox(width: 10);
    if (task.status == DownloadTaskStatus.complete) {
      item = SizedBox(
        width: 40,
        child: IconButton(
          splashRadius: 25,
          padding: EdgeInsets.zero,
          onPressed: () => onActionTap?.call(task),
          constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
          icon: Icon(Icons.delete, color: kPrimaryRedColor.withOpacity(.8)),
          tooltip: "Delete",
        ),
      );
    }
    return item;
  }

  _onTap(TaskInfo task) {
    if (task.status == DownloadTaskStatus.complete) {
      onTap!(task);
    } else if (task.status == DownloadTaskStatus.undefined) {
      onActionTap?.call(task);
    } else {
      String message = "Noma'lum xato";
      if (task.status == DownloadTaskStatus.running) {
        message = 'Yuklab olinmoqda';
      } else if (task.status == DownloadTaskStatus.failed) {
        message = 'Yuklab olishda xatolik';
      } else if (task.status == DownloadTaskStatus.paused) {
        message = "Yuklash pause qilingan";
      }
      flash(message, kPrimaryGrey100Color, position: FlashPosition.bottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTap(data!.task!);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            _leading(data!.task!),
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            data!.name!,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (data!.task!.status == DownloadTaskStatus.running ||
                            data!.task!.status == DownloadTaskStatus.paused)
                          Text('${data!.task!.progress}%'),
                      ],
                    ),
                  ),
                  if (data!.task!.status == DownloadTaskStatus.running ||
                      data!.task!.status == DownloadTaskStatus.paused)
                    Positioned(
                      left: 0,
                      right: data!.task!.status == DownloadTaskStatus.complete
                          ? 50
                          : 0,
                      bottom: 10,
                      child: LinearProgressIndicator(
                        value: data!.task!.progress! / 100,
                      ),
                    )
                ],
              ),
            ),
            _buildTrailing(data!.task!)
          ],
        ),
      ),
    );
  }
}

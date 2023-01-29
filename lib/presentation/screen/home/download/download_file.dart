import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'download_class.dart';

class DownloadFile extends StatefulWidget {
  const DownloadFile({Key? key}) : super(key: key);

  @override
  State<DownloadFile> createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filesData.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.download),
          trailing: Icon(Icons.file_copy),
          title: Text(filesData[index].fileName),
          subtitle: Text("hello"),
          onTap: () => downloadFile(filesData[index].fileUrl),
        );
      },
    );
  }
  void downloadFile(String fileUrl) async {
    // Directory tempDir = await getTemporaryDirectory();
    // String path = tempDir.path;
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(fileUrl));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    // write the bytes to a file
  }
}
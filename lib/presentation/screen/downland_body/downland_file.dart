import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DownlandFile extends StatefulWidget {
  const DownlandFile({Key? key}) : super(key: key);

  @override
  State<DownlandFile> createState() => _DownlandFileState();
}

class _DownlandFileState extends State<DownlandFile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filesData.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            Dio dio = Dio();
            try {
              var dir = await getApplicationDocumentsDirectory();

              await dio.download(filesData[index].fileUrl, "${dir.path}/${filesData[index].fileName}.pdf",
                  onProgress: (rec, total) {
                    print("Rec: $rec , Total: $total");
                  });
            } catch (e) {
              print(e);
            }
          },
          child: Text(filesData[index].fileName),
        );
      },
    );
  }
}

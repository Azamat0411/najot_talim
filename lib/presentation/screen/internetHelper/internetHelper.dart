import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'connectivity_provider.dart';

typedef Builder = Widget Function(bool);

class InternetHelper extends StatefulWidget {
  final Builder builder;
  final Function? connect;

  const InternetHelper({Key? key, required this.builder, this.connect})
      : super(key: key);

  @override
  State<InternetHelper> createState() => _InternetHelperState();
}

class _InternetHelperState extends State<InternetHelper> {
  bool connect = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (!connect && model.isOnline) {
          if (widget.connect != null) {
            widget.connect!();
          }
        }
        connect = model.isOnline;
        return widget.builder(connect);
      },
    );
  }
}

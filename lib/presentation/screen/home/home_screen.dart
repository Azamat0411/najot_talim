import 'package:flutter/material.dart';
import 'package:najot_talim/core/constant/app_colors.dart';
import 'package:najot_talim/presentation/bloc/custom_bloc_consumer.dart';
import 'package:najot_talim/presentation/screen/home/bloc/bloc.dart';
import 'package:najot_talim/presentation/screen/home/bloc/states.dart';
import 'package:provider/provider.dart';

import '../downland_body/downland_file.dart';
import 'bloc/events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBloc<HomeBloc>(
        create: (context) => HomeBloc()..add(EventInitial()),
        listener: (context, _) {},
        builder: (blocContext, state) {
          return Scaffold(
            body: state is StateLoadPage ? _body(state) : Container(),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: blue,
              onTap: (index) {
                _onTap(blocContext, index);
              },
              items: const [
                BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
              ],
            ),
          );
        });
  }

  _body(StateLoadPage state) {
    return _currentPage[state.currentPage];
  }

  List get _currentPage => [
        Container(
          width: 50,
          height: 50,
          color: Colors.green,
        ),DownlandFile(),
        Container(
          width: 50,
          height: 50,
          color: Colors.blue,
        ),
      ];

  _onTap(BuildContext blocContext, int index) {
    Provider.of<HomeBloc>(blocContext, listen: false)
        .add(EventBottomClicked(currentPage: index));
  }
}

import 'package:flutter/material.dart';
import 'package:najot_talim/core/constant/app_colors.dart';
import 'package:najot_talim/presentation/bloc/custom_bloc_consumer.dart';
import 'package:najot_talim/presentation/component/text_widget.dart';
import 'package:najot_talim/presentation/screen/home/bloc/bloc.dart';
import 'package:najot_talim/presentation/screen/home/bloc/states.dart';
import 'package:najot_talim/presentation/screen/home/country/country_page.dart';
import 'package:najot_talim/presentation/screen/home/download/download_file.dart';
import 'package:provider/provider.dart';

import 'bloc/events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBloc<HomeBloc>(
        create: (context) => HomeBloc()..add(EventInitial()),
        listener: (context, _) {},
        builder: (blocContext, state) {
          return state is StateLoadPage
              ? Scaffold(
                  appBar: _appBar(state),
                  body: _body(state),
                  bottomNavigationBar: _bottomNavBar(state, blocContext))
              : Container();
        });
  }

  _appBar(StateLoadPage state) {
    return AppBar(
      title: TextWidget(
          text: _title[state.currentPage],
          textColor: kPrimaryWhiteColor,
          fontWeight: FontWeight.w600,
          fontSize: 20),
    );
  }

  _bottomNavBar(StateLoadPage state, BuildContext blocContext) {
    return BottomNavigationBar(
      backgroundColor: blue,
      onTap: (index) {
        _onTap(blocContext, index);
      },
      selectedItemColor: kPrimaryWhiteColor,
      currentIndex: state.currentPage,
      items: const [
        BottomNavigationBarItem(label: 'API', icon: Icon(Icons.dataset)),
        BottomNavigationBarItem(label: 'FILE DOWNLOAD', icon: Icon(Icons.file_download)),
        BottomNavigationBarItem(label: 'FIREBASE', icon: Icon(Icons.dataset)),
      ],
    );
  }

  _body(StateLoadPage state) {
    return _currentPage[state.currentPage];
  }

  List get _title => ['API call and caching', 'File download', 'Card'];

  List get _currentPage => [
        const CountryPage(),
        const DownloadFile(),
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

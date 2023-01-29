import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  // ---------------------------------------------------------------------------
  HomeBloc() : super(StateLoadPage(currentPage: 0)) {
    on<EventInitial>((event, emit) {
      emit(StateLoadPage(currentPage: 0));
    });
    on<EventBottomClicked>((event, emit){
      emit(StateLoadPage(currentPage: event.currentPage));
    });
  }
}

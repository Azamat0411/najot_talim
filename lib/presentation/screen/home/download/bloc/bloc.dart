import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'states.dart';

class DownloadBloc extends Bloc<DownloadEvents, DownloadStates> {
  // ---------------------------------------------------------------------------
  DownloadBloc() : super(StateLoadPage(currentPage: 0)) {
    on<EventInitial>((event, emit) {
      emit(StateLoadPage(currentPage: 0));
    });
  }
}

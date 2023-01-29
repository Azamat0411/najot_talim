import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najot_talim/entities/card_model.dart';

import '../../../../../domain/api_client.dart';
import '../../../../../domain/firebase_repostory.dart';
import '../widget.dart';

part 'card_event.dart';

part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<AddCard>(_onAddTask);
    on<LoadingEvent>(_onGetCard);
  }

  void _onGetCard(LoadingEvent event, Emitter<CardState> emit) async {
    emit(CardLoading());
    String id = '';
    await initPlatformState().then((value) => id = value['id']);
    await FireStoreRepository.get(id).then((value) {
      emit(CardLoaded(cards: value, id: id));
      (error, stackTrace){
        emit(CardException());
      };
    });
  }

  void _onAddTask(AddCard event, Emitter<CardState> emit) async {
    bool result = await ApiClient.addCard(event.cardModel);
    emit(CardLoading());
    if (result) {
      // emit(CardLoaded());
    } else {
      emit(CardException());
    }
  }
}

Future<Map<String, dynamic>> initPlatformState() async {

  final deviceInfoPlugin = DeviceInfoPlugin();

  var deviceData = <String, dynamic>{};
  try {
    deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
  } on PlatformException {
    deviceData = <String, dynamic>{
      'Error:': 'Failed to get platform version.'
    };
  }

  print('sssssss $deviceData');

  return deviceData;
}

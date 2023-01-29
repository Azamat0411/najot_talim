import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:najot_talim/entities/card_model.dart';

import '../../../../domain/api_client.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<AddCard>(_onAddTask);
  }
  void _onAddTask(AddCard event, Emitter<CardState> emit) async{
  bool result= await ApiClient.addCard(event.cardModel);
  emit(CardLoading());
  if(result){
    emit(CardLoaded());
  }else{
    emit(CardException());
  }
  }
}

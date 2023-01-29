import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najot_talim/entities/card_model.dart';

import '../../../../../domain/api_client.dart';

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

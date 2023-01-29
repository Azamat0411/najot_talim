part of 'card_bloc.dart';

abstract class CardEvent {
  CardEvent();}

class LoadingEvent extends CardEvent{
}

class AddCard extends CardEvent {
  final CardModel cardModel;

  AddCard({
    required this.cardModel,
  });
}

class UpdateTask extends CardEvent {
  final CardModel cardModel;

  UpdateTask({
    required this.cardModel,
  });
}

class RemoveTask extends CardEvent {
  final CardModel cardModel;

  RemoveTask({
    required this.cardModel,
  });
}

class DeleteTask extends CardEvent {
  final CardModel cardModel;

  DeleteTask({
    required this.cardModel,
  });
}

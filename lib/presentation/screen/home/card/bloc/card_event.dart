part of 'card_bloc.dart';

abstract class CardEvent {
  CardEvent();}

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

  // firebaseFirestore.collection(GetStorage().read("email")).doc(cardModel.id).update(cardModel.toMap());

  @override
  List<Object> get props => [cardModel];
}

class RemoveTask extends CardEvent {
  final CardModel cardModel;

  RemoveTask({
    required this.cardModel,
  });

  @override
  List<Object> get props => [cardModel];
}

class DeleteTask extends CardEvent {
  final CardModel cardModel;

  DeleteTask({
    required this.cardModel,
  });

  @override
  List<Object> get props => [cardModel];
}

part of 'card_bloc.dart';

abstract class CardState {}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  List<CardModel> cards;
  String id;

  CardLoaded({required this.cards, required this.id});
}

class CardException extends CardState {}

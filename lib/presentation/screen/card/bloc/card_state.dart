part of 'card_bloc.dart';

@immutable
abstract class CardState {}

class CardInitial extends CardState {}
class CardLoading extends CardState {}
class CardLoaded extends CardState {}
class CardException extends CardState {}


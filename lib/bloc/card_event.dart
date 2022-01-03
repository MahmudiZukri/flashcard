part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();
}

class GetCard extends CardEvent {
  final String userID;

  const GetCard(this.userID);

  @override
  List<Object> get props => [userID];
}

class AddCard extends CardEvent {
  final String userID;
  final CardModel card;

  const AddCard(this.userID, this.card);

  @override
  List<Object?> get props => [userID, card];
}

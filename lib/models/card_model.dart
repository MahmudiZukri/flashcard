part of 'models.dart';

class CardModel {
  final int id;
  final String question, answer;
  double intervals, easefactor;
  int repetitions;

  CardModel({
    required this.id,
    required this.question,
    required this.answer,
    this.repetitions = 0,
    this.intervals = 0,
    this.easefactor = 0,
  });
}

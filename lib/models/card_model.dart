part of 'models.dart';

class CardModel extends Equatable {
  // final int id;
  final String question, answer;
  final double intervals, easefactor;
  final int repetitions;

  const CardModel({
    // required this.id,
    required this.question,
    required this.answer,
    this.repetitions = 0,
    this.intervals = 0,
    this.easefactor = 0,
  });

  @override
  List<Object?> get props =>
      [question, answer, repetitions, intervals, easefactor];
}

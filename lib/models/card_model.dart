part of 'models.dart';

class CardModel extends Equatable {
  // final int id;
  final String question, answer;
  final int repetitions;
  final double intervals, easeFactor;

  const CardModel({
    // required this.id,
    required this.question,
    required this.answer,
    this.repetitions = 0,
    this.intervals = 0,
    this.easeFactor = 0,
  });

  CardModel copyWith(
          {required int repetitions,
          required double intervals,
          required double easeFactor}) =>
      CardModel(
          question: question,
          answer: answer,
          repetitions: repetitions,
          intervals: intervals,
          easeFactor: easeFactor);

  @override
  List<Object?> get props =>
      [question, answer, repetitions, intervals, easeFactor];
}

part of 'models.dart';

class CardModel extends Equatable {
  // final int id;
  final String question, answer;
  final int repetitions, intervals;
  final double easeFactor;
  final DateTime reviewedDate;

  const CardModel(
      {
      // required this.id,
      required this.question,
      required this.answer,
      this.repetitions = 0,
      this.intervals = 0,
      this.easeFactor = 0,
      required this.reviewedDate});

  CardModel copyWith(
          {required int repetitions,
          required int intervals,
          required double easeFactor,
          required DateTime reviewedDate}) =>
      CardModel(
          question: question,
          answer: answer,
          repetitions: repetitions,
          intervals: intervals,
          easeFactor: easeFactor,
          reviewedDate: reviewedDate);

  @override
  List<Object?> get props =>
      [question, answer, repetitions, intervals, easeFactor, reviewedDate];
}

part of 'models.dart';

class CardModel {
  final int id;
  final String question, answer;

  const CardModel(
      {required this.id, required this.question, required this.answer});
}

const List sampleData = [
  {"question": "question1", "answer": "answer1"},
  {"question": "question2", "answer": "answer2"},
  {"question": "question3", "answer": "answer3"}
];

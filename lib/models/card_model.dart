part of 'models.dart';

class CardModel {
  final String question;
  final String answer;
  final Color color;

  const CardModel(
      {required this.question, required this.answer, required this.color});

  static const dummyCard = [
    CardModel(
        question: "Siapakah nama tokoh utama anime SAO",
        answer: "Kirigaya Kazuto",
        color: Colors.blue),
    CardModel(
        question: "Siapakah nama tokoh utama anime Seirei Geisuki",
        answer: "Rio",
        color: Colors.green)
  ];
}

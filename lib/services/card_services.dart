part of 'services.dart';

class FlashcardServices {
  static final CollectionReference<Map<String, dynamic>> _flashcardCollection =
      FirebaseFirestore.instance.collection('flashcard');

  static Future<void> saveFlashcard(String userID, CardModel flashcard) async {
    await _flashcardCollection.doc().set({
      'userID': userID,
      // 'flashcardID': flashcard.id,
      'question': flashcard.question,
      'answer': flashcard.answer,
      'repetitions': flashcard.repetitions,
      'intervals': flashcard.intervals,
      'easefactor': flashcard.easefactor
    });
  }

  static Future<List<CardModel>> getFlashcard(String userID) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _flashcardCollection.get();

    var documents =
        snapshot.docs.where((doc) => doc.data()['userID'] == userID);

    List<CardModel> flashcards = [];

    for (var document in documents) {
      flashcards.add(CardModel(
          // id: document.data()['userID'],
          question: document.data()['question'],
          answer: document.data()['answer'],
          repetitions: document.data()['repetitions'],
          intervals: document.data()['intervals'],
          easefactor: document.data()['easefactor']));
    }
    return flashcards;
  }
}

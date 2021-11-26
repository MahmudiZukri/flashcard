part of 'extensions.dart';

extension FirebaseUserExtension on User {
  FlashcardUser convertToFlashcardUser({String name = "No Name"}) =>
      FlashcardUser(uid, email, name: name);
}

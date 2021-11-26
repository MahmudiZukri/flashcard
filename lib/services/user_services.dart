part of 'services.dart';

class UserServices {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(FlashcardUser user) async {
    _userCollection.doc(user.id).set({'email': user.email, 'name': user.name});
  }
}

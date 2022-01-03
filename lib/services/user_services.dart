part of 'services.dart';

class UserServices {
  static final CollectionReference<Map<String, dynamic>> _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(FlashcardUser user) async {
    await _userCollection
        .doc(user.id)
        .set({'email': user.email, 'name': user.name});
  }

  static Future<FlashcardUser> getUser(String userID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _userCollection.doc(userID).get();

    return FlashcardUser(userID, snapshot.data()!['email'],
        name: snapshot.data()!['name']);
  }
}

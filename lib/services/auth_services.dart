part of 'services.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FlashcardUser user = result.user!.convertToFlashcardUser(name: name);

      //masukin ke firebase
      await UserServices.addUser(user);

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }
}

class SignInSignUpResult {
  final FlashcardUser? user;
  final String? message;

  const SignInSignUpResult({this.user, this.message});
}

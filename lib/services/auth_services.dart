part of 'services.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //uid & email otomatis masuk
      FlashcardUser user = result.user!.convertToFlashcardUser(name: name);

      //masukin ke firebase
      await UserServices.addUser(user);

      return SignInSignUpResult(user: user);
    } on FirebaseException catch (e) {
      return SignInSignUpResult(message: e.message);
    } on PlatformException catch (e) {
      return SignInSignUpResult(message: e.message);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //uid > fromFirestore <> getUser
      FlashcardUser user = await result.user!.fromFirestore();

      return SignInSignUpResult(user: user);
    } on FirebaseException catch (e) {
      return SignInSignUpResult(message: e.message);
    } on PlatformException catch (e) {
      return SignInSignUpResult(message: e.message);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<User?> get userStream => _auth.authStateChanges();
  // static Stream<User?> get userStream => _auth.userChanges();
}

class SignInSignUpResult {
  final FlashcardUser? user;
  final String? message;

  const SignInSignUpResult({this.user, this.message});
}

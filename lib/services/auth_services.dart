part of 'services.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static final googleSignIn = GoogleSignIn();

  static GoogleSignInAccount? _googleUser;
  GoogleSignInAccount get googleUser => _googleUser!;

  static Future<SignInSignUpResult> googleLogin() async {
    try {
      GoogleSignInAccount? gUser = await googleSignIn.signIn();
      if (gUser == null) return SignInSignUpResult(message: 'User Kosong');
      _googleUser = gUser;

      GoogleSignInAuthentication googleAuth = await gUser.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential result = await _auth.signInWithCredential(credential);

      //uid & email otomatis masuk
      FlashcardUser user = result.user!
          .convertToFlashcardUser(name: result.user?.displayName ?? 'No Name');

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
    if (googleSignIn.currentUser != null) {
      googleSignIn.disconnect();
    }
    await _auth.signOut();
  }

  static Future<SignInSignUpResult> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return SignInSignUpResult();
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(']')[1].trim());
    }
  }

  static Stream<User?> get userStream => _auth.authStateChanges();
  // static Stream<User?> get userStream => _auth.userChanges();
}

class SignInSignUpResult {
  final FlashcardUser? user;
  final String? message;

  const SignInSignUpResult({this.user, this.message});
}

import 'package:google_sign_in/google_sign_in.dart';
import 'package:vet_app/core/constants/enums.dart';
import 'package:vet_app/core/models/user.dart';
import 'package:vet_app/core/view/base/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../service_locator.dart';

class Auth extends BaseProvider {
  auth.FirebaseAuth _auth;
  auth.User _user;
  Status _status = Status.Uninitialized;
  GoogleSignIn googleSignIn = GoogleSignIn();
  var userData = sl<User>();

  bool _emailVerified = false;
  bool get emailVerified => _emailVerified;
  set emailVerified(_verified) {
    _emailVerified = _verified;
    if (isMounted) notifyListeners();
  }

  void initialize() {
    _auth = auth.FirebaseAuth.instance;
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;
  set status(Status newStatus) {
    _status = newStatus;
    if (isMounted) notifyListeners();
  }

  auth.User get user => _user;

  bool isAuth() => status == Status.Authenticated;

  bool isLoading() => status == Status.Authenticating;

  Future<bool> signIn(String email, String password) async {
    status = Status.Authenticating;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      // _dialogService.basicDialog(
      //   iconData: FontAwesomeIcons.userAltSlash,
      //   title: ConstString.SINGIN_ERROR_TEXT[e.code] ?? e.code,
      // );

      status = Status.Unauthenticated;

      return false;
    }
    status = Status.Authenticated;
    return true;
  }

  Future<bool> signUp(String email, String password, String nick) async {
    status = Status.Authenticating;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      status = Status.Unauthenticated;
      return false;
    }
    // await dbService.createUser(user.uid, nick);
    return true;
  }

  Future signOut() async {
    try {
      String uid = _auth.currentUser?.uid;
      if (userData.signInType == SignInType.Google) {
        await signOutGoogle();
      }
      await _auth.signOut();
      status = Status.Unauthenticated;
      userData.clearUser();
    } catch (e) {
      logger.e(e);
    }
  }

  Future signOutGoogle() async {
    try {
      await googleSignIn.signOut();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<bool> signInWithGoogle() async {
    status = Status.Authenticating;

    try {
      final GoogleSignInAccount googleUser =
          await GoogleSignIn().signIn().catchError((onError) {
        logger.e(onError);
      });

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final auth.GoogleAuthCredential credential =
          auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      auth.UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      logger.d('Is new user : ' +
          userCredential.additionalUserInfo.isNewUser.toString());
    } on auth.FirebaseAuthException catch (e) {
      status = Status.Unauthenticated;
      // _dialogService.basicDialog(
      //   iconData: FontAwesomeIcons.userAltSlash,
      //   title: ConstString.CREDENTIAL_ERROR_TEXT[e.code] ?? e.code,
      // );
      logger.e(e);
      return false;
    } catch (e) {
      status = Status.Unauthenticated;
      // _dialogService.basicDialog(
      //   iconData: FontAwesomeIcons.userAltSlash,
      //   title: "Google ile giriş yapılırken bir hata oluştu!",
      // );
      logger.e(e);
      return false;
    }
    status = Status.Authenticated;
    return true;
  }

//   Future<bool> resetPassword(String email) async {
//     status = Status.Authenticating;
//     List<String> signInMethods;
//     try {
//       signInMethods = await _auth.fetchSignInMethodsForEmail(email);
//     } on auth.FirebaseAuthException catch (e) {
//       status = Status.Unauthenticated;
//       if (["ınvalıd-emaıl", "invalid-email"].contains(e.code)) {
//         _dialogService.basicDialog(
//             iconData: FontAwesomeIcons.userAlt,
//             title: "Geçersiz E-mail adresi");
//       }
//       logger.e(e);
//       return false;
//     }

//     if (signInMethods?.contains("password") ?? false) {
//       try {
//         await _auth.sendPasswordResetEmail(email: email);
//       } catch (e) {
//         status = Status.Unauthenticated;
//         _dialogService.basicDialog(
//             iconData: FontAwesomeIcons.exclamationTriangle,
//             title: "Mail gönderilirken bir hata oluştu");
//         return false;
//       }
//       status = Status.Unauthenticated;
//       _dialogService.infoDialog(
//         iconData: FontAwesomeIcons.envelopeOpenText,
//         description:
//             'Şifre sıfırlama maili "$email" mail adresine gönderilmiştir',
//       );
//       return true;
//     } else if (signInMethods?.contains("google.com") ?? false) {
//       status = Status.Unauthenticated;
//       _dialogService.basicDialog(
//           iconData: FontAwesomeIcons.exclamationTriangle,
//           title:
//               "Google ile giriş yaptığınız için herhangi bir şifreniz bulunmuyor");
//       return false;
//     } else if (signInMethods?.contains("apple.com") ?? false) {
//       status = Status.Unauthenticated;
//       _dialogService.basicDialog(
//           iconData: FontAwesomeIcons.exclamationTriangle,
//           title:
//               "Apple ile giriş yaptığınız için herhangi bir şifreniz bulunmuyor");
//       return false;
//     }
//     _dialogService.basicDialog(
//         iconData: FontAwesomeIcons.userAlt, title: "Geçersiz E-mail adresi");
//     status = Status.Unauthenticated;
//     return false;
//   }

  bool _singInMethodCall = false;
  Future<void> _onAuthStateChanged(auth.User firebaseUser) async {
    if (firebaseUser == null) {
      _singInMethodCall = false;
      status = Status.Unauthenticated;
    } else {
      if (_auth.currentUser == null || !_singInMethodCall) {
        _user = firebaseUser;
        _emailVerified = _user.emailVerified;
        _user.getIdTokenResult(true).then((value) {
          switch (value.signInProvider) {
            case 'google.com':
              userData.signInType = SignInType.Google;
              break;
            case 'password':
            default:
              userData.signInType = SignInType.Email;
              break;
          }
        });

        userData.email = user.email;
        userData.uid = _user.uid;
        _singInMethodCall = true;
        status = Status.Authenticated;
      }
    }
  }
}

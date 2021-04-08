import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart'; // add itt to pubspec as well

Future<bool> login(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Alert(context: context, title: 'ERROR', desc: 'The password is weak').show();
      //print('password is weak');
    } else if (e.code == 'email-already-in-use') {
      Alert(context: context, title: 'ERROR', desc: 'The email is already in use').show();
      print('Enter new email Id');
    }
    return false;
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<bool> logOut() async {
  await FirebaseAuth.instance.signOut();
  return true;
}

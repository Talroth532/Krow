import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Widgets/auth_form.dart';
import '../Providers/User.dart';

class AuthScreen extends StatefulWidget {
  static const routName = '/AuthScreen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  // void _submitAuthForm(
  //   String email,
  //   String password,
  //   String username,
  //   String phone,
  //   File image,
  //   bool isLogin,
  //   BuildContext ctx,
  // ) async {
  //   AuthResult authresult;
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     if (isLogin) {
  //       authresult = await _auth.signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //     } else {
  //       authresult = await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );

  //       final ref = FirebaseStorage.instance
  //           .ref()
  //           .child('user_image')
  //           .child(authresult.user.uid + '.jpg');

  //       await ref.putFile(image).onComplete;

  //       await Firestore.instance
  //           .collection('users')
  //           .document(authresult.user.uid)
  //           .setData({
  //         'email': email,
  //         'username': username,
  //         'phone': phone,
  //       });
  //     }
  //   } on PlatformException catch (err) {
  //     var message = 'An error occured, plese check your credentials';

  //     if (err.message != null) {
  //       message = err.message;
  //     }

  //     Scaffold.of(ctx).showSnackBar(
  //       SnackBar(
  //         content: Text(message),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } catch (err) {
  //     print(err);
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Function _submitAuthForm = Provider.of<User>(context).submitAuthForm;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}

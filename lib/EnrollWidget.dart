import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'UserBuilder.dart';
import 'UserDetail.dart';


class EnrollWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EnrollWidget();
  }

}
class _EnrollWidget extends State<StatefulWidget>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  Future<void> _checkEmail(enroll_email, enroll_password) async {
    try {
      print("어디까지되나1");
      UserCredential enrollUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: enroll_email, password: enroll_password).
      then((value) {
        if (value.user!.email == null) {
          print("어디까지되나1");
        }
        else {
          print("어디까지되나1");
          Navigator.pop(context);
        }
        print("어디까지되나1");
        return value;
      });
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('the password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('the account already exists for that email');
      } else {
        print(e.code);
      }
    }
    catch (e) {
      print('끝');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text("회원가입"),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(16, 52, 0, 0),
                              child: Text("회원가입",
                                  style: TextStyle(
                                      fontSize: 28, fontWeight: FontWeight.bold)
                              )
                          ),
                          Container(
                              margin: EdgeInsets.all(16),
                              child: TextFormField(
                                controller: _idController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    label: Text("id",
                                        style: TextStyle(color: Colors.red))
                                ),
                              )
                          ),
                          Container(
                              margin: EdgeInsets.all(16),
                              child: TextFormField(
                                controller: _pwController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    label: Text("pw",
                                        style: TextStyle(color: Colors.red))
                                ),
                              )
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  child: ElevatedButton(
                                      onPressed: () => _checkEmail(_idController.text,_pwController.text),
                                      child: Text("회원가입",
                                          style: TextStyle(color: Colors.white)
                                      )
                                  )
                              )
                          )
                        ])
                )
            )
        )
    );
  }
}
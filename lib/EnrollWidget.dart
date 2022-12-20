import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'UserBuilder.dart';
import 'UserDetail.dart';

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

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
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  int _genderController = 0;
  bool isMale = false;
  bool isFemale = false;
  bool isUnselect = false;
  late List<bool> isSelected = [isMale,isFemale,isUnselect];
  Future<void> _checkEmail(UserDetail newUser) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: newUser.id, password: newUser.password).
      then((value) {
        if (value.user!.email == null) {
        }
        else {
          Map<String,dynamic> data = {
            'id':newUser.id,
            'nickname':newUser.nickname,
            'semesterstudytime':0,
            'dailystudytime':0
          };
          if(newUser.gender != null) data['gender'] = newUser.gender;
          if(newUser.university != null) data['university'] = newUser.university;
          if(newUser.major != null) data['major'] = newUser.major;
          if(newUser.grade != null) data['grade'] = newUser.grade;
          firestore.collection('UserData').doc(auth.currentUser!.uid).set(data);
          Navigator.pop(context);
        }
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
  void toggleSelect(value){
    if(value==0){
      isMale = true;
      isFemale = false;
      isUnselect = false;
      _genderController = 1;
    }
    else if(value == 1){
      isMale = false;
      isFemale = true;
      isUnselect = false;
      _genderController = 2;
    }
    else{
      isMale = false;
      isFemale = false;
      isUnselect = true;
      _genderController = 0;
    }
    setState((){
      isSelected = [isMale,isFemale,isUnselect];
    });
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
                          Container(
                              margin: EdgeInsets.all(16),
                              child: TextFormField(
                                controller: _nicknameController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    label: Text("nickname",
                                        style: TextStyle(color: Colors.red))
                                ),
                              )
                          ),
                          Container(
                              margin: EdgeInsets.all(16),
                              child: TextFormField(
                                controller: _universityController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    label: Text("university",
                                        style: TextStyle(color: Colors.red))
                                ),
                              )
                          ),
                          Container(
                              margin: EdgeInsets.all(16),
                              child: TextFormField(
                                controller: _gradeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    label: Text("grade",
                                        style: TextStyle(color: Colors.red))
                                ),
                              )
                          ),
                          Container(
                              margin: EdgeInsets.all(16),
                              child: TextFormField(
                                controller: _majorController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    label: Text("major",
                                        style: TextStyle(color: Colors.red))
                                ),
                              )
                          ),
                          ListTile(
                            leading: Container(
                              child: Text("성별 : "),
                            ),
                            title: ToggleButtons(
                              isSelected: isSelected,
                              onPressed: toggleSelect,
                              children: [
                                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('male')),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('female')),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('선택 안함'))
                              ],
                            ),

                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        UserBuilder enrollUserData = UserBuilder(_idController.text, _pwController.text, _nicknameController.text);
                                        if(_majorController.text != ""){
                                          enrollUserData = enrollUserData.setMajor(_majorController.text);
                                        }
                                        if(_gradeController.text != ""){
                                          enrollUserData = enrollUserData.setGrade(int.parse(_gradeController.text));
                                        }
                                        if(_universityController.text != ""){
                                          enrollUserData = enrollUserData.setUniversity(_universityController.text);
                                        }if(_majorController.text != ""){
                                          enrollUserData = enrollUserData.setMajor(_majorController.text);
                                        }if(_genderController != 0){
                                          enrollUserData = enrollUserData.setGender(_genderController);
                                        }
                                        print(_idController.text);
                                        print(_pwController.text);
                                        print(_nicknameController.text);
                                        print(_majorController.text);
                                        print(_gradeController.text);
                                        print(_universityController.text);
                                        print(_genderController.toString());
                                        UserDetail newUser = UserDetail(enrollUserData);
                                        _checkEmail(newUser);
                                        },
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
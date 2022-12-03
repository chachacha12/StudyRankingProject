import 'package:flutter/material.dart';
import 'package:studyrankingproject/LoginWedget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  /*
  UserBuilder test2 = UserBuilder("idTest", "passwordTest", "nicknameTest");
  User test = User(test2.setGrade(3).setMajor("majorTest").setUniversity("universityTest").setGender(1));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  readData();
  */
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginWidget(),
    );
  }
}


void readData(){
  final userCollectionReference = FirebaseFirestore.instance.collection("UserData").doc("uKM3J5yhIbIR0s5db3Mt");
  userCollectionReference.get().then((value)=>{
    print(value.data()!['id']),
    print(value.data()!['password']),
    print(value.data()!['nickname']),
    print(value.data()!['university']),
    print(value.data()!['major']),
    print(value.data()!['grade']),
    print(value.data()!['gender'])
  });
  // 테스트를 위한 함수.
}

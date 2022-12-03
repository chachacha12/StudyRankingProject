import 'package:studyrankingproject/UserBuilder.dart';

class User{
  late String _id;
  late String _password;
  late String _nickname;
  String? _university;
  String? _major;
  int? _grade;
  int? _gender;

  User(UserBuilder builder){
    _id = builder.id;
    _password = builder.password;
    _nickname = builder.nickname;
    _university = builder.university;
    _major = builder.major;
    _grade = builder.grade;
    _gender = builder.gender;
  }
  get id => _id;
  get password => _password;
  get nickname => _nickname;
  get university => _university;
  get major => _major;
  get grade => _grade;
  get gender => _gender;
}
class UserBuilder{
  late String _id;
  late String _password;
  late String _nickname;
  String? _university;
  String? _major;
  int? _grade;
  int? _gender;
  UserBuilder(String id, String password, String nickname){
    _id = id;
    _password = password;
    _nickname = nickname;
  }
  UserBuilder setUniversity(String university){
    _university = university;
    return this;
  }
  UserBuilder setMajor(String major){
    _major = major;
    return this;
  }
  UserBuilder setGrade(int grade){
    _grade = grade;
    return this;
  }
  UserBuilder setGender(int gender){
    _gender = gender;
    return this;
  }

  String get id => _id;
  String get password => _password;
  String get nickname => _nickname;
  String? get university => _university;
  String? get major => _major;
  int? get grade => _grade;
  int? get gender => _gender;

}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyrankingproject/RankingWidget.dart';

class SemesterRanking implements Ranking{
  late List _rankerList;
  @override
  Future<void> updateRankerList() async {
    List temp = [];
    final querySnapshot = await FirebaseFirestore.instance.collection("UserData").orderBy("semesterstudytime").limit(20).get();
    for (var doc in querySnapshot.docs) {
      //print(doc["nickname"].toString());
      //print(doc["dailystudytime"]);
      String tempNick = await doc["nickname"];
      int tempTime = await doc["dailystudytime"];
      temp.add([tempNick,tempTime]);
      //print(doc["nickname"]);
      if(doc == querySnapshot.docs.last){
        _rankerList = temp;
      }
    }
  }
  @override
  Future<QuerySnapshot<Object?>> getUpdateRankerList() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("UserData").orderBy("semesterstudytime").limit(20).get();

    return querySnapshot;
  }

  @override
  String getWhichRanking(){
    return "Semester";
  }
  @override
  get rankerList => _rankerList;
}
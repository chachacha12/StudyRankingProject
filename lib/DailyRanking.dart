import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyrankingproject/RankingWidget.dart';
import 'package:studyrankingproject/UserDetail.dart';

class DailyRanking implements Ranking{
  late List _rankerList;
  @override
  Future<void> updateRankerList() async {
    List temp = [];
    final rankerReference = await FirebaseFirestore.instance.collection("UserData").orderBy("dailystudytime").limit(20).get();
    for (var doc in rankerReference.docs) {
      //print(doc["nickname"].toString());
      //print(doc["dailystudytime"]);
      String tempNick = await doc["nickname"];
      int tempTime = await doc["dailystudytime"];
      temp.add([tempNick,tempTime]);
      print(doc["nickname"]);
      if(doc == rankerReference.docs.last){
        _rankerList = temp;
      }
    }

    print(_rankerList);
  }
  @override
  String getWhichRanking(){
    return "Daily";
  }
  @override
  get rankerList => _rankerList;
}
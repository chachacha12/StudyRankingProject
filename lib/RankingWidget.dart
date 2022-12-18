import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studyrankingproject/DailyRanking.dart';
import 'package:studyrankingproject/SemesterRanking.dart';

import 'UserDetail.dart';


class StudyRanking extends StatefulWidget {
  const StudyRanking({Key? key}) : super(key: key);
  @override
  State<StudyRanking> createState() => _StudyRankingState();
}

class _StudyRankingState extends State<StudyRanking> {
  @override
  final List<Ranking> _list = [SemesterRanking(),DailyRanking()];
  int _index = 0;
  Widget build(BuildContext context) {
    var temp = FirebaseAuth.instance.currentUser!.uid.toString();
    print(temp);
    _list[_index].updateRankerList();
    print("${_list[_index].rankerList}외부값확인");
    return Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 32, 0, 32),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 100,vertical: 10),
                child: Text(_list[_index].getWhichRanking(),
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 100,vertical: 10),
                child: Text("Ranking",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )
            ),
            Container(
              height: 500,
              width: 340,
              child:SingleChildScrollView(
                  child:Column(
                    children: [
                      for(int i=1;i<21;i++)
                        Container(
                          decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                          height: 80, width: 340,
                          child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  child:Text("$i",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
                                ),
                                Container(
                                  child: Text(_list[_index].rankerList.length.toString()),
                                )
                              ]
                            )
                          )
                    ],
                  )
                )
            ),
            Container(
              child: TextButton(
                child: Text("${_list[1-_index].getWhichRanking()} Ranking",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
                ),
                onPressed: () {
                  setState((){
                    _index = 1-_index;
                  });
                },
              ),
            )
          ],
        )
    );
  }
}

abstract class Ranking{
  late List _rankerList;
  Future<void> updateRankerList();
  String getWhichRanking();
  get rankerList => _rankerList;
}
/*

자 정리를 해봅시다.
RankingWidget
_RankingWidgetState<<여기서 호출할 것들.
Ranking을 받는 Semester Ranking, DailyRanking이런식으로..? 하면 될수도?


*/


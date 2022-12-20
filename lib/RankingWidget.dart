import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studyrankingproject/DailyRanking.dart';
import 'package:studyrankingproject/SemesterRanking.dart';



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
    var nickname;
    var studyTime;
    FirebaseFirestore.instance.collection("UserData").doc(temp).get().then(
            (DocumentSnapshot ds){
          nickname = ds.get("nickname");
          studyTime = ds.get("${_list[_index].getWhichRanking().toLowerCase()}studytime");
          print(nickname);
          print(studyTime);
        });
    return Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 60,vertical: 10),
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
                height: 450,
                width: 350,
                child:StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("UserData").orderBy("${_list[_index].
                  getWhichRanking().toLowerCase()}studytime",descending:true ).limit(20).snapshots(),
                  builder: (context, snapshot) {
                    final items = snapshot.data?.docs;
                    if(items ==null){
                      return Container();
                    }
                    else {return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index){
                        final item =items[index];
                        return Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey)),
                            ),
                            child:ListTile(
                              leading: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child:Text("${index+1})",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                                    ,)
                              ),
                              title: Text(item["nickname"],style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                              subtitle: Text(item["${_list[_index].getWhichRanking().toLowerCase()}studytime"].toString()+"분"
                                  ,style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)
                              ),
                            )
                        );
                      },
                    );
                    }
                  },
                )
            ),

            FutureBuilder(
                future: FirebaseFirestore.instance.collection("UserData").doc(temp).get(),
                builder: (context, snapshot) {
                  if(nickname == null){
                    return ListTile(
                      leading: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child:Text("You",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                      ),
                      title: Text("nickname",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      subtitle: Text("0분"
                          ,style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)
                      ),
                    );
                  }
                  else{
                    return Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey), top: BorderSide(color: Colors.grey)),
                        ),
                        child : ListTile(
                          leading: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child:Text("You",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                          ),
                          title: Text(nickname,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                          subtitle: Text("$studyTime분"
                              ,style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)
                          ),
                        )
                    );
                  }
                }
            ),

            Container(
              height: 60,
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
  String getWhichRanking();
}

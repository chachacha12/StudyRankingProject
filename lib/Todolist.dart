import 'package:flutter/material.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

//누적공부시간과 일일 공부시간을 잠시 저장할 변수
var dailystudytime;
var semesterstudytime;

class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {

  List todos = [];
  List check_color = [];  //완료된 리스트인지 체크
  String input = "";



  //사용자가 입력한 공부시간 텍스트필드값 받아오기 위함
  var inputData = TextEditingController();

  //누적공부시간 일일 공부시간 데이터 가져오기
  getData() async {
    var result = await firestore.collection('UserData').doc('pARtPJpHyCo4JYmdm22A').get();
    print(result['dailystudytime']);
    print(result['semesterstudytime']);

    //공부한 시간값들 가져옴
    dailystudytime = result['dailystudytime'];
    semesterstudytime = result['semesterstudytime'];
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("공부할 내용을 입력하세요."),
                    content: TextField(
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(onPressed: (){
                        setState(() {
                          todos.add(input);
                          check_color.add(Colors.grey);
                        });
                        Navigator.of(context).pop();	// input 입력 후 창 닫히도록
                      },
                          child: Text("Add"))
                    ]
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title:  Text('TodoList',
                textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),),

             /*
              background: Image.asset(
                'assets/todolist.png',
                fit: BoxFit.fill,),
              */
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    GestureDetector(
                      child: Card( //리스트 속 각각의 객체 하나하나임
                          elevation: 1,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),

                          child:ListTile(
                            title: Text(todos[index]),
                            leading: Icon(          //완료된 것인지 나타내는 체크아이콘
                              Icons.check,
                              color: check_color[index],
                            ),
                            trailing: IconButton(icon: Icon(  //삭제버튼
                              Icons.delete,
                              color: Colors.red,
                            ), onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                              });
                            },),
                          )
                      ),
                      onTap: () {//리스트 클릭시
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text("공부를 완료했나요?"),
                                  content: TextField(controller: inputData,
                                  keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        labelText: '공부 시간 입력',
                                        helperText: '시간, 분 형식으로 작성하세요',
                                        hintText: '00:00',  //글자를 입력하면 사라진다.
                                        icon: Icon(Icons.timer),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(3)
                                    ),

                              ),
                                  actions: <Widget>[
                                    FlatButton(onPressed: (){
                                      setState(() {
                                        check_color[index] = Colors.blue;  //공부시간 입력후엔 체크버튼 색상 변경

                                        var hour_min = inputData.text.split(':');
                                        var hour =int.parse(hour_min[0]);
                                        var min = int.parse(hour_min[1]);
                                        var data = hour*60 + min;

                                        //일일공부시간 누적 저장
                                        firestore.collection('UserData').doc(auth.currentUser?.uid).update({'dailystudytime' : data+dailystudytime});
                                        //학기공부시간 뉘적 저장
                                        firestore.collection('UserData').doc(auth.currentUser?.uid).update({'semesterstudytime' : data+semesterstudytime});

                                        //값 업데이트
                                        dailystudytime =  data+dailystudytime;
                                        semesterstudytime = data+semesterstudytime;

                                      });
                                      Navigator.of(context).pop();	// input 입력 후 창 닫히도록
                                    },
                                        child: Text("저장"))
                                  ]
                              );
                            });
                      },
                    ),
                childCount: todos.length,),
          )
        ],
      ),

    );
  }
}
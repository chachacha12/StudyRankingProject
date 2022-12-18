import 'package:flutter/material.dart';
import 'main.dart';


class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {

  List todos = [];
  List check_color = [];  //완료된 리스트인지 체크
  String input = "";

  @override
  void initState() {
    super.initState();
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

            pinned: true,
            expandedHeight: 230.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title:  Text('TodoList',
                textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),),

              background: Image.asset(
                'assets/todolist.png',
                fit: BoxFit.fill,),
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
                                title: Text("공부한 시간을 입력하세요. ex) 2:30"),
                                content: TextField(
                                  /*
                                    onChanged: (String value) {
                                      input = value;
                                    },
                                     */
                                ),
                                actions: <Widget>[
                                  FlatButton(onPressed: (){
                                    setState(() {
                                      check_color[index] = Colors.blue;  //공부시간 입력후엔 체크버튼 색상 변경
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
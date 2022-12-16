import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'StudyRanking.dart';
import 'Todolist.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (c) => Store1(),
          child: GetMaterialApp(
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              home:  MyApp()
          )
      )
  );
}

//state보관함 store - Provider패턴 적용
class Store1 extends ChangeNotifier {

  var tab =0;  //바텀바에서 유저가 누를때 페이지전환 시켜주기위한 state
  //tab값 변경함수
  ChangeTab(i){
    tab = i;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text('Peer Stuty', ),
        leading: IconButton(
          icon: Icon(Icons.dark_mode),
          onPressed: (){
            //다크모드 변경
            Get.changeTheme(
              Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
            );
          },
        ),

      ),

      //리스트안에 두 페이지 넣어서 유저가 바텀탭 누를때마다 각각 전환
      body: [
        Todolist(), StudyRanking()
      ][context.watch<Store1>().tab],  //Store1안의 state를 가져옴

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<Store1>().tab,

        showSelectedLabels: false,
        showUnselectedLabels:false,
        iconSize: 25.0,
        selectedIconTheme: IconThemeData(
            color: Colors.black
        ),
        unselectedIconTheme: IconThemeData(
            color: Colors.grey
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        //selectedFontSize: 14, //선택된 아이템의 폰트사이즈
        //unselectedFontSize: 14, //선택 안된 아이템의 폰트사이즈
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: ' Todolist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: ' Ranking'),
        ],
        onTap: (i){    //i는 바텀네비게이션에서 누르는 버튼 순서번호임. 첫번째 버튼 누르면 i는 0이됨.
          setState(() => context.read<Store1>().ChangeTab(i));
        },
      ),
    );
  }
}
















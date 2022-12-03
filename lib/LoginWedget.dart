



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyrankingproject/EnrollWidget.dart';
import 'package:studyrankingproject/MainWidget.dart';


class LoginWidget extends StatefulWidget{
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _LoginWidget();
  }
}

class _LoginWidget extends State<LoginWidget>{
  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width * 0.85;
    TextStyle textButtonStyle = TextStyle(
      fontSize: 12,
    );


    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    height: MediaQuery.of(context).size.height - 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 150.0, bottom: 40.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Login",
                                      style: TextStyle(
                                          fontSize: 48)
                                  ),
                                ])
                        ),
                        Container(
                            width: widgetWidth,
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    labelText: 'id',
                                    border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.orange)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.orange)
                                    )
                                )
                            )
                        ),
                        Container(
                            width: widgetWidth,
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          Icons.account_circle,
                                          color: Colors.grey),
                                      onPressed: () {
                                        setState(() {
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.orange)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.orange)
                                    )
                                )
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 2),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(
                                        ),
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(widgetWidth - 4, 40)),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: ((context)=>
                                      ChangeNotifierProvider(
                                          create: (c) => Store1(),
                                          child: MainWidget()
                                      )
                                  ))
                                ),
                                child: Text("로그인",
                                    style: TextStyle(color: Colors.white)))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: ((context)=>
                                        EnrollWidget()
                                    ))
                                ),
                                child: Text("회원 가입", style: textButtonStyle),
                              )
                            ]),
                      ],
                    )
                )
            )
        )
    );
  }
  
}
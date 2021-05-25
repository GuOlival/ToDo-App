import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/sign_in_page.dart';
import 'package:todo_app/pages/sign_up_page.dart';

var customRoutes =<String,WidgetBuilder>{
  '/signup': (context) => SignUpPage(),
};



/*
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        //brightness: AppController.instance.isDartTheme
        // ? Brightness.dark: Brightness.light,
      ),
      routes: {
        '/': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}*/

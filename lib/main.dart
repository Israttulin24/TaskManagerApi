import 'package:flutter/material.dart';
import 'package:projecttaskmanager/screen/onboarding/emailVerificationScreen.dart';
import 'package:projecttaskmanager/screen/onboarding/loginScreen.dart';
import 'package:projecttaskmanager/screen/onboarding/pinVerificationScreen.dart';
import 'package:projecttaskmanager/screen/onboarding/registrationScreen.dart';
import 'package:projecttaskmanager/screen/onboarding/setPasswordScreen.dart';
import 'package:projecttaskmanager/screen/onboarding/splashScreen.dart';
import 'package:projecttaskmanager/component/newTaskList.dart';
import 'package:projecttaskmanager/component/progressTaskList.dart';
import 'package:projecttaskmanager/screen/task/homeScreen.dart';
import 'package:projecttaskmanager/screen/task/taskCreateScreen.dart';
import 'package:projecttaskmanager/utility/utility.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();//main function cannot be async, use ensureInitialized to continue

  String? token = await ReadUserData('token');
  if(token==null){
    runApp(MyApp("/login"));
  }
  else {
    runApp(MyApp("/"));
  }
}

class MyApp extends StatelessWidget {
  final String FirstRoute;
  MyApp(this.FirstRoute);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task Manager",
      initialRoute: FirstRoute, // '/' means home.
      routes: {
        '/':(context)=> homeScreen(),
        '/login':(context)=> loginScreen(),
        '/registration':(context)=> registrationScreen(),
        '/emailVerification':(context)=> emailVerificationScreen(),
        '/pinVerification':(context)=> pinVerificationScreen(),
        '/setPassword':(context)=> setPasswordScreen(),
        '/newTaskList':(context)=> newTaskList(),
        '/homeScreen':(context)=> homeScreen(),
        '/progressTaskList':(context)=> progressTaskList(),
        '/taskCreate':(context)=> taskCreateScreen(),
      },

    );
  }
}



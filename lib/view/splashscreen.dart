import 'dart:async';

import 'package:apibloc/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service/user_manager.dart';
import 'Signupscreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final UserManager _userManager = UserManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),() async {
      String? id=await _userManager.getUserId();
      if(id==null){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Signup()), // The new screen to navigate to
              (Route<dynamic> route) => false, // Condition to remove all previous routes
        );
      }else{
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()), // The new screen to navigate to
              (Route<dynamic> route) => false, // Condition to remove all previous routes
        );
      }
    }


    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbfefaf),
      body: Center(child: Icon(Icons.shopping_cart_rounded,size: 60,color: Colors.green,),),
    );
  }
}

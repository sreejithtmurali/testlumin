import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profileview extends StatefulWidget {
  const Profileview({super.key});

  @override
  State<Profileview> createState() => _ProfileviewState();
}

class _ProfileviewState extends State<Profileview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xfff0f8ed),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              CircleAvatar(child: Text('User1',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),radius: 55,),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width-100,
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Center(
                  child: Text("Name:User",
                    style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black54,fontSize: 20),),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width-100,
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Center(
                  child: Text("user@gmail.com",
                      style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black54,fontSize: 20)),
                ),
              ),
              SizedBox(height: 10,),

              Container(
                  width: MediaQuery.of(context).size.width-100,
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(12)
                  ),child: Center(child: Text("Phone: 9686XXXXXX",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black54,fontSize: 20)))),

            ],),

        ),
      ),
    );
  }
}

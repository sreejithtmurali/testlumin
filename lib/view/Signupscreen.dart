import 'package:apibloc/view/otpscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
TextEditingController textEditingController=TextEditingController();
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.green,
          title: Text("SignUp",style:TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
        ),
      body: Container(height: double.infinity,
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/otpp.png",

            width: 266, height: 266, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength:10,
              controller: textEditingController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter Phone No",
                labelText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              validator: (value) {
                if (value!.length !=10 || value.isEmpty) {
                  return 'Please enter some valid phone number';
                }
                return null;
              },
            ),
          ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: (){
                   if(_formKey.currentState!.validate()){
                     Navigator.pushReplacement(context,
                         MaterialPageRoute(builder:
                             (context) =>
                             Otpscreen(ph:textEditingController.text)
                         ));

                   }
                  }, child: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white,fontSize: 18),),),
              )
            )


        ],),
      ),),
    );
  }
}

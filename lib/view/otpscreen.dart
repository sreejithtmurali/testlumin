import 'package:apibloc/view/home.dart';
import 'package:apibloc/view/productlistingview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service/user_manager.dart';
import '../widgets/customotp.dart';

class Otpscreen extends StatefulWidget {
  String ph;
  String verificationId = '';
  bool isCodeSent = false;
   Otpscreen({super.key, required this.ph,required this.verificationId,required this.isCodeSent });

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserManager _userManager = UserManager();
  Future<void> _signInWithOTP(String ph) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: ph,
      );
      await _auth.signInWithCredential(credential);
      _saveUserData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Phone number verified and user signed in")),

      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()), // Replace with your home screen
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign in. Error: ${e.toString()}")),
      );
    }
  }

  Future<void> _saveUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _userManager.saveUserData(user.uid, user.phoneNumber ?? '');
    }
  }

  Future<void> _checkUserAuthentication() async {
    String? userId = await _userManager.getUserId();
    if (userId != null) {
      // User is authenticated, proceed to the home screen or desired screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()), // Replace with your home screen
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkUserAuthentication();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFBFB),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset("assets/images/otpp.png",

                width: 266, height: 266, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Color(0xffFF7A06)),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "+91 ${widget.ph}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFF7A06),
                            fontSize: 14),
                      ),
                    ],
                  )),
            ),
            Container(
              child: Center(
                child: Text(
                  "OTP Has Been Sent To Your Phone Number",
                  style: TextStyle(
                      color: Color(0xff666666),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            OtpTextField(
              autoFocus: false,
              numberOfFields: 6,
              showFieldAsBox: true,
              onSubmit: (value){
                _signInWithOTP(value);
              },
            ),
            SizedBox(height: 8,),
            Container(
              child: Center(
                child: Text(
                  "Resend OTP after 60 sec",
                  style: TextStyle(
                      color: Color(0xff666666),
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
            ),
            SizedBox(height: 24,),
              Container(
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





                  }, child: Text("Next",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white,fontSize: 18),),),
              )
          ],
          ),
        ),
      ),
    );
  }
}

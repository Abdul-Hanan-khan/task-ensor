import 'dart:async';

import 'package:custom_pin_entry_field/custom_pin_entry_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_verification/screens/home_screen.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  String? phoneNo;

  OtpScreen(this.phoneNo);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? verificationId;
  bool? showLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? userPin;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    varifyPhoneNumber();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(),
          Column(
            children: [
              Image.asset(
                'assets/correct.png',
                width: 80,
                height: 80,
              ),
              Text(
                'Verify your Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'We have sent 6 digit code at \n ${widget.phoneNo} ',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomPinEntryField(
                    fieldWidth: 40,
                    fields: 6,
                    showFieldAsBox: true,
                    onSubmit: (String pin) {
                      userPin = pin;
                    }, // end onSubmit
                  ), // end PinEntryTextField()
                ), // end Padding()
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Resend Code in 35 sec'),
              ),
              RaisedButton(
                onPressed: () {
                  print('user pin===========================================${userPin}');
                  PhoneAuthCredential? phoneAuthCredential = PhoneAuthProvider
                      .credential(verificationId: verificationId,
                      smsCode: userPin) as PhoneAuthCredential?;
                  sinInWithPhoneAuthCredentials(phoneAuthCredential);
                },
                color: Colors.blue[400],
                child: Text(
                  'Verify Code',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              child: Text('Resend Code'),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  void sinInWithPhoneAuthCredentials(
      PhoneAuthCredential? phoneAuthCredential) async {
    try {
      final authCredential = await _auth.signInWithCredential(
          phoneAuthCredential);
      if (authCredential ?. user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      showLoading = false;
      scaffoldKey.currentState!.showSnackBar(
          SnackBar(content: Text(e.message)));
      print(e);
    }
  }


  void varifyPhoneNumber() async {
    print(
        '====================================================================verifying Phone no    ${widget
            .phoneNo}');
    await _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNo,
        verificationCompleted: (phoneAuthCredentials) async {
          // sinInWithPhoneAuthCredentials( phoneAuthCredential) {}
        },
        verificationFailed: (verificationFailed) async {
          scaffoldKey.currentState!.showSnackBar(
              SnackBar(content: Text(verificationFailed.message)));
        },
        codeSent: (verificationId, sendingToken) async {
          setState(() {
            showLoading = false;
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationID) async {});
  }
}
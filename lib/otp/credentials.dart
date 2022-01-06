import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'otp_screen.dart';

class CredentialsScreen extends StatefulWidget {
  @override
  _CredentialsScreenState createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  String phone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset('assets/img.png'),
              Text(
                'Your home service expert',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'The App You Can Trust',
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CountryCodePicker(
                      initialSelection: 'PK',
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      favorite: ['+93', 'AFG'],
                      enabled: true,
                    ),
                    Container(
                      width: 2,
                      height: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 3,

                      //SizedBox(height: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '3468790768'
                          // border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          setState(() => phone = "+1"+val);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Container(
                    height: 70,
                    width: 100,
                    margin: EdgeInsets.only(top: 10, right: 10),
                    decoration: new BoxDecoration(
                      color: Colors.blue[400],
                      border: Border.all(color: Colors.black, width: 0.0),
                      borderRadius:
                          new BorderRadius.all(Radius.elliptical(100, 70)),
                    ),
                    child: Center(
                        child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpScreen(phone)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

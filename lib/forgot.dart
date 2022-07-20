import 'package:flutter/material.dart';
import 'main.dart';


// ignore: use_key_in_widget_constructors
class ForgotPassword extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> { 
   late String name;
   late int mobileNumber;
   late String password;
  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            'GearUp',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }


  Widget _buildMobileNumberRow() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8,8,8,40),
      child: TextFormField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            mobileNumber = value as int;            
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.blue[500],
            ),
            labelText: 'Mobile Number'),
      ),
    );
  }

 
  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[      
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),         
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: Colors.blue[500],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {},
            child: Text(
              "Request OTP",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: MediaQuery.of(context).size.height / 45,
              ),
            ),
          ),         
        )
      ],
    );
  }


  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,                 
                  children: <Widget>[                   
                    Text(
                      "Please enter your mobile number",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 50,
                        )
                      ),                   
                  ],
                ),            
                _buildMobileNumberRow(),                             
                _buildLoginButton(),              
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: FlatButton(
            onPressed: () {
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height / 50,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                    color: Colors.blue[500],
                    fontSize: MediaQuery.of(context).size.height / 50,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildContainer(),
                _buildSignUpBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
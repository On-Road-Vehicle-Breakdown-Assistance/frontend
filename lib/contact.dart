import 'package:flutter/material.dart';
import 'main.dart';


// ignore: use_key_in_widget_constructors
class ContactPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ContactPage createState() => _ContactPage();
}

class _ContactPage extends State<ContactPage> { 
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,                 
                  children: <Widget>[                   
                    Text(
                      "Developer Details",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 50,
                        )
                      ),
                       Text(
                      "Phone Number : +91 1234567890",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 50,
                        )
                      ),
                     Text(
                      "Email : user@gmail.com",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 50,
                        )
                      ),
                  ],
                ),            
                             
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
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../shared/shared.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();
  @override
  void initState() {
    auth.getUser.then((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/topics');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        //decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //logo
            FlutterLogo(
              size: 150,
            ),
            Text(
              'Login to start',
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
            ),
            Text('your tagline'),
            LoginButton(
              text: 'Login with Google Account',
              icon: FontAwesomeIcons.google,
              color: Colors.black45,
              loginMethod: auth.googleSignIn,
            ),
            LoginButton(
              text: 'Login as a guest',
              loginMethod: auth.anonLogin,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.color, this.icon, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/topics');
          }
        },
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Expanded(
          child: Text(
            '$text',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

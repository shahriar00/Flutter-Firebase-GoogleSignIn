import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlesignin/main.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {


  final FirebaseAuth auth = FirebaseAuth.instance;

  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.authStateChanges().listen((event) {
      user = event;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user != null ? userInfo() : googleSignInButton(),
    );
  }

  Widget googleSignInButton() {
    return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          Image.asset(
            "images/flag.png",
            height: 200,
            width: 300,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(10),
            child: MaterialButton(
              onPressed: () => handleSignIn(),
              color: Colors.grey,
              child: Row(
                children: [
                  Image.asset(
                    "images/google.png",
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Google Sign In",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      );
  }

  Widget userInfo() {
        return Column(
        children: [
        SizedBox(height: MediaQuery.of(context).size.height/3,),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(user?.photoURL??'')
            )
          ),
        ),

          Center(
            child: Text(
              user!.displayName ?? '',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              user!.email.toString(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () => auth.signOut(),
            color: Colors.blueGrey,
            child: Text(
              "Sign Out",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ],
      );
  }

  void handleSignIn() {
    try {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      auth.signInWithProvider(authProvider);
    } catch (e) {
      print(e);
    }
  }
}

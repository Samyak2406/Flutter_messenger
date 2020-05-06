import 'package:flutter/material.dart';
import 'package:messenger001/textbox.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class register extends StatefulWidget {
  static const id='register';
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  textbox t1=textbox('user-id',false);
  textbox t2=textbox('password',true);
  bool showSpinner=false;
  final _authentication=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child :SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.lightGreenAccent.shade700,
                    child: ClipOval(
                      child: Hero(
                        tag: 'image_animation',
                        child: Image.asset(
                          'images/chat_logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    color: Colors.yellow.shade700,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        t1.buildbox(),
                        t2.buildbox(),
                        GestureDetector(
                          onTap: ()async{
                            try{
                              setState(() {
                                showSpinner=true;
                              });
                              final newuser=await _authentication.createUserWithEmailAndPassword(email: t1.value, password: t2.value);
                              if(newuser!=null){
                                Navigator.pushNamed(context, chat.id);
                              }
                              setState(() {
                                showSpinner=false;
                              });
                            }
                            catch(e){
                              setState(() {
                                showSpinner=false;
                              });
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Text(
                                'REGISTER',
                                style:
                                TextStyle(color: Colors.indigo, fontSize: 40),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

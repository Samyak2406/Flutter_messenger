import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _store=Firestore.instance;
FirebaseUser ourUser;

class chat extends StatefulWidget {
  static const id = 'chat';
  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
//  bool clear=false;
  String textfieldvalue;
  final _authentication = FirebaseAuth.instance;
  final textcontroller=TextEditingController();

//  void getmessages() async {
//    await for(var snapShot in _store.collection('messages').snapshots()){
//      for(var message in snapShot.documents){
//        print(message.data);
//      }
//    }
//  }


  void currentUserfun() async {
    try {
      final user = await _authentication.currentUser();
      if (user != null) {
        ourUser = user;
      }
    } catch (e){}
  }


  @override
  void initState() {
    super.initState();
    currentUserfun();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade400,
        actions: <Widget>[
          IconButton(
            icon: Icon(
            Icons.check_box_outline_blank,
            color: Colors.red,
            size: 30,
          ),
              onPressed: (){
               setState(() {
                 _authentication.signOut();
                 Navigator.pop(context);
//               getmessages();
               });
              },
          )
        ],
        title: Text(
          'Unusual',
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
           Streamer(),
            Container(
              color: Colors.grey.shade400,
              child:Row(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: TextField(
                      controller: textcontroller,
                      cursorColor: Colors.indigo,
                      style: TextStyle(
                        color: Colors.indigo
                      ),
                      onChanged: (value){
                        textfieldvalue=value;
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Icon(Icons.send),
                      onTap: (){
                        textcontroller.clear();
                        if(textfieldvalue!=null && textfieldvalue!=''){
                          print(ourUser.email);
                          try{
                            _store.collection('messages').add(
                                {
                                  'sender' : ourUser.email,
                                  'text' : textfieldvalue
                                }
                            );
                          }

                          catch(e){
//                            print('i m error $e');
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class balloon extends StatelessWidget {
  String messagetext,messagesender;
  bool isMe;

  balloon({this.messagetext,this.messagesender,this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(messagesender),
          Material(
            shadowColor: Colors.lightGreenAccent,
            color: isMe ? Colors.green : Colors.yellow.shade700,
            borderRadius: BorderRadius.only(
              topLeft: !isMe?Radius.circular(0):Radius.circular(20),
              topRight: isMe?Radius.circular(0):Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight:Radius.circular(20)
                ),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Text(
                '$messagetext',
                style: TextStyle(
                  color: isMe? Colors.black:Colors.red.shade900,
                fontSize: 22,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}




class Streamer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: _store.collection('messages').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Container(
            color: Colors.lightGreenAccent,
          );
        }

        List<balloon> ls=[];
        final messages = snapshot.data.documents.reversed;
        for(var message in messages){
          final messagetext=message.data['text'];
          final messagesender=message.data['sender'];
          final currentUser=ourUser.email;
          bool  isMe;
          if(currentUser==messagesender){
            isMe=true;
          }
          else{
            isMe=false;
          }
          final balloonWidget=balloon(messagesender: messagesender,messagetext: messagetext,isMe: isMe);
//          print('$messagetext  from $messagesender');
          ls.add(balloonWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: ls,
          ),
        );
      },
    );
  }
}
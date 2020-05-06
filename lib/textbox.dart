import 'package:flutter/material.dart';
import 'login.dart';

class textbox{
 String value;
  String hintext;
  bool hide=false;
  textbox(this.hintext,this.hide);

  Widget buildbox(){
    return TextField(
      keyboardType: !this.hide ?  TextInputType.emailAddress : TextInputType.text,
      obscureText: this.hide,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
      ),
      onChanged: (value){
        this.value = value;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.lightGreen.shade600,
        border:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
        hintText: this.hintext,
        hintStyle: TextStyle(
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
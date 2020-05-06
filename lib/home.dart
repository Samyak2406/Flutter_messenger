import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';


class home extends StatefulWidget {
  static const id = 'home';
  @override
  _homeState createState() => _homeState();
}


class _homeState extends State<home> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation,colorAnimation,colorAnimationrev;


  @override
  void initState() {
    super.initState();
    controller=AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation=CurvedAnimation(parent: controller, curve: Curves.easeInCubic);

    colorAnimation=ColorTween(begin:Colors.red.shade700,end:Colors.indigo).animate(controller);
    colorAnimationrev=ColorTween(end:Colors.red.shade700,begin:Colors.indigo).animate(controller);

    controller.forward();
    controller.addListener((){
      setState(() {
        controller.value;
        animation.value;
        colorAnimation.value;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.withOpacity(1-animation.value),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.yellow,
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, login.id);
                        },
                        child: Center(
                          child: Text('Login',
                          style: TextStyle(
                            fontSize: 25+15*animation.value,
                            color: Colors.indigo,
                          ),
                          ),
                        ),
                      ),
                    ),
                  ),
                 Expanded(
                   child:  Container(
                     decoration: BoxDecoration(
                       color: colorAnimation.value.withOpacity(animation.value/2 + 0.5),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     ),
                   ),
                 ),
                ],
              ),
            ),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.all(Radius.circular(45)),
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: ClipOval(
                          child: Container(
                            child: Hero(
                              tag: 'image_animation',
                              child: Image.asset(
                                  'images/chat_logo.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                        ),
              ),
                  ),
                ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorAnimationrev.value.withOpacity(controller.value/2 + 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: GestureDetector(
                        child: Center(child: Text('Register',style: TextStyle(fontSize: 25+25*animation.value,color: Colors.red.shade700),)),
                        onTap: (){
                          Navigator.pushNamed(context,register.id);
                        },
                      ),
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
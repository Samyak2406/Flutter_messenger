import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create:(context)=>Data(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title:appbarwidget(),
          ),
          body: level1(),
        ),
      ),
    );
  }
}

class appbarwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Text(Provider.of<Data>(context).data);
  }
}


class level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return level2();
  }
}


class level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return level3();
  }
}



class level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: <Widget>[
          Text(Provider.of<Data>(context).data),
          TextField(
            onChanged: (newValue){
              print('$newValue');
              Provider.of<Data>(context).changeAllOccurences(newValue);
            },
          ),
        ],
      ),
    );
  }
}
class Data extends ChangeNotifier{
  String data='This is new data';

  void changeAllOccurences(String newText){
    data=newText;
    print('we here');
    notifyListeners();
  }
}
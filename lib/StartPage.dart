
import 'package:flutter/material.dart';
import 'package:s8/auth.dart';
import 'package:s8/signedin.dart';
bool isFaculty = false;
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: black,
      child: Container(
        color: black,
        padding: EdgeInsets.only(left:30,right:30,top: 250,bottom: 250),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: black,
          elevation: 10,
          
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                
                SizedBox(
                  height: 40,
                  width: 200,
                    child: RaisedButton(
                      color: black,
                      elevation: 10,
                    onPressed: (){
                      setState(() {
                        isFaculty = false;
                      });
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Auth()));
                    },
                    child: Text('Student Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: white
                    ),),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                    child: RaisedButton(
                      color: black,
                      elevation: 10,
                    onPressed: (){
                      setState(() {
                        isFaculty = true;
                      });
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Auth()));
                    },
                    child: Text('Faculty Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: white
                    ),),
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
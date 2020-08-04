import 'package:flutter/material.dart';
//import 'package:s8/allasignments.dart';
import 'package:s8/customcard.dart';
//import 'package:school/hometest.dart';
//import 'package:school/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class faculty1 extends StatefulWidget {
  @override
  _faculty1State createState() => _faculty1State();
}

class _faculty1State extends State<faculty1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center
      (child: 
       Column(
         children: <Widget>[
           SizedBox(
             width: 300,
                    child: new RaisedButton(
               elevation: 8,
               color: Colors.green,
               child: Text('Create Assignment',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
               
               onPressed: () {
                 int uniqueid = 0;
                    Firestore.instance.collection("Assignment").getDocuments().then((mydocs){
                    int unid = mydocs.documents.length;
                    print(unid);
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => newcard(unid.toString(),{},0,true)));
               
                   });
           
               }),
           ),
              SizedBox(height: 10,),
                SizedBox(
            width: 300,
                    child: new RaisedButton(
              elevation: 8,
              color: Colors.green,
              child: Text('View Assignment',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              onPressed: (){
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => allassigns()));
                
              },
                    ),
                    ),
         ],
       ),
    
       )

      
      
      ,);
      

  }
}
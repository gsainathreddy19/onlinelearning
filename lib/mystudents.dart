

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s8/signedin.dart';

class Mystudents extends StatefulWidget {
  @override
  _MystudentsState createState() => _MystudentsState();
}

class _MystudentsState extends State<Mystudents> {

  FirebaseUser user;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getuser() async{
    user = await firebaseAuth.currentUser();
    print(user.uid);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: black,
      child: Padding(
        padding: EdgeInsets.only(top:MediaQuery.of(context).padding.top),
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  
                  IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> SignedIn()));
                    },
                    icon: Icon(Icons.arrow_back,color: white,),
                  ),
                  Text('My Students',style: TextStyle(
                    color: white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700
                  ),),
                  SizedBox(width: 30,)
                ],),
                Divider(color: white,
                thickness: 0.8,
                indent: 20,
                endIndent: 20,
                ),
                FutureBuilder(
                future: Firestore.instance.collection('students').document(user.uid).collection('students').getDocuments()
                ,builder: (c,data){
                  if(!data.hasData){
                    return Container(
                      color:Colors.transparent,
                      padding: EdgeInsets.only(left:0.45*MediaQuery.of(context).size.width,right:0.45*MediaQuery.of(context).size.width),
                      child:Theme(
                        data: ThemeData(accentColor: white),
                        child: CircularProgressIndicator()));}
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (c,i){
                      if(data.data.documents[i].documentID == user.uid ){
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              
                              child: Column(
                                children: [ListTile(
                                  trailing: IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.delete,
                                    color: white,),
                                  ),
                                  title: FutureBuilder(
                                    future: Firestore.instance.collection('users').where('id', isEqualTo: data.data.documents[i]['student_id']).getDocuments(),
                                    builder: (c,data){
                                      if(!data.hasData){
                                        return Row(children: <Widget>[
                                          Theme(
                                            data: ThemeData(
                                            accentColor: white
                                            ),
                                            child: CircularProgressIndicator(
                                            ))
                                        ],);
                                      }
                                      return Text(data.data.documents[0]['nickname'],
                                      style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.3,
  
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      );
                                    },
                                  ),
                                ),
                                Divider(color: white,
                                thickness: 0.2,
                                indent: 10,
                                endIndent: 10,
                                )
                                ]
                              ),
                            )
                          ],
                        );
                      }
                      else{return SizedBox(height: 0,);}
                    }, 
                    itemCount: data.data.documents.length
                    
                    );
                },
              ),
              ]
            )
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s8/signedin.dart';
import 'package:s8/studentsignin.dart';
String subid = '';
class Subjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final controller = new TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
  getuser () async{
    user = await firebaseAuth.currentUser();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        
        scrollDirection: Axis.vertical,
        child: Material(
          color: black,
          child: Column(
            children : <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top,),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back,color: white,),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (c) => SignedIn()));
                    },
                  )
                  ,SizedBox(width: 0.27*MediaQuery.of(context).size.width,),
                  Text('Subjects',style: TextStyle(
                    color: white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5
                  ),)
                ],
              ),
          FutureBuilder(
  
                future: Firestore.instance.collection('subjects').getDocuments(),
  
                builder: (context,data){
  
                  if(data.hasData){
  
                    return Material(
                      color: black,
                      child: ListView.separated(
                        
                        separatorBuilder: (c,i){
                          return Divider(
                            color: white,
                            thickness: 0.19,
                            endIndent: 20,
                            indent: 20,
                          );
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,i){
  
                          return ListTile(
                            
                            title: InkWell(
                              onTap: (){
                                //subid =  data.data.documents[i].documentID;
                              },
                              child:Text(data.data.documents[i]['name'],style: TextStyle(color: white),)),
                            trailing: IconButton(
                              onPressed: () async {
                                String id = data.data.documents[i].documentID;
                                await Firestore.instance.collection('subjects').document(id).delete();
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Subjects()));
                              },
                              icon: Icon(Icons.delete,color: white,),
                            ),
                          );
  
                        },
                        itemCount: data.data.documents.length,
                        ),
                    );
  
                  }
  
                  else{
  
                    return CircularProgressIndicator();
  
                  }
  
                }),
                TextField(
                  style: TextStyle(color: white),
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter Subject Name',
                    hintStyle: TextStyle(color: white)
                  ),
                ),
                RaisedButton(
                  color: black,
                  elevation: 10,
                  onPressed: () async {
                    if(controller.text.isNotEmpty){
                      
                    await Firestore.instance.collection('subjects').add({'name':controller.text,'faculty_id':user.uid});
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Subjects()));
                    }
                    
                  },
                  child: Text('Add Subject',style: TextStyle(color: white),),
                )
]
          ),
        ),
      ),
    );
  }
}
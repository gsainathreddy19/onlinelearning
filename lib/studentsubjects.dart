

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:s8/signedin.dart';
import 'package:s8/studentsignin.dart';
String subid = '';
class StudentSubjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<StudentSubjects> {
  final controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: black,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Material(
          color: black,
          child: Column(
            children : <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                  icon: Icon(Icons.arrow_back,color: white,),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (c)=> StudentMainPage()));
                  },
                ),
                SizedBox(width: 0.28*MediaQuery.of(context).size.width,),
                Text('Subjects',
                style: TextStyle(
                  color: white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4
                ),
                )
                ],
              ),
              Divider(color: white,thickness: 1,indent: 20,endIndent: 20,),
          FutureBuilder(
  
                future: Firestore.instance.collection('subjects').getDocuments(),
  
                builder: (context,data){
  
                  if(data.hasData){
  
                    return Material(
                      color: black,
                      child: ListView.builder(
                        
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,i){
                          if(Myfaculty == data.data.documents[i]['faculty_id']){
                          return ListTile(
  
                            title: Column(children: <Widget>[
                              Text(data.data.documents[i]['name'],
                              style: TextStyle(
                                color: white,

                              ),
                              ),
                              Divider(color: white,
                              thickness: 0.2,
                              indent: 10,
                              endIndent: 10,
                              )
                            ],)
                            
                            
                          );}
                          return Container(height: 0,);
  
                        },
                        itemCount: data.data.documents.length,
                        ),
                    );
  
                  }
  
                  else{
  
                    return CircularProgressIndicator();
  
                  }
  
                }),
                // TextField(
                //   controller: controller,
                //   decoration: InputDecoration(
                //     hintText: 'Add subject'
                //   ),
                // ),
                // RaisedButton(
                //   onPressed: () async {
                //     if(controller.text.isNotEmpty){
                      
                //     await Firestore.instance.collection('subjects').add({'name':controller.text});
                //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Subjects()));
                //     }
                    
                //   },
                //   child: Text('Add Book'),
                // )
]
          ),
        ),
      ),
    );
  }
}
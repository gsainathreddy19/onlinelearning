
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s8/StartPage.dart';
import 'package:s8/assesment.dart';
import 'package:s8/previews.dart';
import 'package:s8/signedin.dart';
import 'package:s8/studentsignin.dart';
import 'package:s8/subjects.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customcard.dart';
String Subid = '';
String Courseid = '';
class Cources extends StatefulWidget {
  @override
  _CourcesState createState() => _CourcesState();
}
String sname='',aurl='',vurl='';
class _CourcesState extends State<Cources> {
  
  double h;
  double w;
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    h = s.height;
    w = s.width;
    final to = MediaQuery.of(context).padding.top;
    return Material(
      color: black,
      child: Padding(
        padding: const EdgeInsets.only(top:0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: to,),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home,size: 25,color: white,),
                  onPressed: (){
                    if(isFaculty){
                    Navigator.of(context).push(MaterialPageRoute(builder: (c) => SignedIn()));
                    }
                    else{
                      Navigator.of(context).push(MaterialPageRoute(builder: (c) => StudentMainPage()));
                    }
                  },
                ),
                SizedBox(width: 0.3*w,),
                Center(child: Text('Courses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: white
                ),
                )),

              ],
            ),
            Divider(
              endIndent: 10,
              indent:  10,
              thickness: 1,
              color: white,
            ),

            Container(
              height: h*0.8,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FutureBuilder(
                  future: Firestore.instance.collection('subjects').getDocuments(),
                  builder: (c,data){
                    if(data.hasData ){
                      
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (c,i){
                          print(Myfaculty);
                          if(data.data.documents[i]['faculty_id'] != Myfaculty &&  !isFaculty){
                            print('heii');
                            return Container(height: 0,);
                          }
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10,20,10,20),
                            child: SizedBox(
                              height: 40,
                              //width: 0.6*MediaQuery.of(context).size.width,
                              child: Material(
                                elevation: 4,
                                color: black,
                                borderRadius: BorderRadius.circular(10),
                                child: RaisedButton(
                                  elevation: 0,
                                  hoverElevation: 0,
                                  onPressed: (){
                                    setState(() {
                                      subid = data.data.documents[i].documentID;
                                    });
                                    
                                    Navigator.of(context).push(MaterialPageRoute(builder: (c)=> Course()));
                                  },
                                  color: Colors.transparent,
                                  child: Text(
                                    data.data.documents[i]['name'],
                                    style:TextStyle(
                                      color: white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 5
                                    ),),
                                ),
                              ),
                            ),
                          );
                        }, 
                        itemCount: data.data.documents.length);
                    }
                    else{
                      return Container(
                        padding: EdgeInsets.only(left:0.4*w,top: 0.4*h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Theme(
                              data: ThemeData(accentColor: white),
                              child: CircularProgressIndicator())]),
                      );
                    }
                  }),
              ),
            )
          ],),
      ),
    );
  }
}


class Course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  final vuc = new TextEditingController();
    final ac = new TextEditingController();
    final name = new TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user ;
  getuser() async{
    user = await firebaseAuth.currentUser();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getuser();
    
    if(sname!=''){
      name.text = sname;
    }
    if(aurl!=''){
      ac.text = sname;
    }
    if(vurl!=''){
      vuc.text = sname;
    }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: black,
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),

              color: white,
            ),
            Text('Course',style: TextStyle(
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 2
            ),
            
            ),SizedBox(width: 30,)
          ],),
          Divider(color: white,
          thickness: 1,),
          Expanded(
            child: Container(
              color: Colors.transparent,
              //height:0.8*MediaQuery.of(context).size.height,
              width: double.infinity,
              //padding: EdgeInsets.only(bottom: 100),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                child: Column(
                  //scrollDirection: Axis.vertical,
                  //shrinkWrap: true,
                  children: <Widget>[
                    isFaculty ? AddCourse() : Container(height: 0,),
                    SizedBox(height: 30,),
                    courses(),
                    SizedBox(height: 30,),
                    
                  ],
                ) ,
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget AddCourse(){
    
    return Container(
      color: Colors.transparent,
      height: 0.42*MediaQuery.of(context).size.height,
      width: 0.9*MediaQuery.of(context).size.width,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: black,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Theme(
                data: ThemeData(primaryColor: white,primaryColorDark: white,primaryColorLight: white,
                highlightColor: white,
                hintColor: white,
                
                ),
                child: TextField(
                  controller: name,
                  style: TextStyle(color: white),
                  onChanged: (str){
                    setState(() {
                      
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'name',
                    
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Theme(
                data: ThemeData(primaryColor: white,primaryColorDark: white,primaryColorLight: white,
                highlightColor: white,
                hintColor: white,
                ),
                child: TextField(
                  controller: ac,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    hintText: 'Article url',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Theme(
                data: ThemeData(primaryColor: white,primaryColorDark: white,primaryColorLight: white,
                highlightColor: white,
                hintColor: white,
                ),
                child: TextField(
                  controller: vuc,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    hintText: 'Video url',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              
              SizedBox(height: 8,),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: black,
                  elevation: 8,
                  child: Text('Add',style: TextStyle(color: white),),
                  onPressed: ()async {
                    if(vuc.text.isNotEmpty && ac.text.isNotEmpty && name.text.isNotEmpty){
                      final new1 = await Firestore.instance.collection('course').add({
                        'subid':subid,
                        'name':name.text,
                        'video_url':vuc.text,
                        'article_url':ac.text,
                        'faculty_id': user.uid
                      });
                      Courseid = new1.documentID;
                      
                    }
                  },
                ),
              ),
              SizedBox(height: 8,),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: black,
                  elevation: 8,
                  child: Text('Create Assignment',style: TextStyle(color: white),),
                  onPressed: (){
                   int uniqueid = 0;
                    Firestore.instance.collection("Assignment").getDocuments().then((mydocs){
                    int unid = mydocs.documents.length;
                    print(unid);
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => newcard(unid.toString(),{},0,true)));
                   });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget courses(){
    return FutureBuilder(
      future: Firestore.instance.collection('course').getDocuments(),
      builder: (c,data){
        if(data.hasData){
        return ListView.separated(
          //scrollDirection: Axis.vertical,
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          itemBuilder: (c,i){
            final info = data.data.documents[i];
            //print(subid);
            print(info['name']);
            if(info['subid'] == subid){
            
             return Container(
              height: 260,
              padding: EdgeInsets.only(left: 0.05*MediaQuery.of(context).size.width,right: 0.05*MediaQuery.of(context).size.width),
              color: Colors.transparent,
              width: 0.9*MediaQuery.of(context).size.width,
              child: Material(
                color: black,
                elevation: 14,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Center(child: Text(
                      info['name'],
                      style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5
                      ),
                    ),
                    ),
                    Divider(
                      color: white,
                      thickness: 0.2,
                      endIndent: 20,
                      indent: 20,
                    ),

                    SizedBox(
                      width: 0.7*MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () async {
                         await launch(info['video_url']);
                        },
                        color: black,
                        elevation: 2,
                        child: Text('Watch video',
                        style: TextStyle(
                          color: white,

                        ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.7*MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () async {
                         await launch(info['article_url']);
                        },
                        color: black,
                        elevation: 2,
                        child: Text('Read Article',
                        style: TextStyle(
                          color: white,

                        ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.7*MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () async {
                          String course_id = data.data.documents[i].documentID;
                          
                          if(course_id != null){ 
                            print(course_id);
                            final data = Firestore.instance.collection('Assignment').document(course_id).snapshots();
                            Map<String,String> ques = Map<String,String>();
                           int i = 1;
                          
                           data.forEach((element) { 
                              //print(element[i.toString()]);
                               var  ar = new List<MapEntry<String,String>>();
                              String info = element[i.toString()];
                              var  temp = MapEntry(i.toString(), info);
                              //print(temp);
                              setState(() {
                                ar.add(temp);
                                i += 1;
                                ques.addEntries(ar);
                              });
                              //print(ar);
                            }
                            );
                            //print(ar);
                            print(ques);
                            Navigator.of(context).push(MaterialPageRoute(builder: (c) => preview(ques)));
                          }
                        },
                        color: black,
                        elevation: 2,
                        child: Text('Assignment',
                        style: TextStyle(
                          color: white,

                        ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        isFaculty ? IconButton(
                          onPressed: () async{
                            await Firestore.instance.collection('course').document(data.data.documents[i].documentID).delete();
                            Navigator.push(context, MaterialPageRoute(builder: (c)=>Course()));
                          },
                          icon: Icon(Icons.delete,color: white,),
                        ):Container(height: 0,),
                        SizedBox(width: 10,)
                      ],)
                  ],
                ),
              ),
            );}
            else{return SizedBox(height: 0,);}
          }, 
          separatorBuilder:(c,i){ return SizedBox(height: 25,);} ,
          itemCount: data.data.documents.length);}
          else{
            return Container(
              child: Theme(
                data: ThemeData(accentColor: white),
                child: CircularProgressIndicator()),
            );
          }
      },
    );
  }
}
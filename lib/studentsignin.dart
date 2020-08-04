

import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
 import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/material.dart';

 import 'package:google_sign_in/google_sign_in.dart';

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:s8/Cources.dart';
import 'package:s8/StartPage.dart';
import 'package:s8/auth.dart';
import 'package:s8/mystudents.dart';
import 'package:s8/signedin.dart';
import 'package:s8/studentsubjects.dart';
import 'package:s8/subjects.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentMainPage extends StatefulWidget {
  @override
  _StudentMainPageState createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  bool isdashboard = false;
  bool loading = false;
  double height;
  double width;
  GoogleSignIn googleSignIn = new GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getState() async{
  //   //Stream<QuerySnapshot> data = Firestore.instance.collection('users').snapshots();
  //   final FirebaseUser currentUser = await firebaseAuth.currentUser();
  //   final QuerySnapshot result =await Firestore.instance.collection('users').where('id', isEqualTo: currentUser.uid).getDocuments();
  //   //print(result.documents[0]['position']);
  //   print('its workinh');
  //   if(result.documents[0]['position'] ==  null && isFaculty){
  //     //print(isFaculty);
  //     //print('in position check');
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>StartPage()));
  //     await firebaseAuth.signOut();
  //     await googleSignIn.signOut();
  //   }
  //   else{
      
  //   setState(() {
  //     loading = false;
  //   });
  //   }
    if(!isFaculty){
      //print('instudentcheck');
      final data = await Firestore.instance.collection('students').getDocuments();
      
      final currentuser = await firebaseAuth.currentUser();
      for(int i=0;i<data.documents.length;i++){
        //print(i);
        final students = await Firestore.instance.collection('students').document(data.documents[i].documentID).collection('students').getDocuments();
        for(int j=0 ;j <students.documents.length;j++){
          //print('hello');
          //print(j);
          if(students.documents[j].documentID == currentuser.uid){
            setState(() {
              Myfaculty = data.documents[i].documentID;
              print(Myfaculty);
            });
          }
        }
      }
    }
    
  }
  @override
  void initState() {
    // TODO: implement initState
    // setState(() {
    //   loading = true;
    // });
    super.initState();
    print('student page');
    //getState();
  }
  @override
  Widget build(BuildContext context)  {
    final size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    
    return !loading ? MaterialApp(
      color: Colors.red,
      home: Stack(

        children: <Widget>[
          Background(),
          DashBoard(),
          MainPage(),
          

        ],
      ),
    ) : Container(
      color: black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Theme(
            data: ThemeData(accentColor: white),
            child: CircularProgressIndicator())
        ],
      ),
    );
  }
  Widget DashBoard(){
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: isdashboard ? 0 : -0.6*width,
      right: isdashboard ? 0 : 0.6*width,
      duration: Duration(milliseconds: 300),
      child: Container(
        color: black,
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left:0.16*width,top:0.15*height),
                child: FutureBuilder(
                  future: firebaseAuth.currentUser(),
                  builder: (context,snapdshot){
                    if(!snapdshot.hasData){return CircularProgressIndicator();}
                    return Column(
                      children: <Widget>[
                      Material(
                        elevation: 14,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: NetworkImage(snapdshot.data.photoUrl),
                            fit: BoxFit.cover,
                            )
                          ),
                        
                        ),
                      ),
                      //Text(snapdshot.data.email)
                      ]
                    );
                  },
                ),
              ),
              SizedBox(height: 8,),
              Container(
                padding: EdgeInsets.only(left:0.12*width,right: 0.5*width),
                child: FutureBuilder(
                  future: firebaseAuth.currentUser(),
                  builder: (context,snap){
                    if(!snap.hasData){return CircularProgressIndicator();}
                    String name = snap.data.email.replaceAll('@gmail.com','');
                    return Text(
                      
                      name,style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        color: white
                      ),overflow: TextOverflow.ellipsis
                    );
                  },
                ),
              ),
              SizedBox(height: 15,),
              Divider(
                color: white,
                thickness: 0.1,
                indent: 10,
                endIndent: 0.5*width,
              ),
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.only(left:0.05*width),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentSubjects()));
                  },
                  child: Text('Subjects',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: white
                  ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.only(left:0.05*width),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (c) => Cources()));
                  },
                  child: Text('Courses',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: white
                  ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              // Padding(
              //   padding: EdgeInsets.only(left:0.05*width),
              //   child: InkWell(
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (c)=>Mystudents()));
              //     },
              //     child: Text('Mystudents',
              //     style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.w500,
              //       letterSpacing: 2,
              //       color: white
              //     ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 0.2*height,),
              Padding(
                padding: EdgeInsets.only(left:0.05*width),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    await firebaseAuth.signOut();
                    GoogleSignIn googleSignIn = new GoogleSignIn();
                    await googleSignIn.signOut();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StartPage()));
                  
                  },
                  child: Text('Logout',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color:white
                  ),
                  ),
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
  Widget MainPage(){
    final  h = MediaQuery.of(context).padding.top;
    
    return AnimatedPositioned(
      
      top: isdashboard ? 0.1*height : 0,
      bottom: isdashboard ? 0.1*height : 0,
      left: isdashboard ? 0.6*width : 0,
      right: isdashboard ? -0.6*width : 0,
      duration: Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              //padding: const EdgeInsets.fromLTRB(v,0,0,0),
              child: Material(
                color: black,
                elevation: 8,
              borderRadius: BorderRadius.circular(10),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              SizedBox(height: h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [IconButton(
                   onPressed: (){
                     setState(() {
                       isdashboard = !isdashboard;
                     });
                   },
                   icon: Icon(Icons.menu),
                   color: white,
                   
                 ), 
                Center(child: Text('Updates',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: white
                ),
                )),
                IconButton(
                  icon: Icon(Icons.lightbulb_outline,color: white,),
                  onPressed: (){
                    setState(() {
                     Color temp = white;
                     white = black;
                     black = temp;
                    });
                  },
                )
                 ]
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(height: 15,),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        informations(),
                        SizedBox(height: 10,),
                        //addinformation(),
                      ],
                    ),
                  ),
                ),
              )
              
        ],)
      ),
            ),
          ),
    );
  }
  Widget Background(){
    return Container(
      decoration: BoxDecoration(
        color: black
      ),
    );
  }
  Widget informations(){
    return Container(
      height: 0.25*height,
      child: FutureBuilder(
        future: Firestore.instance.collection('pages').getDocuments(),
        builder: (c,data){
          if(data.hasData){
          return PageView.builder(
            scrollDirection: Axis.horizontal,
          physics: ClampingScrollPhysics(),
          pageSnapping: true,
          controller: PageController(
            viewportFraction: 1,
            keepPage: true
          ),
          itemBuilder: (c,i){
          
            return Padding(
              padding: const EdgeInsets.fromLTRB(14,20,14,20),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: black,
                elevation: 16,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(
                        data.data.documents[i]['information'],
                        style: TextStyle(
                          color: white,
                          fontSize: 17
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(),
                          // IconButton(
                          //   onPressed: ()async {
                          //     setState(() {
                          //       loading = true;
                          //     });
                          //     await Firestore.instance.collection('pages').document(data.data.documents[i].documentID).delete();
                          //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignedIn()));
                          //     setState(() {
                          //       loading= false;
                          //     });
                          //   },
                          //   icon: Icon(
                          //     Icons.delete,
                          //     color: Colors.white,
                          //     ),
                          // )
                        ],
                      )
                      ]
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: data.data.documents.length ,
          );
          }
          return Container(
            padding: EdgeInsets.only(left: 0.4*width,top: 0.4*height),
          );
          }
      ),
    );
    
  }
  Widget addinformation(){
    final controller = new TextEditingController();
    final controller1 = new TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        SizedBox(
        width: 0.9*width,
        child: Theme(
          data: ThemeData(primaryColor: white),
          child: TextField(
            controller: controller,
            style: TextStyle(color: white),
            decoration: InputDecoration(
              hintText: 'Add information',
              hintStyle: TextStyle(color: white),
              border: OutlineInputBorder(
              ),
              
            ),
          ),
        ),
      ),
      SizedBox(height: 10,),
      SizedBox(
        width: 0.9*width,
        child: RaisedButton(
          color: black,
          elevation: 14,
          onPressed: () async {
            setState(() {
              loading = true;
            });
            if(controller.text.isNotEmpty){
              await Firestore.instance.collection('pages').add({'information':controller.text});
              Navigator.of(context).push(MaterialPageRoute(builder: (c)=> SignedIn()));
            }
            setState(() {
              loading = false;
            });
          },
          child: Text('Add',style: TextStyle(color: white),),
          ),
      ),
      SizedBox(height: 10,),
      SizedBox(
        width: 0.9*width,
        child: Theme(
          data: ThemeData(primaryColor: white),
          child: TextField(
            controller: controller1,
            style: TextStyle(color: white),
            decoration: InputDecoration(
              hintText: 'Enter email of student',
              hintStyle: TextStyle(color: white),
              border: OutlineInputBorder(
              ),
              
            ),
          ),
        ),
      ),
      SizedBox(height: 10,),
      SizedBox(
        width: 0.9*width,
        child: RaisedButton(
          color: black,
          elevation: 14,
          onPressed: () async {
            setState(() {
              loading = true;
            });
            if(controller1.text.isNotEmpty){
              final FirebaseUser user = await firebaseAuth.currentUser();
              
              final QuerySnapshot result =await Firestore.instance.collection('users').where('email', isEqualTo: controller1.text).getDocuments();
              String student =result.documents[0]['id'];
              print(user.uid);
              print(student);
              await Firestore.instance.collection('students').document(user.uid).collection('students').document(student).setData({'email':controller1.text});
              Navigator.of(context).push(MaterialPageRoute(builder: (c)=> SignedIn()));
            }
            setState(() {
              loading = false;
            });
          },
          child: Text('Add student',style: TextStyle(color: white),),
          ),
      ),
      SizedBox(height: 500,)
      ]
    );
  }
}
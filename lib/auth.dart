 import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/material.dart';

 import 'package:google_sign_in/google_sign_in.dart';

 import 'package:cloud_firestore/cloud_firestore.dart';

 import 'package:firebase_storage/firebase_storage.dart';
import 'package:s8/StartPage.dart';
import 'package:s8/signedin.dart';
import 'package:s8/studentsignin.dart';

// import 'package:fluttertoast/fluttertoast.dart';

// //import 'package:shared_preferences/shared_preferences.dart';

// import 'package:image_picker/image_picker.dart';

// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:intl/intl.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool loading = false;
  GoogleSignIn googleSignIn = new GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  getval ()async{
    final user = await firebaseAuth.currentUser();
    if(user!=null){
      final QuerySnapshot result =await Firestore.instance.collection('users').where('id', isEqualTo: user.uid).getDocuments();
      if(result.documents[0]['position'] !=  null){
        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>SignedIn()));
      }
      else{
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
                //print(Myfaculty);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentMainPage()));
                loading = false;
              });
            }
          }
        }
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getval();
  }

  @override
  Widget build(BuildContext context) {
    //print(firebaseAuth.currentUser());
    return Container(
         child:  Container(
           color: black,
           padding: EdgeInsets.only(top:100),
           //color: Colors.white,
        child: Align(
          alignment: Alignment.bottomCenter,
                  child: Center(
            
            child: SizedBox(
              
              height: 40,
              width: 140,
                child: !loading ? RaisedButton(
                  color: black,
                  elevation: 10,
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    GoogleSignInAccount googleUser = await googleSignIn.signIn();
                    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                    final AuthCredential credential = GoogleAuthProvider.getCredential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                    );
                    FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

                    if (firebaseUser != null) {
      // Check is already sign up
                    final QuerySnapshot result =
                        await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
                    final List < DocumentSnapshot > documents = result.documents;
                    if (documents.length == 0) {
                        // Update data to server if new user
                        Firestore.instance.collection('users').document(firebaseUser.uid).setData(
                            { 'nickname': firebaseUser.displayName, 'photoUrl': firebaseUser.photoUrl, 'id': firebaseUser.uid ,'email':firebaseUser.email});
                    }
                      if(isFaculty){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignedIn()));
                      setState(() {
                        loading = false;
                      });
                      }
                      else{
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
                              //print(Myfaculty);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentMainPage()));
                              loading = false;
                            });
                          }
                        }
                      }
                    }
                    
                    
                }
                
                              },
                            child: Text('google sign in',
                            style: TextStyle(
                              color: white
                            ),),
              ) : Container(
                padding: EdgeInsets.only(left:50,right: 50),
                  height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  
                ),
              )
            ),
          ),
        ),
      )
    );
  }
}
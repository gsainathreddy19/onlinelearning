
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:s8/Cources.dart';
import 'package:s8/previews.dart';
import 'package:s8/signedin.dart';


Map<String,String> questions = {};
class newcard extends StatefulWidget {
  String uniqueid;
  int ite;
  bool t;
  Map<String,String> s;
  newcard(this.uniqueid,this.s,this.ite,this.t);
  @override
  _newcardState createState() => _newcardState();
}
String unid;
int item = 0;

class _newcardState extends State<newcard> {
TextEditingController questioncontroller;
TextEditingController option1controller;
TextEditingController option2controller;
TextEditingController option3controller;
TextEditingController option4controller;
TextEditingController answercontroller;

@override
initState() {
  questioncontroller = new TextEditingController();
  answercontroller = new TextEditingController();
  option1controller = new TextEditingController();
  option2controller = new TextEditingController();
  option3controller = new TextEditingController();
  option4controller = new TextEditingController();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
     if( widget.t ){
      unid = widget.uniqueid;
      item = widget.ite;
      questions = widget.s;
      widget.t = false;
     }
    
      return Scaffold(
        backgroundColor: black,
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            
           children: <Widget>[
             SizedBox(height: MediaQuery.of(context).padding.top,),
             Row(children: <Widget>[
               IconButton(
                 onPressed: (){
                   Navigator.of(context).pop();
                 },
                 icon: Icon(Icons.arrow_back,color: white,),
               ),
               SizedBox(width: 0.28*MediaQuery.of(context).size.width,),
               Text('Assignment',style: TextStyle(
                 color: white,
                 fontSize: 17,
                 fontWeight: FontWeight.w700
               ),)
             ],),
             Divider(color: white,thickness: 0.6,
             indent: 15,endIndent: 15,
             ),
              SizedBox(
               width: 0.85*MediaQuery.of(context).size.width,
               child: new RaisedButton(
                 elevation: 8,
                 color: black,
                 child: Text('Add Question',
                 style: TextStyle(color: white,
                 fontWeight: FontWeight.bold),),
                 
                 onPressed: (){
                      setState(() {
                        item = item+1;
                      });
                     showDialog1(item,"","","","","","",true);
                 }),
             ),
             Container(
               height: 0.7*MediaQuery.of(context).size.height,
                child: ListView.builder(
                 itemCount: questions.length,
                 itemBuilder: (BuildContext context,int index)
                 {
                   return new Column(
                     children: <Widget>[
                  
                    ListTile(
                     title:new Text('  Question : '+(index+1).toString(),style: TextStyle(color: white),),
                     trailing: IconButton(
                         icon: Icon(Icons.edit,color: white,),
                         onPressed: (){
                           //print(questions[(index+1).toString()]);
                           var que = questions[(index+1).toString()].split('/');
                       String q = que[0];
                       String o1 = que[1];
                       String o2 = que[2];
                       String o3 = que[3];
                       String o4 = que[4];
                       String a = que[5];
                       showDialog1(index+1, q, o1, o2, o3, o4, a, false);
                         },
                       ),
                   ),
                   Divider(height: 0.15,color: white,indent: 20,endIndent: 20,),
                   
                     ],
                   );
                   
                 }
                 
                 ),
             ),

          SizedBox(
           width: 0.85*MediaQuery.of(context).size.width,
                  child: new RaisedButton(
             elevation: 8,
             color: black,
             child: Text('Preview',style: TextStyle(color: white,fontWeight: FontWeight.bold,
             fontSize: 17,
             letterSpacing: 1.6
             ),),
             
             onPressed: (){
              
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => preview(questions)));
         
             }),
         
         ),
         SizedBox(
           width:0.85*MediaQuery.of(context).size.width,
                  child: new RaisedButton(
             elevation: 8,
             color: black,
             child: Text('Submit',style: TextStyle(
               color: white,fontWeight: FontWeight.bold,
               fontSize: 17,
               letterSpacing: 1.6
               ),),
             
             onPressed: (){
               createdata(unid);
                 
             }),
         
         ),
           ],
         
         ),
      ),
      
    );
  }

  viewpreview()
  {

     Navigator.of(context).push(MaterialPageRoute(builder: (context) => preview(questions)));
           

  }

  Future showDialog1(int ind,String question,String option1,String option2,String option3,String option4,String answer,bool ne) async {
  setState(() {
    //first = false;
    questioncontroller.text = question;
    option1controller.text = option1;
    option2controller.text = option2;
    option3controller.text = option3;
    option4controller.text = option4;
    answercontroller.text = answer;
  });
  await showDialog<String>(
    context: context,
    child: AlertDialog(
      backgroundColor: black,
      contentPadding: const EdgeInsets.all(8.0),
      content: Theme(
        data: ThemeData(accentColor: white,primaryColor: white,primaryColorDark: white),
        child: SingleChildScrollView(
          
          scrollDirection: Axis.vertical,
                child: Column(
            children: <Widget>[
              Text("Please fill all details",style: TextStyle(
                color: white,
                fontSize: 16,fontWeight: FontWeight.w700
              ),),
              SizedBox(height: 10,),
               SizedBox(
                child: TextField(
                  autofocus: true,
                  style: TextStyle(color: white),
                  decoration: InputDecoration
                  (
                    prefixText: 'Q.',
                    prefixStyle: TextStyle(color: white),
                    hintText: 'Question',
                    hintStyle: TextStyle(color: white),
                    suffixIcon: IconButton(icon:Icon(Icons.close,color: white,size: 14,),
                    onPressed: (){
                      setState(() {
                        questioncontroller.text = '';
                      });
                    },
                    )
                  ),
                  controller: questioncontroller,
                  
                ),
              ),
             SizedBox(
                child: TextField(
                  autofocus: true,
                  style: TextStyle(color: white),
                  decoration: InputDecoration
                  (
                    prefixText: '1.',
                    prefixStyle: TextStyle(color: white),
                    hintText: 'Option 1',
                    hintStyle: TextStyle(color: white),
                    suffixIcon: IconButton(icon:Icon(Icons.close,color: white,size: 14,),
                    onPressed: (){
                      setState(() {
                        option1controller.text = '';
                      });
                    },
                    )
                  ),
                  controller: option1controller,
                ),
              ),
               SizedBox(
                child: TextField(
                  autofocus: true,
                  style: TextStyle(color: white),
                  decoration: InputDecoration
                  (
                    prefixText: '2.',
                    prefixStyle: TextStyle(color: white),
                    hintText: 'Option 2',
                    hintStyle: TextStyle(color: white),
                    suffixIcon: IconButton(icon:Icon(Icons.close,color: white,size: 14,),
                    onPressed: (){
                      setState(() {
                        option2controller.text = '';
                      });
                    },
                    )
                  ),
                  controller: option2controller,
                ),
              ),
                SizedBox(
                child: TextField(
                  autofocus: true,
                  style: TextStyle(color: white),
                  decoration: InputDecoration
                  (
                    prefixText: '3.',
                    prefixStyle: TextStyle(color: white),
                    hintText: 'Option 3',
                    hintStyle: TextStyle(color: white),
                    suffixIcon: IconButton(icon:Icon(Icons.close,color: white,size: 14,),
                    onPressed: (){
                      setState(() {
                        option3controller.text = '';
                      });
                    },
                    )
                  ),
                  controller: option3controller,
                ),
              ),
               SizedBox(
                child: TextField(
                  autofocus: true,
                  style: TextStyle(color: white),
                  decoration: InputDecoration
                  (
                    prefixText: '4.',
                    prefixStyle: TextStyle(color: white),
                    hintText: 'Option 4',
                    hintStyle: TextStyle(color: white),
                    suffixIcon: IconButton(icon:Icon(Icons.close,color: white,size: 14,),
                    onPressed: (){
                      setState(() {
                        option4controller.text = '';
                      });
                    },
                    )
                  ),
                  controller: option4controller,
                ),
              ),
                SizedBox(
                child: TextField(
                  autofocus: true,
                  style: TextStyle(color: white),
                  decoration: InputDecoration
                  (
                    prefixText: 'Answer : ',
                    prefixStyle: TextStyle(color: white),
                    hintText: '1/2/3/4',
                    hintStyle: TextStyle(color: white),
                    suffixIcon: IconButton(icon:Icon(Icons.close,color: white,size: 14,),
                    onPressed: (){
                      setState(() {
                        answercontroller.text = '';
                      });
                    },
                    )
                  ),
                  controller: answercontroller,
                ),
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel',
          style: TextStyle(color: white),
          ),
          onPressed: () {
            questioncontroller.clear();
            option1controller.clear();
            option2controller.clear();
            option3controller.clear();
            option4controller.clear();
            answercontroller.clear();
            Navigator.pop(context);
          }),
       ne ? FlatButton(
          child: Text('Add',
          style: TextStyle(color: white),
          ),
          onPressed: () {
            if (questioncontroller.text.isNotEmpty && option1controller.text.isNotEmpty &&
            option2controller.text.isNotEmpty && option3controller.text.isNotEmpty &&
                option1controller.text.isNotEmpty && answercontroller.text.isNotEmpty) {
                String st = questioncontroller.text + '/' + option1controller.text + '/' + option2controller.text + '/' + option3controller.text + '/' + option4controller.text + '/' + answercontroller.text;
               setState(() {
                 questions[ind.toString()] = st;
               });
               // questions[ind.toString()] = st;
                   Navigator.pop(context);
          print(questions);
          }
        }):
        FlatButton(
          child: Text('Update',
          style: TextStyle(color: white),
          ),
          onPressed: () {
            if (questioncontroller.text.isNotEmpty && option1controller.text.isNotEmpty &&
            option2controller.text.isNotEmpty && option3controller.text.isNotEmpty &&
                option1controller.text.isNotEmpty && answercontroller.text.isNotEmpty) {
                String st = questioncontroller.text + '/' + option1controller.text + '/' + option2controller.text + '/' + option3controller.text + '/' + option4controller.text + '/' + answercontroller.text;
               setState(() {
                   questions[ind.toString()] = st;
               });
                Navigator.pop(context);
             
          }
        })

      

      ],
    ),
  );
}



createdata(String unid) async{
DocumentReference reference = Firestore.instance.document("Assignment/" + Courseid );
reference.setData(questions);

  }
}
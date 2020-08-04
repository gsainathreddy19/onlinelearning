import 'package:flutter/material.dart';
import 'package:s8/signedin.dart';


class preview extends StatefulWidget {
  Map<String,String> ques;
  preview(this.ques);
  @override
  _previewState createState() => _previewState();
}
Map<String,String> quest;
bool op1 = false;
bool op2 = false;
bool op3 = false;
bool op4 = false;

class _previewState extends State<preview> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1.0);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    quest = widget.ques;
    return Scaffold(
      backgroundColor: black,
      body:Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top,),
          Row(children: <Widget>[
            
            IconButton(icon: Icon(Icons.arrow_back,color: white,
            ),
            onPressed: (){
              Navigator.of(context).pop();
            },
            ),
            SizedBox(width: 0.27*MediaQuery.of(context).size.width,)
            ,Text('Assignment',style: TextStyle(
              color: white,
              letterSpacing: 1.6,
              fontSize: 17,
              fontWeight: FontWeight.w700
            ),)
          ],),
          Divider(
            height: 1,
            thickness: 0.4,indent: 20,endIndent: 20,color: white,),
          Expanded(
            child: PageView.builder(
                 itemCount: quest.length,
                 
                 controller: _controller,
                    
    
                   itemBuilder: (BuildContext context,int index)
                   {
                     var qu = quest[(index+1).toString()].split('/');
                     print(qu);
                     String q = qu[0];
                     String o1 = qu[1];
                     String o2 = qu[2];
                     String o3 = qu[3];
                     String o4 = qu[4];
                     String a = qu[5];
                     
                     return Container(
                       color: black,
                       padding: EdgeInsets.all(10),
                       child: Material(
                         color: black,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>[
                             SizedBox(height: 8,),
                             Text('Question :',style: TextStyle(color: white),),
                             Divider(height: 1,color: white,thickness: 0.15,),
                             SingleChildScrollView(
                               child: Container(
                                 height: 150,
                                 margin: EdgeInsets.all(10),
                                 child: Text(q,style: TextStyle(color: white),),
                               ),
                             ),
                             //Divider(height: 1,color: white,thickness: 0.15,),
                             Text('Options :',style: TextStyle(color: white),),
                             Divider(height: 1,color: white,thickness: 0.15,),
                             SingleChildScrollView(
                               scrollDirection: Axis.vertical,
                               child: Container(
                                 height: 300,
                                 margin: EdgeInsets.all(10),
                                 child: Column(
                                   children: <Widget>[
                                     CheckboxListTile(
                                       onChanged: (bool b){
                                         setState(() {
                                           op1 = b;
                                           //print(op1);
                                         });
                                         
                                       },
                                       value: op1,
                                       selected: op1,
                                       title: SingleChildScrollView(
                                         scrollDirection: Axis.horizontal,
                                         child: Text(o1,style: TextStyle(color: white),),
                                       ),
                                     ),
                                     CheckboxListTile(
                                       onChanged: (b){
                                         setState(() {
                                           op2 = b;
                                         });
                                       },
                                       value: op2,
                                       selected: op2,
                                       title: SingleChildScrollView(
                                         scrollDirection: Axis.horizontal,
                                         child: Text(o2,style: TextStyle(color: white),),
                                       ),
                                     ),
                                     CheckboxListTile(
                                       onChanged: (bool b){
                                         setState(() {
                                           op3 = b;
                                           print(op1);
                                         });
                                         
                                       },
                                       value: op3,
                                       selected: op3,
                                       title: SingleChildScrollView(
                                         scrollDirection: Axis.horizontal,
                                         child: Text(o3,style: TextStyle(color: white),),
                                       ),
                                     ),
                                     CheckboxListTile(
                                       onChanged: (bool b){
                                         setState(() {
                                           op4 = b;
                                           
                                         });
                                         
                                       },
                                       value: op4,
                                       selected: op4,
                                       title: SingleChildScrollView(
                                         scrollDirection: Axis.horizontal,
                                         child: Text(o4,style: TextStyle(color: white),),
                                       ),
                                     ),
                                   ],
                                 )
                               ),
                             ),
                             //Divider(height: 1,color: white,thickness: 0.15,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 0.25*MediaQuery.of(context).size.width,
                                  child: RaisedButton(
                                    color: black,
                                    elevation: 4,
                                    onPressed: (){
                                      _controller.previousPage(duration:Duration(milliseconds: 300), curve: Curves.bounceInOut);
                                    },
                                    child: Icon(Icons.arrow_back_ios,color: white,),
                                  ),
                                ),
                                SizedBox(
                                  width: 0.25*MediaQuery.of(context).size.width,
                                  child: RaisedButton(
                                    color: black,
                                    elevation: 4,
                                    onPressed: (){
                                      _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.bounceInOut);
                                    },
                                    child: Icon(Icons.arrow_forward_ios,color: white,),
                                  ),
                                )
                              ],
                            )
                           ],
                         ),
                         
                       ),
                     );
                   }
                     ),
          ),]
      ),

 

                   
                
              
              
      
    );
  }
  Widget car1(){

    return Padding(padding: EdgeInsets.only(top:100,left:20,right:20),
    
     child: Container(
       width: 500,
       height: 500,
       child: new Card(
         
         elevation: 10,

         child:Column(
           children: <Widget>[
             Text('what is your namewhat is your namewhat is your namewhat is your namewhat is your namewhat is your name',),
             SizedBox(height: 30,),
             Container(
               
               height: 50,
               width: 300,
               decoration: BoxDecoration(
                   border: Border.all(
        color: Colors.black,
        
      ),
                  borderRadius: BorderRadius.circular(8.0)),

               child: Row(
                 children: <Widget>[
                  Icon(
      Icons.account_balance_wallet),
                   Center(child: Text('option1',  style: TextStyle( color: Colors.black),)),
                 ],
               ),
             ),
             
             Text('option2'),
             Text('option3'),
             Text('option4'),

            


           ],
         ),


       ),
     )


    );
  }
}
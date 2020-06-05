import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pollingsystem/screens/Projects.dart';

class MPdetails extends StatefulWidget {
  final String id;
  final bool flag;
   MPdetails({this.id,this.flag});
  @override
  _MPdetailsState createState() => _MPdetailsState();
}

class _MPdetailsState extends State<MPdetails> {
 _likedislike(like,dislike){

 }
  @override
  Widget build(BuildContext context) {
   //  print(widget.id);
    // print(Firestore.instance.collection('City/'+widget.id+'/Mpdetails').snapshots());
   return new Scaffold(

      appBar: new AppBar(
        title: Text("MP Details",style:TextStyle(color:Colors.black),),
        backgroundColor: Colors.yellow,
      ),
      body:StreamBuilder(
        stream:Firestore.instance.collection('City/'+widget.id+'/Mpdetails').snapshots(),
        builder: (context, snapshot){
         
             return ListView.builder(
               itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return ListTile(
                 title: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   textDirection: TextDirection.ltr,
                   children: <Widget>[
                    new Container(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        margin: const EdgeInsets.all(10.0),
                        // padding: const EdgeInsets.all(3.0),
                        child: ClipOval(
                          child: Icon(Icons.person,size:70)
                        ),
                      )),
                       SizedBox(height:20),
                   Text("M.P: "+snapshot.data.documents[index]['name'],style: TextStyle(fontSize: 20.0, color: Colors.black,fontWeight: FontWeight.bold,)),
                 
                   Divider(),
                    SizedBox(height:20),
                   Text("E-Mail: "+snapshot.data.documents[index]['E-mail'],style: TextStyle(fontSize: 18.0, color: Colors.black, )),
                 

                   Divider(),
                    SizedBox(height:20),
                   Text("Contact: "+snapshot.data.documents[index]['Contact'].toString(),style: TextStyle(fontSize: 18.0, color: Colors.black)),
                   

                   Divider(),
                    SizedBox(height:20),
                   Text("Constituency: "+snapshot.data.documents[index]['Constituency'],style: TextStyle(fontSize: 18.0, color: Colors.black,)),
                    

                   Divider(),
                    SizedBox(height:20),
                   Text("Address: "+snapshot.data.documents[index]['Address'],style: TextStyle(fontSize: 18.0, color: Colors.black)),
                  
                    Divider(),
                   
   SizedBox(height:20),
                   Text("Rating: "+snapshot.data.documents[index]['Rating'].toString()+"%",style: TextStyle(fontSize: 18.0, color: Colors.black)),
                   
                   Divider(),
                     FlatButton.icon(
           icon: Icon(Icons.book),
           label: Text("Current Projects",style: TextStyle(fontSize: 20.0, color: Colors.black)),
           onPressed: (){ Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>ProjectDetails(id:index.toString(),
    mpid:widget.id,flag:widget.flag)),
  );} )
                 ],)
                 ); }
             );
         
        },)
     
     
    );
   
  }
}
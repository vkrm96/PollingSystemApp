import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
 final String id;
 final String pid;
 final String mpid;
  CommentScreen({this.id,this.pid,this.mpid});
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  String comment;
  int len=0;
  
  @override
  
  Widget build(BuildContext context) {
    
     final  CollectionReference udatacollection=Firestore.instance.collection('City/'+widget.mpid+'/Mpdetails/'+widget.pid+'/Projects/'+widget.id+'/Comments');
_count(index){

    len=index;
  }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title:Text("Comment",style:TextStyle(color:Colors.black)),),
    body:Column( 
      children: <Widget>[
        Expanded(child: StreamBuilder(
        stream:Firestore.instance.collection('City/'+widget.mpid+'/Mpdetails/'+widget.pid+'/Projects/'+widget.id+'/Comments').snapshots() ,
        
        builder: (context, snapshot){
         
             return ListView.builder(
               
               itemCount: snapshot.data.documents.length,
            //  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:5/2),
              itemBuilder: (context, index){
                return Column(
                  
                  children:<Widget>[ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                    child:Icon(Icons.person)),
                title:Text(snapshot.data.documents[index]['comment'],style:TextStyle(fontWeight: FontWeight.bold)),
                 subtitle: _count(index+1)
                 ),
                 Divider(),
                 ] ); }
             );
               

        },)

      
      )  ,
       new ListTile(
                  trailing: IconButton(
            icon: Icon(Icons.send),
            onPressed: ()async{
              len=len+1;
             return await udatacollection.document(len.toString()).setData({
             'comment':comment,

});
            }),
                      title: TextFormField(
              decoration: InputDecoration(
                hintText:"Add comments",
                
              ),
               validator:(val)=>val.isEmpty ? 'Please enter comment': null,
            onChanged: (val)=>setState(()=> comment=val),
            ),
                     ),
       
         
    ]  ) );
  }
}
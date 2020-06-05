import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pollingsystem/Authentication/DatabaseService.dart';
import 'package:pollingsystem/Authentication/User.dart';
import 'package:pollingsystem/screens/CommentScreen.dart';
import 'package:provider/provider.dart';



class ProjectDetails extends StatefulWidget {
   final String id;
   final String mpid;
   final bool flag;

   
   ProjectDetails({this.id,this.mpid,this.flag});
  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {


 
  int like;
  int dislike;

  @override
  Widget build(BuildContext context) {

                  final user=Provider.of<User>(context);

final  CollectionReference udatacollection=Firestore.instance.collection('City/'+widget.mpid+'/Mpdetails/'+widget.id+'/Projects');
final  CollectionReference udata3collection=Firestore.instance.collection('City/'+widget.mpid+'/Mpdetails');
_likedata(index,like)async{

return await udatacollection.document(index.toString()).updateData({
              'like':like,            
              

});
}


_dislikedata(index,dislike)async{

return await udatacollection.document(index.toString()).updateData({
              'dislike':dislike,            
              
});
}


      print(widget.id);
  print(widget.mpid);

   return new Scaffold(

      appBar: new AppBar(
        title: Text("Projects",style:TextStyle(color:Colors.black)),
        backgroundColor: Colors.yellow,
      ),
      body:StreamBuilder(
        stream:Firestore.instance.collection('City/'+widget.mpid+'/Mpdetails/'+widget.id+'/Projects').snapshots(),
        builder: (context, snapshot){
         
             return ListView.builder(
               itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                
                
                if (snapshot.data.documents!=null)
                {
                 
                return ListTile(
                  
                 title: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   textDirection: TextDirection.ltr,
                   children: <Widget>[

                   Text(snapshot.data.documents[index]['project'],style: TextStyle(fontSize: 20.0, color: Colors.black,fontWeight: FontWeight.bold,)),
                    Text(snapshot.data.documents[index]['projecct details'],style: TextStyle(fontSize: 20.0, color: Colors.black,)),
                 Text("STATUS: "+snapshot.data.documents[index]['status'],style: TextStyle(fontSize: 20.0, color: Colors.black,)),

                   Row(
                      children: <Widget>[
                 
                 
              
     IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: ()async{
                like=snapshot.data.documents[index]['like'];
                like=like+1;
               _likedata(index,like);
              },
             
               
    ),
           Text(snapshot.data.documents[index]['like'].toString()),
                     SizedBox(width:10),
         
    IconButton(
              icon: Icon(Icons.thumb_down),
              onPressed: ()async{
                 dislike=snapshot.data.documents[index]['dislike'];
                 dislike=dislike+1;
                _dislikedata(index,dislike);
              
               
              },
             
               
               
            
           ),     
 Text(snapshot.data.documents[index]['dislike'].toString()),
                     SizedBox(width:10),
                     FlatButton.icon(
           icon: Icon(Icons.comment),
           label:Text(''),
           onPressed: ()async{
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>CommentScreen( 
      id:index.toString(),
      pid:widget.id,
      mpid:widget.mpid,
    )),
    
  );

   return await udata3collection.document(0.toString()).updateData({
               
            'Rating': ((like/(like+dislike))*100).round()

                 
                });
            } ),]),
                    Divider(),
                   
                    
                 ],)
                 ); }
               } );
         
        },)
   
     );  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pollingsystem/Authentication/DatabaseService.dart';
import 'package:pollingsystem/Authentication/Loading.dart';
import 'package:pollingsystem/Authentication/User.dart';
import 'package:pollingsystem/Authentication/auth.dart';
import 'package:pollingsystem/screens/MPdetails.dart';
import 'package:pollingsystem/screens/Search.dart';
import 'package:pollingsystem/screens/Settings.dart';

import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  bool flag;
  HomeView({this.flag});
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

   final AuthService _auth=AuthService();
  
  @override
  
  Widget build(BuildContext context) {
             final user=Provider.of<User>(context);

          final  CollectionReference udatacollection=Firestore.instance.collection('Udata');


  print(udatacollection);
    print(user.uid);

    return new Scaffold(

      appBar: new AppBar(
        title: Text("City",style:TextStyle(color:Colors.black)),
        backgroundColor: Colors.yellow,
       
      ),
      drawer: new Drawer(
        child: new ListView(
           
            
          children: <Widget>[
          
     StreamBuilder<UserData>(
      stream:DatabaseService(uid:user.uid).userData,
            
           builder: (context, snapshot){
        if(snapshot.hasData)
        {
          UserData userData=snapshot.data;
   
    return Card(
             child:Container(
               color: Colors.yellow,
              
              height: 180,
               
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[Icon(Icons.person,size: 70,),
              Text(userData.name,style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
              Text(userData.mail,style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                     ]) ),
               
              );}
    else{
     return Loading();
    }}
           ),     
    
            new Column(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.home),
                      title: new Text("home"),
                      onTap: () {
                        
                      }),
                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.settings),
                      title: new Text("Settings "),
                     onTap: () {
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>SettingForm()),
  );
                      }),
                       new Divider(),
                       new ListTile(
                      leading: Icon(Icons.arrow_left),
                      title: new Text("Logout"),
                      onTap: ()async {
                      await _auth.signOut();

                        }),
                      new Divider(),
                      
                ],
              ),
            
           
          ],
        ),
      ),
      body:
      Center(
        
        child:
      StreamBuilder(
        stream:Firestore.instance.collection('City').snapshots() ,
        
        builder: (context, snapshot){
             return ListView.builder(
               itemCount: snapshot.data.documents.length,
            //  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:5/2),
              itemBuilder: (context, index){
                if(snapshot.data.documents[index]['cname']!=null)
                {
                              return Card(
                                child: ListTile(
                 leading:  CircleAvatar(
                   backgroundColor: Colors.black,
                    child:Icon(Icons.location_city)),              
                 title:Text(snapshot.data.documents[index]['cname'],style:TextStyle(fontSize:25,fontWeight: FontWeight.bold)),
                 
                 onTap: (){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>MPdetails(id:index.toString(),flag:widget.flag)),
  );
                 },
                               ) ); }
                 else
                 {
                   return Loading();
                 }
                 }   );
         
        },)
     
     
      )  );
   
        
  }
}
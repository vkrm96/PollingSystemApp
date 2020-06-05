import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pollingsystem/Authentication/DatabaseService.dart';
import 'package:pollingsystem/Authentication/User.dart';
import 'package:pollingsystem/home.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  String mail;
  FormScreen({this.mail});
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formkey=GlobalKey<FormState>();
 
  String _currentName;
  String _city;
 
  int contact;
  int aadhar;
  bool loading=false;
  bool flag=true;
void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Details Added"),
          
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
              Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>HomeView()),
  );
     
              },
            ),
          ],
        );
      },
    );
  }

  @override

  Widget build(BuildContext context) {
     final user=Provider.of<User>(context);
          final  CollectionReference udatacollection=Firestore.instance.collection('Udata');

    return Scaffold(
   appBar: new AppBar(
       backgroundColor: Colors.yellow,
       title: Text("Add User Details",style:TextStyle(color:Colors.black)),
       
     ),
    body: 
     
       
     Form(
     key: _formkey,
     child: Column(
       children:<Widget>[
           Container(
           height:210.00,
           width:700.0,
               color: Colors.blueGrey,
             
            padding:EdgeInsets.all(80),
              
                    child:Icon(Icons.person,size:70,color: Colors.yellow,),
             ),
               
          TextFormField(
            decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.person,color: Colors.black,),
                                          hintText: 'Enter Name',
                                          labelText: 'Name',
                                          labelStyle: TextStyle(color: Colors.black)
                                      ),
            validator:(val)=>val.isEmpty ? 'Please enter name': null,
            onChanged: (val)=>setState(()=> _currentName=val),
          ),
                    TextFormField(
            decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.location_city,color: Colors.black,),
                                          hintText: 'Enter City',
                                          labelText: 'City',
                                          labelStyle: TextStyle(color: Colors.black)
                                      ),
            validator:(val)=>val.isEmpty ? 'Please enter city': null,
            onChanged: (val)=>setState(()=> _city=val),
          ),
                   
           

      
          
                   
            TextFormField(
              decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.contact_phone,color: Colors.black,),
                                          hintText: 'Enter Phone Number',
                                          labelText: 'Phone Number',
                                          labelStyle: TextStyle(color: Colors.black)
                                      ),
             keyboardType: TextInputType.number,
                 inputFormatters: <TextInputFormatter>[
                   WhitelistingTextInputFormatter.digitsOnly
    ],                     
            validator:(val)=>val.length<10 || val.length>10? 'Please enter Correct number': null,
            onChanged: (val) => setState(()=>contact= num.tryParse(val)),
          ),
          
            TextFormField(
              decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.contacts,color: Colors.black,),
                                          hintText: 'Enter Aadhar Number',
                                          labelText: 'Aadhar Number',
                                          labelStyle: TextStyle(color: Colors.black)
                                      ),
            keyboardType: TextInputType.number,
                 inputFormatters: <TextInputFormatter>[
                   WhitelistingTextInputFormatter.digitsOnly
    ],                     
            validator:(val)=>val.length<12 || val.length>12? 'Please enter Correct number': null,
            onChanged: (val) => setState(()=>aadhar= num.tryParse(val)),
          ),
                     
           SizedBox(height: 20,),
          RaisedButton(
            color:Colors.black,
            child: Text("Update",style:TextStyle(color:Colors.white)),
            onPressed: ()async{
              if(_formkey.currentState.validate()){
                setState(() =>loading=true);
               _showDialog();
                return await udatacollection.document(user.uid).setData({
             'name':_currentName,
             'city':_city,
             'Email':widget.mail,
             'contact':contact,
             'aadhar':aadhar,
            'flag':flag,

                 
                });
           
              }
            })
       ]
     )
    
    
    ),
  
    
    
    );
  }
}
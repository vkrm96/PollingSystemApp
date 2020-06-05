import "package:flutter/material.dart";
import 'package:pollingsystem/Authentication/SignUp.dart';
import 'package:pollingsystem/Authentication/User.dart';
import 'package:pollingsystem/Authentication/auth.dart';
import 'package:pollingsystem/Loading.dart';
import 'package:pollingsystem/home.dart';
import 'package:pollingsystem/screens/Formscreen.dart';
import 'package:provider/provider.dart';
 
 class SignIN extends StatefulWidget {
  @override
  _SignINState createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  @override
  
    final AuthService _auth=AuthService();
final _formkey= GlobalKey<FormState>();
  //text field state
  dynamic result='';
  String email='';
  String password='';
  String error='';
  bool loading=false;

  @override
  Widget build(BuildContext context) {
 
   return  Scaffold(
     
   appBar: AppBar(
     backgroundColor: Colors.yellow,
          title: Text('Polling App',style:TextStyle(color:Colors.black)),
        ),
    body: 
   
    
    Padding(
            padding: EdgeInsets.all(10),
            child:  Form(
              key: _formkey,
              child:ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Polling App',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                    Card(
                      color:Colors.yellow,
                      child:
                    Column (children:<Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child:  TextFormField(
                      decoration: const InputDecoration(
                                         border: OutlineInputBorder(),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.person,color: Colors.black,),
                                          hintText: 'Enter Email',
                                          labelText: 'Email',
                                          labelStyle: TextStyle(color: Colors.black)
                                      ),
                     validator: (val)=>val.isEmpty ? 'Enter email': null,
                    onChanged:(val){
                      setState(()=>email=val );
                    }
                    
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                         
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.lock,color: Colors.black,),
                                          hintText: 'Enter Password',
                                          labelText: 'Password',
                                          labelStyle: TextStyle(color: Colors.black)
                                      ),
                     validator: (val)=>val.length <6 ? 'Enter password 6+ characters': null,
                     obscureText:true,
                    onChanged:(val){
                        setState(()=>password=val );
                    }
                    
                  ),
                ),
                SizedBox(height:30),
                Container(
                  height: 50,
                    padding: EdgeInsets.fromLTRB(90, 0, 90, 0),
                 child: RaisedButton(
                   textColor: Colors.white,
                      color: Colors.black,
                    child: Text("Sign IN",),
                    onPressed: ()async{
                         if(_formkey.currentState.validate()){
                            setState(() =>loading=true);
                             result=await _auth.signInemailpassword(email, password);
                            if (result==null)
                            {
                            setState(() {
                              error='Please enter valid email and password';
                              loading=false;
                            });
                           }
                           else{
                             
  
     Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomeView()),
  );
  
                           }
                         }
                         
                    },
                  ) ),
                
                  Text(
                    error,
                  ),
                    ])),
                 Container(
                  child: Row(
                    children: <Widget>[
                      Text('Does not have account?'),
                      FlatButton(
                        textColor: Colors.black,
                        child: Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                           Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => SignUp()),
  );
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                ))
              
            ])

    )) );

 } }   
import "package:flutter/material.dart";
import 'package:pollingsystem/Authentication/auth.dart';
import 'package:pollingsystem/Loading.dart';
import 'package:pollingsystem/screens/Formscreen.dart';
 
 class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.yellow,
          title: Text('Polling App',style:TextStyle(color:Colors.black)),
        ),
    body: Container(
     
           // padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 20.0),
            child:Form(
              key: _formkey,
              child:Column(
                children: <Widget>[
                 SizedBox(
                    height:40.0
                  ),
Text(
                      'Polling App',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                   SizedBox(
                    height:20.0
                  ),

                  Card(
                    color:Colors.yellow,
                    child:Column(children:<Widget>[
                    Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    )),
                     Container(
                  padding: EdgeInsets.all(10),
                  child:TextFormField(
                     decoration: const InputDecoration(
                                       border: OutlineInputBorder(),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.email,color: Colors.black,),
                                          hintText: 'Your email address',
                                          labelText: 'E-mail',
                                          labelStyle: TextStyle(color: Colors.black)
                                      ),
                    validator: (val)=>val.isEmpty ? 'Enter email': null,
                    onChanged:(val){
                      setState(()=>email=val );
                    }
                  ),),
                 
                   Container(
                  padding: EdgeInsets.all(10),
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
                    
                    ) ),
                    SizedBox(
                    height:20.0
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                      color: Colors.black,
                    child: Text("Sign UP"),
                    onPressed: ()async{
                       if(_formkey.currentState.validate()){
                          setState(() =>loading=true);
                           dynamic result= await _auth.registeremailpassword(email,password);
                          
                            if (result==null)
                            {
                              setState(() {error='Please enter valid details';
                              loading=false;
                              });
                            }
                            else{
                              loading=false;
                               Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => FormScreen(
      mail:email,
    )),
  );
                                    }             }
                    },
                  ) ,
                  Text(
                    error,
                  ),])),
                ],
              ),
             
            ),

    )

   );
  }
}
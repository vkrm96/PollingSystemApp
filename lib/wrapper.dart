import 'package:flutter/material.dart';
import 'package:pollingsystem/Authentication/User.dart';
import 'package:pollingsystem/home.dart';
import 'package:pollingsystem/screens/Formscreen.dart';
import 'package:pollingsystem/signin.dart';
import 'package:provider/provider.dart';


 class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final user=Provider.of<User>(context);
  if (user==null){
 return SignIN();
  }
  
  else{
    return HomeView();
  }
 
  }
}
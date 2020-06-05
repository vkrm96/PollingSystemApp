import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget{

  @override
  Widget build(BuildContext context)
  {
    return Container(
      height:250,
       child:Card(
        child:Center(
         child: SpinKitChasingDots(
           duration: Duration(seconds:2),
           color: Colors.blue,
           size:50,
           
         ),
       ),
     ) );
  }

}
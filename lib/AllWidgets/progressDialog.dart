import "package:flutter/material.dart";

class ProgressDialog extends StatelessWidget {

  String message;
  // ignore: use_key_in_widget_constructors
  ProgressDialog({required this.message});


  @override
  Widget build(BuildContext context) {
    return Dialog (
      backgroundColor: Colors.blue,
      child: Container(
        margin: EdgeInsets.all(15.0) ,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6)

        ),
        child: Row(
          children: [
            SizedBox(width: 6.0,),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
            SizedBox(width: 26.0,),
            Text(
              message,
              style: TextStyle(color: Colors.black),),
          ],),
        ),
    );
  }
}
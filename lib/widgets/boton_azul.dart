import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final void Function()? onPressed;
  final String text;

  const BotonAzul({ Key? key,  this.onPressed, required this.text }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5,
        primary: Colors.blue,
        shape: const StadiumBorder(),
        // overlayColor: MaterialStateProperty.resolveWith((states) => Colors.red),
      ),
      // style: ButtonStyle(
      //   elevation: MaterialStateProperty.resolveWith((states) => 5),
      //   backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
      //   shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
      //   // overlayColor: MaterialStateProperty.resolveWith((states) => Colors.red),
      // ),
    
      onPressed: onPressed, 
      child: Container(
        width: double.infinity,
        height: 55,
        child:  Center(
          child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 17),)
        ),
      )
    );
  }
}
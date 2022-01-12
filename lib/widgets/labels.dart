import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  
  final String ruta;
  final String label1;
  final String label2;
  
  const Labels({Key? key, required this.ruta, required this.label1, required this.label2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Text(label1 , style: const TextStyle( color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(label2, style: TextStyle( color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold),)
          )
        ],
      ),
    );
  }
}
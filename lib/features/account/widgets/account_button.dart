import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AccountButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
    
        ),
        child: OutlinedButton(onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:Colors.black12.withOpacity(0.03),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),)
    
        ),
        child: Text(text,style: const TextStyle(color:Colors.black,fontWeight: FontWeight.normal, ),)),
        
      ),
    );
  }
}
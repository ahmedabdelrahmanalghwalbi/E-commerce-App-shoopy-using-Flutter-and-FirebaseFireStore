import 'package:ecommerce/screens/constants.dart';
import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  String hint;
  var icon;
  Function onClick;
  String _errorMessage(String str){
    switch(hint){
      case "Enter your E-mail":return "E-mail is Empty..!";
      case "Enter your password":return "Password is Empty..!";
      case "Enter your Name":return "Name is Empty..!";
    }
  }
  CustomTextField({@required this.hint,@required this.icon,@required this.onClick});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val){
        if(val.isEmpty){
          return _errorMessage(hint);
        }
      },
      obscureText: hint=="Enter your password"?true:false,
      cursorColor: Color(KmainColor),
      onSaved: onClick,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color:Color(KmainColor),
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:BorderSide(
              color:Colors.white
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:BorderSide(
            color:Colors.white
          ),
        ),
         border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:BorderSide(
              color:Colors.red
          ),
        ),
      ),
    );
  }
}

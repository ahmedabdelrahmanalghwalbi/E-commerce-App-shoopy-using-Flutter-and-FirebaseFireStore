import 'package:ecommerce/components/textFeild.dart';
import 'package:ecommerce/providers/modelHudProvider.dart';
import 'package:ecommerce/screens/Home.dart';
import 'package:ecommerce/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
class SignUp extends StatefulWidget {
  static String route="SignUPScreen";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formState=GlobalKey<FormState>();
  String _email,_password;
  Auth _auth=Auth();
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(KmainColor),
      body: Consumer<ModelHud>(
        builder: (context,model,child){
          return ModalProgressHUD(
            inAsyncCall: model.showed,
            child: Form(
              key: _formState,
              child: ListView(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Padding(
                        padding:EdgeInsets.only(top:height*.04),
                        child: Image(
                          height: height*.2,
                          image: AssetImage("assets/images/icon.png"),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text("Shoppy",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                        ),),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height*0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: CustomTextField( icon:Icons.perm_identity,hint:"Enter your Name"),
                  ),
                  SizedBox(
                    height: height*0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: CustomTextField(onClick: (value){
                      _email=value;
                    }, icon:Icons.email,hint:"Enter your E-mail"),
                  ),
                  SizedBox(
                    height: height*0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: CustomTextField(onClick: (value){
                      _password=value;
                    }, icon:Icons.lock,hint:"Enter your password"),
                  ),
                  SizedBox(
                    height: height*0.06,
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal:width*.3),
                    child: FlatButton(
                      color: Color(KsecondaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Color(KmainColor),
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 22
                        ),
                      ),
                      onPressed: ()async{
                        model.ShowedTrue();
                        try{
                          if(_formState.currentState.validate()){
                            _formState.currentState.save();
                            await _auth.signUp(_email, _password);
                            model.ShowedFalse();
                            Navigator.pushNamed(context, Home.route);
                          }
                        }catch(err){
                          model.ShowedFalse();
                          print('${err.toString()}');
                        }
                        model.ShowedFalse();
                      },
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:height*.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Are you have an account?",style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, Login.route);
                          },
                          child: Text("Login",style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

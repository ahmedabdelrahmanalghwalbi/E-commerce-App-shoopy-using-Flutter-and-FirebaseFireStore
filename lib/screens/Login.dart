import 'package:ecommerce/components/textFeild.dart';
import 'package:ecommerce/providers/modelHudProvider.dart';
import 'package:ecommerce/screens/AdminHome.dart';
import 'package:ecommerce/screens/Home.dart';
import 'package:ecommerce/screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
class Login extends StatefulWidget {
  static String route="LoginScreen";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email,_password;
  bool isAdmin = false;
  Auth _auth=Auth();
  final GlobalKey<FormState>_formState=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Color(KmainColor),
      body: Consumer<ModelHud>(
          builder: (context, model, child) {
            return ModalProgressHUD(
              inAsyncCall: model.showed,
              child: Form(
                autovalidate: true,
                key: _formState,
                child: ListView(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: height * .04),
                          child: Image(
                            height: height * .2,
                            image: AssetImage("assets/images/icon.png"),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Text("Shoppy", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                          ),),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CustomTextField(onClick: (value) {
                        _email = value;
                      }, icon: Icons.email, hint: "Enter your E-mail"),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CustomTextField(onClick: (value) {
                        _password = value;
                      }, icon: Icons.lock, hint: "Enter your password"),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .3),
                      child: FlatButton(
                        color: Color(KsecondaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Color(KmainColor),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 22
                          ),
                        ),
                        onPressed: () async {
                          model.ShowedTrue();
                          if(isAdmin==true){
                            try{
                              if (_formState.currentState.validate()) {
                                _formState.currentState.save();
                                if(_password =="admin123456"){
                                  await _auth.signIn(_email, _password);
                                  model.ShowedFalse();
                                  Navigator.pushNamed(context, AdminHome.route);
                                }
                              }
                            }catch(err){
                              print("${err.toString()}");
                            }
                            model.ShowedFalse();
                          }else{
                            try {
                              if (_formState.currentState.validate()) {
                                _formState.currentState.save();
                                await _auth.signIn(_email, _password);
                                model.ShowedFalse();
                                Navigator.pushNamed(context, Home.route);
                              }
                            } catch (err) {
                              print("${err.toString()}");
                            }
                          }
                          model.ShowedFalse();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * .02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?", style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignUp.route);
                            },
                            child: Text("Sign in", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 23
                            ),),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: height*.02,left:height*.03,right:height*.03),
                      child: Divider(
                        color: Color(KsecondaryColor),
                        thickness: 5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height*.01),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton.icon(onPressed: (){
                                  setState(() {
                                    isAdmin=true;
                                  });
                               },
                                icon: Icon(Icons.verified_user,
                                  color: isAdmin?Color(KsecondaryColor):Colors.black,
                                ),
                                label: Text("Admin",style: TextStyle(
                                    color: isAdmin?Color(KsecondaryColor):Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                            ),
                          ),
                          Expanded(
                            child: FlatButton.icon(onPressed: (){
                              setState(() {
                                isAdmin=false;
                              });
                            },
                              icon: Icon(Icons.supervised_user_circle,
                                color: isAdmin?Colors.black:Color(KsecondaryColor),
                              ),
                              label: Text("User",style: TextStyle(
                                color: isAdmin?Colors.black:Color(KsecondaryColor),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

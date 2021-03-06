import 'package:flutter/material.dart';
import './login_page.dart';
import '../ui/loading_ui.dart';
import '../web_service/authenticate.dart';
import 'package:quiz/util/shared_preference.dart';

var isLoading=false;
class AskName extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return AskNameState();
    }
}
final _formKey = GlobalKey<FormState>();
class AskNameState extends State<AskName>{

   TextEditingController _username=new TextEditingController();
   TextEditingController _password=new TextEditingController();
   TextEditingController _email=new TextEditingController();

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      
    }
  @override
    Widget build(BuildContext context) {
      
      var hintColor=Color.fromRGBO(199, 236, 238, 1.0);
      var labelColor=Color.fromRGBO(223, 249, 251, 1.0);
      // TODO: implement build

      var formToFill=new Form(
        key: _formKey,
            child: new ListView(
              
              children: <Widget>[

                new TextFormField(
                  controller: _username,
                  decoration: new InputDecoration(
                    hintText: "Username",
                    labelText: "Enter Your Username",
                    hintStyle: new TextStyle(color: hintColor),
                    labelStyle: new TextStyle(color: labelColor),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email-id';
                    }
                  },
                ),

                new TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                    hintText: "Email Address",
                    labelText: "Enter Your Email Adrress",
                    hintStyle: new TextStyle(color: hintColor),
                    labelStyle: new TextStyle(color: labelColor),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email-id';
                    }
                  },
                ),

                new TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: new InputDecoration(
                    hintText: "Password",
                    labelText: "Enter Your Password",
                    hintStyle: new TextStyle(color: hintColor),
                    labelStyle: new TextStyle(color: labelColor),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    }
                    else if(value.length<6){
                      return 'Size of Password must be greater then 6';
                    }
                  },
                ),

                new Container(
                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  child: new RaisedButton(
                    padding: EdgeInsets.all(10.0),
                    child: new Text("Sign Up",style: new TextStyle(color: Colors.white),),
                    color: Color.fromRGBO(255,127,80, 1.0),
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                      saveUserRegistrationDetails(_username.text, _password.text, _email.text);
                      //Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context)=>new SeeLeaders()));
                      registerUser(_username.text, _email.text, _password.text);
                      this.setState((){  isLoading=true;});
                    }
                    },
                  ),
                )
              ],
            ),
          );


      return new Stack(
        children: <Widget>[
          
          new Container(
            width: double.infinity,
            child: new Material(
            color: Color.fromRGBO(236, 240, 241, 1.0),
            child: new Padding(
              padding: EdgeInsets.all(0.0),
              child:new Column(
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: <Widget>[
                new Card(

                  elevation: 10.0,
                  
                  child:  new Container(
                    
                    width: 350.0,
                    height: 400.0,
                    color: Color.fromRGBO(26, 188, 156, 1.0),
                    child: new Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 70.0),
                      child: formToFill
                    ),
                  ),
                ),

                new MaterialButton(
                    child: new Text("Click here to Login",style: new TextStyle(color:Colors.blueAccent),),
                    onPressed: (){
                      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context)=>new LoginPage()));
                    },
                  )
                ],
              )
            )
          ),
          ),

          (isLoading)?IsLoading():new Container()
        ],
      );

      
    }
}
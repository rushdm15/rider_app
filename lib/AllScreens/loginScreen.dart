import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget
{
  static const String idScreen = "login":

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 45.0),
              Image(
                image: AssetImage("images/logo.png"),
                width: 350.0,
                height: 350.0,
                alignment: Alignment.center,
              )

              SizedBox(height: 1.0,),
              Text(
                "Login as a Rider",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  Children: [

                    SizedBox(height: 1.0,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          colors: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                    style: TextStyle(fontSize: 14.0),
                  ),

                    SizedBox(height: 1.0,),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          colors: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: ()
                        {
                          print("loggedin button clicked");
                        },
                    ),

                  ],
                ),
              ),

              FlatButton(
                onPressed: ()
                {
                  Navigator.pushAndRemoveUntil(context, RegistrationScreen.idScreen (route) => false)
                },
                child: Text(
                  "Do not have an Account? Register Here.",
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
        {
          ProgressDialog(message: "Authenticating, Please wait...");
        }
    );

    final User firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context)
    })).user;

    if(firebaseUser != null) //user create
      {
      //save user info to database
      usersRef.child(firebaseUser.uid);

      // Map userDataMap = {
      //   "name": nameTextEditingController.text.trim(),
      //   "email": emailTextEditingController.text.trim(),
      //   "phone": phoneTextEditingController.text.trim(),
      // }; unknown, not found

      usersRef.child(firebaseUser.uid).once().then(DataSnapshot snap){
        if(snap.value != null)
          {
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
            displayToastMessage("you are logged-in now", context);
          }
        else
        {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("No record exists for this user. Please create new account.", context);
        }
        ));
      }
      else
      {
        Navigator.pop(context);
        displayToastMessage("New user account has not been created", context);
      }
    }
}


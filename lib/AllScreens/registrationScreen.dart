import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/loginScreen.dart';


class RegistrationScreen extends StatelessWidget
{
  static const String idScreen = "register":

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Image(
                  image: AssetImage("images/logo.png"),
                  width: 350.0,
                  height: 350.0,
                  alignment: Alignment.center,
                )

                SizedBox(height: 1.0,),
                Text(
                  "Register as a Rider",
                  style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                  textAlign: TextAlign.center,
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    Children: [

                      SizedBox(height: 1.0,),
                      TextFormField(
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Name",
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
                      TextFormField(
                        controller: emailTextEditingController,
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

                      TextFormField(
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone",
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
                        controller: passwordTextEditingController,
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
                              "Create Account",
                              style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                            ),
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                        onPressed: ()
                        {
                          if(nameTextEditingController.text.length < 3)
                          {
                            displayToastMessage("name must be atleast 3 characters.", context);
                          }
                          else if(!emailTextEditingController.text.contains("@"))
                          {
                            displayToastMessage("Email address is not valid.", context);
                          }
                          else if(phoneTextEditingController.text.isEmpty)
                          {
                            displayToastMessage("Phone Number is mandatory.", context);
                          }
                          else if(passwordTextEditingController.text.length < 6)
                          {
                            displayToastMessage("Password must be at least 6 characters.", context);
                          }
                          else
                          {
                            registerNewUser(context);
                          }

                        },
                      ),

                    ],
                  ),
                ),

                FlatButton(
                  onPressed: ()
                  {
                    Navigator.pushAndRemoveUntil(context, LoginScreen.idScreen (route) => false)
                  },
                  child: Text(
                    "Already have an Account? Login Here.",
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering, Please wait...");
        }
    );

    final User firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
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

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Congratulations, your account has been created", context);
      
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    }
    else
    {
      Navigator.pop(context);
      //error occured - display error msg
      displayToastMessage("New user account has not been created", context);
    }
  }
}


displayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: "Name must be atleast 3 character"):
}

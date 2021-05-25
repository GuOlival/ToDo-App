

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/pages/sign_up_page.dart';
import '../authentication_service.dart';
import 'forgot_password_page.dart';

class SignInPage extends StatefulWidget {

  //final AuthenticationService aut = new AuthenticationService(_firebaseAuth);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  pageColors colors = new pageColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0093E9),
                Color(0xff80D0C7),
              ]
          )
      ),
      //backgroundColor: Colors.transparent,

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Login"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0093E9),
                Color(0xff80D0C7),
              ]
            ),
            )
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child:
              Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      validator: EmailValidator(errorText:'Entre com endereço de e-mail válido'),
                      controller: emailController,
                      decoration: InputDecoration(
                        //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                        labelText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator: LengthRangeValidator(min: 6, max: 20, errorText: 'Senha tem que estar entre 6 e 20 caracteres'),
                      controller: passwordController,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0), borderRadius: BorderRadius.circular(20)),
                        //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                        labelText: "Senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<AuthenticationService>().signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context,
                            );
                          },
                          label: Text("  Logar  "),
                          icon: Icon(Icons.login),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()),);
                            /*context.read<AuthenticationService>().signUp(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              );*/
                          },
                          label: Text("Registrar"),
                          icon: Icon(Icons.badge),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),),
                          label: Text("Esqueci senha"),
                          icon: Icon(Icons.contact_support_outlined),
                        ),
                      ),
                    ]
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
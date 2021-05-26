
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/sign_in_page.dart';
import '../authentication_service.dart';
import '../colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  pageColors pageColor = new pageColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: pageColor.backgroundGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Esqueci senha"),
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
        body: Padding(
          padding:const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
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
                ElevatedButton(
                    onPressed: (){
                      context.read<AuthenticationService>().passwordReset(
                        email: emailController.text.trim(),
                        context: context
                      );
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => SignInPage()));
                    },
                    child: Text("Recuperar"),
                ),
              ],
            ),
          ) ,
        ),
      ),
    );
  }
}

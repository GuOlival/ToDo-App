
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/sign_in_page.dart';
import '../authentication_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF927FC4),
      appBar: AppBar(
        title: Text("Esqueci senha"),
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
                validator: EmailValidator(errorText:'Entre com endereço de e-mail válido'),
                controller: emailController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                  labelText: "Email",
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
    );
  }
}

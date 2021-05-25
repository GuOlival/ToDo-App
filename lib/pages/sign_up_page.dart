
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/sign_in_page.dart';
import '../authentication_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final AuthenticationService aut = new AuthenticationService(_firebaseAuth);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: EmailValidator(errorText:'Entre com endereço de e-mail válido'),
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                validator: LengthRangeValidator(errorText: 'Digite entre 6 e 20 caracteres', min: 6, max: 20 ),
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthenticationService>().signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Conta criada')));
                        Navigator.pop(context, MaterialPageRoute(builder: (context) => SignInPage()));
                      },
                      child: Text("Inscrever-se"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



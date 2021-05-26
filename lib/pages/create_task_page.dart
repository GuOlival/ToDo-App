import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import '../metodos.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key key}) : super(key: key);

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  pageColors pageColor = new pageColors();
  Metodos metodo = new Metodos();

  DateTime diaEscolhido = DateTime.now();
  TimeOfDay horarioEscolhido = TimeOfDay.now();

  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: pageColor.backgroundGradient(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Adicionar tarefas"),
          flexibleSpace: pageColor.appBarGradient(),
        ),
        backgroundColor: Colors.transparent,
        body: Center(

          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      cursorColor: Colors.black,
                      validator: LengthRangeValidator(min: 1,max: 30,errorText: "Nome da tarefa tem que estar entre 1 e 30 caracteres"),
                      controller: taskController,
                      decoration: pageColor.textFormFieldDecoration("Nome da Tarefa"),
                  ),
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: (){
                          abreCalendario();
                        },
                        label: Text("Abrir Calendario"),
                        icon: Icon(Icons.calendar_today),
                      ),
                    ),
                    Text("Dia escolhido ${DateFormat('dd-MM-yyyy').format(diaEscolhido)}"),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: ()=>abreRelogio(),
                        icon: Icon(Icons.access_alarm),
                        label: Text(" Abrir Relógio  ")
                      ),
                    ),
                    Text("Horario Escolhido ${horarioEscolhido.format(context)}"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          onPressed: (){
                            metodo.createTodos(
                              taskController.text,
                              auth.currentUser.uid,
                              DateFormat('dd-MM-yyyy').format(diaEscolhido),
                              horarioEscolhido.format(context));
                          },
                          icon: Icon(Icons.add),
                          label: Text("Adicionar tarefa"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  abreCalendario() async{
    DateTime date = await showDatePicker(
        context: context,
        initialDate: diaEscolhido,
        firstDate: DateTime(2021),
        lastDate: DateTime(2025));
    if(date != null)
      setState(() {
        diaEscolhido = date;
      });
  }

  abreRelogio() async{
    TimeOfDay hora = await showTimePicker(
        context: context,
        initialTime: horarioEscolhido);
    if(hora!=null)
      {
        setState(() {
          horarioEscolhido = hora;
        });
      }
  }

}

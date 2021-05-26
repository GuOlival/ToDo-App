
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/pages/create_task_page.dart';
import '../authentication_service.dart';
import '../colors.dart';
import '../metodos.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home"),
            ElevatedButton(onPressed: (){
              context.read<AuthenticationService>().signOut();
            },
                child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List todos = List();
  String input = "";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  DateTime diaEscolhido = DateTime.now();
  Metodos comando = new Metodos();
  pageColors pageColor = new pageColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: pageColor.backgroundTaskGradient(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tarefas a fazer"),
          flexibleSpace: pageColor.appBarGradient(),
        ),
        backgroundColor: Colors.transparent,
        floatingActionButton:
          SpeedDial(
            backgroundColor: Colors.lightBlue,
            closeManually: false,
            overlayOpacity:0.2,
            curve: Curves.easeIn,
            child: Icon(Icons.account_box),
            //icon:  Icons.add,
            //activeIcon: Icons.remove,
            //animatedIcon: AnimatedIcons.menu_close,
            children:[
              SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
                label: "Add",
                onTap: (){//showDialog(context: context, builder: (BuildContext context){
                    //return comando.createAlertDialog(input, context, auth.currentUser.uid);
                //}
                    //diaEscolhido =  comando.createSelectDate(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskPage()),);
            //    );
                  },
              ),
              SpeedDialChild(
                  child: Icon(Icons.logout),
                  backgroundColor: Colors.red,
                  label: "Sair",
                  onTap: () => context.read<AuthenticationService>().signOut()
              ),
            ]
          ),
        body: StreamBuilder(
          stream: firestore.collection(auth.currentUser.uid).orderBy('dia').orderBy('horario').snapshots(),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                  return Dismissible(
                    onDismissed: (direction){
                      setState(() {
                        DocumentReference docRe = firestore.collection(auth.currentUser.uid).doc(documentSnapshot["todoTitle"]);
                        docRe.delete().whenComplete(() => print(documentSnapshot["todoTitle"] +" deleted"));
                        //deleteTodos();
                      });
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(documentSnapshot["todoTitle"] + ' dismissed')));
                    },
                    background: Container(
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        //color: Colors.red
                    ),
                    key: UniqueKey(),//Key(documentSnapshot["todoTitle"]),
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: ListTile(
                        title: Text("${documentSnapshot["dia"]} - "
                            "${documentSnapshot["horario"]} - "
                            "${documentSnapshot["todoTitle"]}"),
                        trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red,
                            ),
                            onPressed: () {
                              comando.deleteTodos(documentSnapshot["todoTitle"], auth.currentUser.uid);
                            }
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return Align(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

}
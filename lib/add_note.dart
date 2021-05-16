import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title;
  String description;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(CupertinoIcons.back),color: Colors.white,
                  onPressed: (){
                  Navigator.pop(context);
                  },
                ),
                TextButton(onPressed: add, child: Text('Save',style: TextStyle(
                  color: Colors.purple,
                  fontFamily: 'Montserrat'
                ),))
              ],
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Note Title',
                        hintStyle: TextStyle(
                          color: Colors.grey
                        )
                      ),style: TextStyle(
                      color: Colors.purple,
                      fontFamily: 'Montserrat',
                      fontSize: 32

                    ),
                      onChanged: (val){
                        title=val;
                      },
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Note Description',
                            hintStyle: TextStyle(
                                color: Colors.grey
                            )
                        ),style: TextStyle(
                          color: Colors.grey[50],
                          fontSize: 20

                      ),
                        onChanged: (val){
                          description=val;
                        },
                        maxLines: 20,
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),

      ),
      )
    );
  }
  void add() async{
    CollectionReference ref = FirebaseFirestore.instance.
                               collection('users')
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .collection('notes');

    var data = {
      'title': title,
      'description': description,
      'created': DateTime.now()
    };
    ref.add(data);

    //

    Navigator.pop(context);

  }
}

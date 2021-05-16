import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noted/notes_screen.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,color: Colors.white,
                        size: 24.0,
                      ),
                      ),
                    //
                    IconButton(
                      onPressed: (){
                        delete();
                      },
                      icon: Icon(
                        CupertinoIcons.delete_solid,
                        color: Colors.red,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(
                  height: 15.0,
                ),
                //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.data['title']}",
                      style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        bottom: 12.0,
                      ),
                      child: Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Montserrat",
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),

                    //
                    SizedBox(height: 20,),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${widget.data['description']}",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }
}
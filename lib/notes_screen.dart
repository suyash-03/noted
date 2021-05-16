import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noted/add_note.dart';
import 'package:noted/view_note.dart';
import 'package:provider/provider.dart';
import 'google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotesPage extends StatefulWidget {


  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    CollectionReference ref = FirebaseFirestore.instance.
    collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('notes');

    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
              .then((value) {
            print("Calling Set  State !");
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.purpleAccent,
      ),

      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        leading: Row(
          children: [
            SizedBox(width: 25,),
            CircleAvatar(
              maxRadius: 15,
              backgroundImage: NetworkImage(user.photoURL),
            ),
          ],
        ),
        title: Text('${user.displayName}'+ "'s" + ' Notes', style: TextStyle(
               color: Colors.white,fontSize: 15,
               fontFamily: 'Montserrat'
        ),
        ),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){

                provider.logout(context);
            },
              icon: Icon(Icons.exit_to_app_rounded,color: Colors.white,),
              label: Text('SignOut',style: TextStyle(
                fontFamily: 'PermanentMarker',
                color: Colors.deepPurple,
                fontSize: 15
              ),)),
        ],
      ),
      //End App Bar Decoration
    body: Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index)
                  {
                    Map data = snapshot.data.docs[index].data();
                    DateTime dateTime = data['created'].toDate();
                   return InkWell(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewNote(data, dateTime.toString(), snapshot.data.docs[index].reference)));
                     },
                     child: Container(
                       height: 80,
                       child: Card(
                         elevation: 0,shape: StadiumBorder(
                         side: BorderSide(
                           color: Colors.purpleAccent,
                           width: 1,
                         )
                       ),
                         color: Colors.black,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Text("${data['title']}",style:
                             TextStyle(
                               color: Colors.purple[200],
                               fontFamily: 'Montserrat',
                               fontSize: 35,)
                             ),
                             Container(
                               child: Text('${dateTime.toString()}',style: TextStyle(
                                 color: Colors.white
                               ),),
                               alignment: Alignment.center,
                             )
                           ],
                         ),
                       ),
                     ),
                   );
                 }
              );

            }
            else{
              return Text('');
            }

          },

        ),
      ),


    ),
    );
  }
}


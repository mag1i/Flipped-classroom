import 'package:flipped_classroom/Screens/AuthTeacher/SignUpTeacher.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';


/*


void FetchT() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(TeachersList());
}*/


class ManageTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Teachers',
      home: hp(),
    );
  }
}

class hp extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<hp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();

  CollectionReference Teachers =
  Firestore.instance.collection('Teachers');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
   Future<void> _createOrUpdate([DocumentSnapshot documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _lnController.text = documentSnapshot['lastname'];
      _emailController.text = documentSnapshot['email'];
      _fieldController.text = documentSnapshot['field'];


    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                  /*    TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                    TextField(
                      controller: _lnController,
                      decoration: InputDecoration(labelText: 'lastname'),
                    ),*/
                TextField(
                //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _fieldController,
                  decoration: InputDecoration(
                    labelText: 'Field',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String field = _fieldController.text;
                   // final double price =  double.tryParse(_emailController.text);
                    final String email =  _emailController.text;
                    if (field != null && email != null) {
                    /*  if (action == 'create') {
                        // Persist a new product to Firestore
                        await Teachers.add({"name": name, "year": email});
                      }*/

                      if (action == 'update') {
                        // Update the product
                        await Teachers.document(documentSnapshot.documentID).updateData({"field": field, "email": email});
                      }

                      // Clear the text fields
                      _fieldController.text = '';
                      _emailController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteTeacher(String teacherId) async {
    await Teachers.document(teacherId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a teacher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: Teachers.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data.documents.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data.documents[index];
                print(documentSnapshot.data);
                return  Container(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Row(children: [Text(documentSnapshot['name']),Text('  '),Text(documentSnapshot['lastname'])]),
                   // subtitle: Text(documentSnapshot['email'].toString()),
                    subtitle: Column( children: [ Text('Email: '+documentSnapshot['email']),Text('Field: '+documentSnapshot['field'])]),

                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [

                          // Press this button to edit a single product
                                   IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          //This icon button is used to delete a single product
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteTeacher(documentSnapshot.documentID)),
                          //    Text(cart_prod_qty!=null?cart_prod_qty:'default value'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),

          );
        },
      ),

    );
  }
}

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';




class ManageStudents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Teachers',
      home: stdntmang(),
    );
  }
}

class stdntmang extends StatefulWidget {
  @override
  _stdntmangState createState() => _stdntmangState();
}

class _stdntmangState extends State<stdntmang> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  CollectionReference students =
  Firestore.instance.collection('Student');

  Future<void> _createOrUpdate([DocumentSnapshot documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _lnController.text = documentSnapshot['lastname'];
      _emailController.text = documentSnapshot['email'];
      _fieldController.text = documentSnapshot['field'];
      _yearController.text = documentSnapshot['year'].toString();


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

                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                    TextField(
                      controller: _lnController,
                      decoration: InputDecoration(labelText: 'lastname'),
                    ),
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
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _yearController,
                  decoration: InputDecoration(
                    labelText: 'Year',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String field = _fieldController.text;
                    final String name = _nameController.text;
                    final String ln = _lnController.text;
                    final int year =  int.tryParse(_yearController.text);
                    final String email =  _emailController.text;
                    if (field != null && email != null && name!= null && ln != null && year != null) {
                      /*  if (action == 'create') {
                        // Persist a new product to Firestore
                        await Teachers.add({"name": name, "year": email});
                      }*/

                      if (action == 'update') {
                        // Update the product
                        await students.document(documentSnapshot.documentID).updateData({"field": field, "email": email, "year": year});
                      }

                      // Clear the text fields
                      _fieldController.text = '';
                      _emailController.text = '';
                      _yearController.text = '';
                      _nameController.text = '';
                      _lnController.text = '';

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


  Future<void> _deleteStudent(String stdntrId) async {
    await students.document(stdntrId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a student')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: students.snapshots(),
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
                    subtitle: Column( children: [ Text('Email: '+documentSnapshot['email']),Text("year: "+documentSnapshot['year'].toString()),Text('Field: '+documentSnapshot['field'])]),

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
                                  _deleteStudent(documentSnapshot.documentID)),
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
      // Add new product

    );
  }
}
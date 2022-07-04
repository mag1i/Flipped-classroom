import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';





void FetchT() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(TeachersList());
}


class TeachersList extends StatelessWidget {
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

  CollectionReference Teachers =
  Firestore.instance.collection('Teachers');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  /* Future<void> sendmsg([DocumentSnapshot documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _lnController.text = documentSnapshot['name'];
      _emailController.text = documentSnapshot['email'];


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
                //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double price =
                //    double.tryParse(_emailController.text);
                    if (name != null && price != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _productss.add({"name": name, "year": price});
                      }

                      if (action == 'update') {
                        // Update the product
                        await Teachers.document(documentSnapshot.documentID).updateData({"name": name, "year": price});
                      }

                      // Clear the text fields
                      _nameController.text = '';
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
  Future<void> _deleteProduct(String productId) async {
    await Teachers.document(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a product')));
  }*/

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
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['email'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [

                          // Press this button to edit a single product
                          IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {}
                                  ),
                          //This icon button is used to delete a single product
                        /*  IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.documentID)),
                          //    Text(cart_prod_qty!=null?cart_prod_qty:'default value'),*/
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
    /*  floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: Icon(Icons.add),
      ),*/
    );
  }
}
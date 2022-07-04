
import 'package:flipped_classroom/Controler/Modules.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';




class ManageModules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Modules',
      home: ManageModulesPage(),
    );
  }
}

class ManageModulesPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ManageModulesPage> {
 // List<Modules> itemList=List();
 //final Modules  mm=Modules("jh", "jh", "kjj", "jj", " ", 0, 0, 0) ;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _teacherTDController = TextEditingController();
  final TextEditingController _teacherTPController = TextEditingController();
  final TextEditingController _teacherCourseController = TextEditingController();
  final TextEditingController _coefController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();


  CollectionReference Modules =
  Firestore.instance.collection('Modules');

  Future<void> _createOrUpdate([DocumentSnapshot documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _teacherTDController.text= documentSnapshot['TDteacher'];
      _teacherTPController.text= documentSnapshot['TPteacher'];
      _teacherCourseController.text= documentSnapshot['courseteacher'];
      _yearController.text= documentSnapshot['year'];
      _fieldController.text = documentSnapshot['field'];
      _coefController.text= documentSnapshot['coef'].toString();
      _creditController.text= documentSnapshot['credit'].toString();


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
                      controller: _teacherTDController,
                      decoration: InputDecoration(labelText: 'TD teacher'),
                    ),
            TextField(
              controller: _teacherCourseController,
              decoration: InputDecoration(labelText: 'Course teacher'),
            ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _teacherTPController,
                  decoration: InputDecoration(
                    labelText: 'TP teacher',
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
                    labelText: 'year',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _creditController,
                  decoration: InputDecoration(
                    labelText: 'Credit',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _coefController,
                  decoration: InputDecoration(
                    labelText: 'Coeffision',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String field = _fieldController.text;
                     final String year =  _yearController.text;
                     final int coef =  int.tryParse(_coefController.text);
                     final int credit =  int.tryParse(_creditController.text);
                    final String tp =  _teacherTPController.text;
                    final String td =  _teacherTDController.text;
                    final String course =  _teacherCourseController.text;
                    final String name =  _nameController.text;
                    if (field != null && name != null  && year != null && coef != null && td != null && tp != null && course != null && credit != null) {
                        if (action == 'create') {
                        //  mm.add(name, field, td, tp, course, year, credit, coef);

                          // Persist a new product to Firestore
                        await Modules.add({"name": name,"field":field, "TDteacher":td, "TPteacher":tp, "courseteacher": course, "year": year, "coef": coef,  "credit": credit});
                      }

                      if (action == 'update') {
                        // Update the product
                        await Modules.document(documentSnapshot.documentID).updateData({"name": name,"field":field, "TDteacher":td, "TPteacher":tp, "courseteacher": course, "year": year, "coef": coef, "credit": credit});
                      }

                      // Clear the text fields
                        _nameController.text =" ";
                        _teacherTDController.text= " ";
                        _teacherTPController.text= " ";
                        _teacherCourseController.text= " ";
                        _yearController.text=" ";
                        _fieldController.text = " ";
                        _coefController.text=" ";
                        _creditController.text=" ";


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
  Future<void> _deleteModule(String moduleId) async {
    await Modules.document(moduleId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a module')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modules'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: Modules.snapshots(),
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
                    title:Text(documentSnapshot['name']),
                    // subtitle: Text(documentSnapshot['email'].toString()),
                    subtitle: Column( children: [ Text('Credit: '+documentSnapshot['credit'].toString()),Text('Field: '+documentSnapshot['field']),
                                            Text("Year: "+documentSnapshot['year']),Text('  '),Text("Couurse Teeacher:"+documentSnapshot['courseteacher']),
                      Text("TD teacher: "+documentSnapshot['TDteacher']),Text('  '),Text("TP teacher: "+documentSnapshot['TPteacher']),Text("Coefission: "+documentSnapshot['coef'].toString())]),

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
                                  _deleteModule(documentSnapshot.documentID)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: Icon(Icons.add),
      ),
    );
  }

 /* @override
  void initState() {
    mainReference.once().then((DataSnapshot snap){
      print(snap);
      var data=snap.value;
      print(data);
      itemList.clear();
      data.forEach((key, value){
        mm= new Modules(value['name'], value['field'], value['courseteacher'], value['TDTeacher']) ;
        itemList.add(mm);

      }

      );

    });
  }*/
}
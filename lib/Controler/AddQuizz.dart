
import 'package:flipped_classroom/Controler/Modules.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';




class ManageQuizz extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Modules',
      home: ManageQuizzPage(),
    );
  }
}

class ManageQuizzPage extends StatefulWidget {
  final String teachername;

  const ManageQuizzPage({Key key, this.teachername}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ManageQuizzPage> {
  // List<Modules> itemList=List();
  //final Modules  mm=Modules("jh", "jh", "kjj", "jj", " ", 0, 0, 0) ;

  final TextEditingController _moduleController = TextEditingController();
  final TextEditingController _Q1Controller = TextEditingController();
  final TextEditingController _Q2Controller = TextEditingController();
  final TextEditingController _Q3Controller = TextEditingController();
  final TextEditingController _Q4Controller = TextEditingController();
  final TextEditingController _Q5Controller = TextEditingController();
  final TextEditingController _Q6Controller = TextEditingController();
  final TextEditingController _Q7Controller = TextEditingController();
  final TextEditingController _Q8Controller = TextEditingController();
  final TextEditingController _Q9Controller = TextEditingController();
  final TextEditingController _Q10Controller = TextEditingController();
  final TextEditingController _A1Controller = TextEditingController();
  final TextEditingController _A2Controller = TextEditingController();
  final TextEditingController _A3Controller = TextEditingController();
  final TextEditingController _A4Controller = TextEditingController();
  final TextEditingController _A5Controller = TextEditingController();
  final TextEditingController _A6Controller = TextEditingController();
  final TextEditingController _A7Controller = TextEditingController();
  final TextEditingController _A8Controller = TextEditingController();
  final TextEditingController _A9Controller = TextEditingController();
  final TextEditingController _A10Controller = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
   DateTime _dateController = DateTime.now();



  CollectionReference Quizzez =
  Firestore.instance.collection('Quizz');

  Future<void> _createOrUpdate([DocumentSnapshot documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _moduleController.text = documentSnapshot['module'];
      _Q1Controller.text = documentSnapshot['Q1'];
      _Q2Controller.text= documentSnapshot['Q2'];
      _Q3Controller.text= documentSnapshot['Q3'];
      _Q4Controller.text= documentSnapshot['Q4'];
      _Q5Controller.text= documentSnapshot['Q5'];
      _Q6Controller.text = documentSnapshot['Q6'];
      _Q7Controller.text= documentSnapshot['Q7'];
      _Q8Controller.text= documentSnapshot['Q8'];
      _Q9Controller.text= documentSnapshot['Q9'];
      _Q10Controller.text= documentSnapshot['Q10'];
      _A1Controller.text = documentSnapshot['A1'];
      _A2Controller.text= documentSnapshot['A2'];
      _A3Controller.text= documentSnapshot['A3'];
      _A4Controller.text= documentSnapshot['A4'];
      _A5Controller.text= documentSnapshot['A5'];
      _A6Controller.text = documentSnapshot['A6'];
      _A7Controller.text= documentSnapshot['A7'];
      _A8Controller.text= documentSnapshot['A8'];
      _A9Controller.text= documentSnapshot['A9'];
      _A10Controller.text= documentSnapshot['A10'];
      _scoreController.text= documentSnapshot['score'].toString();
      _dateController= documentSnapshot['date'];




    }


    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return  SingleChildScrollView(
          child: Form(

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _moduleController,
                  decoration: InputDecoration(labelText: 'Module'),
                ),

                TextField(
                  controller: _Q1Controller,
                  decoration: InputDecoration(labelText: 'Question 1'),
                ),
                TextField(
                  controller: _Q2Controller,
                  decoration: InputDecoration(labelText: 'Question 2'),
                ),
                TextField(
                  controller: _Q3Controller,
                  decoration: InputDecoration(labelText: 'Question 3'),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _Q4Controller,
                  decoration: InputDecoration(
                    labelText: 'Question 4',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _Q5Controller,
                  decoration: InputDecoration(
                    labelText: 'Question 5',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _Q6Controller,
                  decoration: InputDecoration(
                    labelText: 'Question 6',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _Q7Controller,
                  decoration: InputDecoration(
                    labelText: 'Question 7',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _Q8Controller,
                  decoration: InputDecoration(
                    labelText: 'Question 8',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _Q9Controller,
                  decoration: InputDecoration(
                    labelText: 'Question 9',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _Q10Controller,
                  decoration: InputDecoration(
                    labelText: 'Question 10',
                  ),
                ),
                TextField(
                  controller: _A1Controller,
                  decoration: InputDecoration(labelText: 'Answer 1'),
                ),
                TextField(
                  controller: _A2Controller,
                  decoration: InputDecoration(labelText: 'Answer 2'),
                ),
                TextField(
                  controller: _A3Controller,
                  decoration: InputDecoration(labelText: 'Answer 3'),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _A4Controller,
                  decoration: InputDecoration(
                    labelText: 'Answer 4',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _A5Controller,
                  decoration: InputDecoration(
                    labelText: 'Answer 5',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _A6Controller,
                  decoration: InputDecoration(
                    labelText: 'Answer 6',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _A7Controller,
                  decoration: InputDecoration(
                    labelText: 'Answer 7',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _A8Controller,
                  decoration: InputDecoration(
                    labelText: 'Answer 8',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _A9Controller,
                  decoration: InputDecoration(
                    labelText: 'Answer 9',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _A10Controller,
                  decoration: InputDecoration(
                    labelText: 'Answer 10',
                  ),
                ),





                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _scoreController,
                  decoration: InputDecoration(
                    labelText: 'Credit',
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String mdl = _moduleController.text;
                    final String q1 = _Q1Controller.text;
                    final String q2 =  _Q2Controller.text;
                    final String q3 =  _Q3Controller.text;
                    final String q4 =  _Q4Controller.text;
                    final String q5 =  _Q5Controller.text;
                    final String q6 =  _Q6Controller.text;
                    final String q7 =  _Q7Controller.text;
                    final String q8 =  _Q8Controller.text;
                    final String q9 =  _Q9Controller.text;
                    final String q10 =  _Q10Controller.text;
                    final String a1 = _A1Controller.text;
                    final String a2 =  _A2Controller.text;
                    final String a3 =  _A3Controller.text;
                    final String a4 =  _A4Controller.text;
                    final String a5 =  _A5Controller.text;
                    final String a6 =  _A6Controller.text;
                    final String a7 =  _A7Controller.text;
                    final String a8 =  _A8Controller.text;
                    final String a9 =  _A9Controller.text;
                    final String a10 =  _A10Controller.text;
                    final int score =  int.tryParse(_scoreController.text);
                    final DateTime dt=DateTime.now();

                    if (_Q1Controller != null && _Q2Controller != null  && _Q3Controller != null && _Q4Controller != null && _Q5Controller != null
                        && _Q6Controller != null && _Q7Controller != null &&  _Q8Controller != null && _Q9Controller != null && _Q10Controller != null  && _moduleController != null && score != null) {
                      if (action == 'create') {
                        //  mm.add(name, field, td, tp, course, year, credit, coef);

                        // Persist a new product to Firestore
                        await Quizzez.add({"Q1": q1,"Q2":q2, "Q3":q3, "Q4":q4, "Q5": q5, "Q6": q6, "Q7": q7,"Q8": q8, "Q9": q9, "Q10": q10,
                          "A1": a1,"A2":a2, "A3":a3, "A4":a4, "A5": a5, "A6": a6, "A7": a7,"A8": a8, "A9": a9, "A10": a10,"score": score, "date": dt, "module": mdl, "postedby": widget.teachername}, );
                      }

                      if (action == 'update') {
                        // Update the product
                        await Quizzez.document(documentSnapshot.documentID).updateData({"Q1": q1,"Q2":q2, "Q3":q3, "Q4":q4, "Q5": q5, "Q6": q6, "Q7": q7,"Q8": q8, "Q9": q9, "Q10": q10,
                          "A1": a1,"A2":a2, "A3":a3, "A4":a4, "A5": a5, "A6": a6, "A7": a7,"A8": a8, "A9": a9, "A10": a10,"score": score, "date": dt,  "module": mdl, "postedby": widget.teachername});
                      }

                      // Clear the text fields
                      _Q1Controller.text =" ";
                      _moduleController.text =" ";
                      _Q2Controller.text= " ";
                      _Q3Controller.text= " ";
                      _Q4Controller.text= " ";
                      _Q5Controller.text=" ";
                      _Q6Controller.text = " ";
                      _Q7Controller.text=" ";
                      _Q8Controller.text=" ";
                      _Q9Controller.text=" ";
                      _Q10Controller.text=" ";
                      _scoreController.text=" ";


                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          ));
        });
  }

  // Deleteing a product by id
  Future<void> _deleteModule(String moduleId) async {
    await Quizzez.document(moduleId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a quizz')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizz'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: SingleChildScrollView(
    child: StreamBuilder(
        stream: Quizzez.snapshots(),
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
                    title:Text(documentSnapshot['module']),
                    // subtitle: Text(documentSnapshot['email'].toString()),
                    subtitle: Column( children: [  Text('Posted By: '+documentSnapshot['postedby']),Text('Question 1: '+documentSnapshot['Q1']),Text('Question 2: '+documentSnapshot['Q2']),
                      Text('Question 3: '+documentSnapshot['Q3']),Text('  '),Text('Question 4: '+documentSnapshot['Q4']),  Text('Question 5 : '+documentSnapshot['Q5']),Text('  '),Text('Question 6: '+documentSnapshot['Q6']),
                    Text('Question 7: '+documentSnapshot['Q7']),Text('  '),Text('Question 8: '+documentSnapshot['Q8']), Text('Question 9: '+documentSnapshot['Q9']), Text("Question 10: "+documentSnapshot['Q10']),
                  Text('Answer 1: '+documentSnapshot['A1']),Text('Answer 2: '+documentSnapshot['A2']),
                  Text('Answer 3: '+documentSnapshot['A3']),Text('  '),Text('Answer 4: '+documentSnapshot['A4']),  Text('Answer 5 : '+documentSnapshot['A5']),Text('  '),Text('Answer 6: '+documentSnapshot['A6']),
                  Text('Answer 7: '+documentSnapshot['A7']),Text('  '),Text('Answer 8: '+documentSnapshot['A8']), Text('Answer 9: '+documentSnapshot['A9']), Text("Answer 10: "+documentSnapshot['A10'])]),

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
      ),),
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
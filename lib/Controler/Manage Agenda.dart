import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';






class aagnd extends StatefulWidget {
  @override
  _AgendaState createState() => _AgendaState();


}

class _AgendaState extends State<aagnd> {
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  DateTime s;
  DateTime e;
  DateTime c;
  String bb;
  DateTime cc;

  @override
  void initState() {
    Firestore.instance.collection("sessions").getDocuments().then((value) {
      value.documents.forEach((result) {
        bb=result.data['session'];
        //setState((){
        bb=result.data['session'];
        Timestamp g=result.data['starttime'];
        Timestamp gg=result.data['endtime'];
        s=g.toDate();
        e=gg.toDate();
        //});

        sh= s.hour;
        sm= s.minute;
        eh= e.hour;
        em= e.minute;
        c =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, sh, sm, 0);
        cc =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, eh, em, 0);

        //  _getDataSource(session, c, cc);
        _getDataSource(session, c, cc);
        MeetingDataSource(_getDataSource(bb, c, cc));
        print("b33333333333333333333333333333");



        // st =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0, 0);
      });
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      print(sh.toString());
    }        );

  }


  String session ="Sission";
  final DateTime today = DateTime.now();
  int sh=9;
  int sm= 0;
  int eh= 10;
  int em= 0;

  DateTime st =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0, 0);
  DateTime et =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0, 0);





  CollectionReference sessions =  Firestore.instance.collection('sessions');
  Future<void> _createOrUpdate([DocumentSnapshot documentSnapshot]) async {

    if (documentSnapshot != null) {

      _eventController.text = documentSnapshot['session'];
      _startController.text = documentSnapshot['starttime'];
      _endController.text = documentSnapshot['endtime'];

      /*   session=documentSnapshot['session'];
      st=documentSnapshot['starttime'];
      et=documentSnapshot['endtime'];*/
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
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _eventController,
                  decoration: InputDecoration(
                    labelText: 'Session name',
                  ),
                ),
                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _startController,
                  decoration: InputDecoration(
                    labelText: 'time*',
                  ),
                  onTap: () async {
                    TimeOfDay time = TimeOfDay.now();
                    FocusScope.of(context).requestFocus(new FocusNode());

                    TimeOfDay picked =
                    await showTimePicker(context: context, initialTime: time);
                    //  if (picked != null && picked != time) {
                    _startController.text = picked.toString();
                    sh=picked.hour;
                    sm=picked.minute;
                    ;


                    // }
                  },

                ),

                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _endController,
                  decoration: InputDecoration(
                    labelText: 'end time*',
                  ),
                  onTap: () async {
                    TimeOfDay time = TimeOfDay.now();
                    FocusScope.of(context).requestFocus(new FocusNode());

                    TimeOfDay picked =
                    await showTimePicker(context: context, initialTime: time);
                    if (picked != null && picked != time) {
                      _endController.text = picked.toString();
                      print ("oooooooooooooooooooooooooooiii"+ _endController.text);

                      // add this line.

                      time = picked;
                      eh=picked.hour;
                      em=picked.minute;


                    }
                  },



                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: Text("Add session"),
                    //    child: Text(action == 'create' ? 'Create' : 'Update'),

                    onPressed: ()
                     {


                      session = _eventController.text;
                      st =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, sh, sm, 0);
                      et =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, eh, em, 0);
                       sessions.add(
                          {"session": session, "starttime": st, "endtime": et});
                      print ("gggggggggggggggggggggggggggggg");
                      /*TimeOfDay strt =TimeOfDay.fromDateTime(_startController.text)  ;
                      TimeOfDay end =TimeOfDay.fromDateTime( _endController.text );*/
                      //TimeOfDay _startTime = TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));


                      //    if (session != null && st != null && et != null) {
                      //         (action == 'create') {
                      // Persist a new product to Firestore

                      /* session=documentSnapshot['session'];
                      st= documentSnapshot['strattime'];
                      et= documentSnapshot['endtime'];
                      print ("whyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");*/
                      //  _getDataSource(session, st, et);

                      /* }

                       if (action == 'update') {
                        await Teachers.document(documentSnapshot.documentID).updateData({"field": field, "email": email});
                      }*/

                      // Clear the text fields

                      _eventController.text = '';
                      _startController.text = '';
                      _endController.text = '';
                      /* st =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, sh, sm, 0);
                       et =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, eh, em, 0);*/


                      //  _getDataSource(documentSnapshot['session'], documentSnapshot['strattime'], documentSnapshot['endtime']);

                      // Hide the bottom sheet
                      Navigator.of(context).pop();




                    }

                )
              ],
            ),
          );
        });
  }
  /* setsh(int sh){this.sh=sh; return sh;}
  setsm(int sm){this.sm=sm; return sm;}
  seteh(int eh){this.eh=eh; return eh;}
  setem(int em){this.em=em; return em;}*/
  _AgendaState() ;
  // Deleteing a product by id
  Future<void> _deleteSession(String sessionId) async {
    await sessions.document(sessionId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a session')));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda Manager'),
        backgroundColor: Colors.green,
      ),
      body:Container(child:
      Column( children:<Widget>[
        Image.asset('assets/hh.jpg', height: 250, width: 600,),
        SfCalendar(

          view: CalendarView.day,


          allowedViews: <CalendarView>[
            CalendarView.day,
            CalendarView.week,
            CalendarView.workWeek,
            CalendarView.month,
            CalendarView.timelineDay,
            CalendarView.timelineWeek,
            CalendarView.timelineWorkWeek,
            CalendarView.timelineMonth,
          ],

          dataSource: MeetingDataSource(_getDataSource(bb, c, cc)),

          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),

        ),
        FloatingActionButton(
          onPressed: ()  {
            _createOrUpdate();
             Firestore.instance.collection("sessions").getDocuments().then((
                value) {
              value.documents.forEach((result) {
                session = result.data['session'];
                //  setState(() {
                session = result.data['session'];
                Timestamp g = result.data['starttime'];
                Timestamp gg = result.data['endtime'];
                s = g.toDate();
                e = gg.toDate();
                // });

                sh = s.hour;
                sm = s.minute;
                eh = e.hour;
                em = e.minute;
                c = DateTime(DateTime
                    .now()
                    .year, DateTime
                    .now()
                    .month, DateTime
                    .now()
                    .day, sh, sm, 0);
                cc = DateTime(DateTime
                    .now()
                    .year, DateTime
                    .now()
                    .month, DateTime
                    .now()
                    .day, eh, em, 0);

                _getDataSource(session, c, cc);
                MeetingDataSource(_getDataSource(bb, c, cc));
                print("b33333333333333333333333333333");


                // st =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0, 0);
              });
              _getDataSource(session, c, cc);
              print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
              print(sh.toString());
            });},



              //  _getDataSource(session, st, et );}


          child: Icon(Icons.add),
        )])),
      /*  FloatingActionButton(
              onPressed: (() {_createOrUpdate();
              _getDataSource(session, st, et );}

                  ),
              child: Icon(Icons.add),
            )*/);
  }

  List<Meeting> _getDataSource(a, b, c) {

    final List<Meeting> meetings = <Meeting>[];
    // final DateTime today = DateTime.now();
    //final DateTime startTime =  DateTime(today.year, today.month, today.day, 9, 0, 0);
    //   final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting( a, b, c, const Color(0xFF0F8644), false));
    return meetings;
  }}

class MeetingDataSource  extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }



  @override
  DateTime getStartTime(int index) {

    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}




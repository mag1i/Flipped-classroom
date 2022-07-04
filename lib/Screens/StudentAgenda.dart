import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';







class agndstdnt extends StatefulWidget {
  @override
  _agndstdnttate createState() => _agndstdnttate();
  final int sh, sm, em, eh;

  agndstdnt({Key key, this.sh, this.sm, this.em, this.eh}) : super(key: key);
}

class _agndstdnttate extends State<agndstdnt> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Agenda'),
      ),
      body:Container(child: Column( children:<Widget>[
        Image.asset('assets/hh.jpg', height: 300, width: 600,),
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

       //   dataSource: MeetingDataSource(_getDataSource(a, st, et)),

          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),

        ),
   ])),
     );
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





import 'package:firebase_database/firebase_database.dart';
import 'package:flipped_classroom/models/Course.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';



class SerachViewData extends StatefulWidget {
  @override
  _SerachViewDataState createState() => _SerachViewDataState();
}
List<Color> colur=new List();

final fb = FirebaseDatabase.instance.reference().child("Courses");
List<Courses>  list=new List();
class _SerachViewDataState extends State<SerachViewData> {
  var name, link;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Listview Design"),

      ),
      body: Container(
        child: _listNew(),
      ),
    );
  }
 /* @override
  void initState() {
    fb.once().then((DataSnapshot snap){
      print(snap);
      var data=snap.value;
      print(data);
      list.clear();
      data.forEach((key,value) {
        Courses model=new Courses(
          link= value['PDF'],
          name= value['FileName']
       //   fields: value['field'],
          //key: key,
        );
        list.add(model);
      });
      for(int i=0;i<list.length;i++){
        colur.add(Create());
      }
      setState(() {
      });
    });
  }*/
}

Color Create(){
  RandomColor _randomColor = RandomColor();
  Color _color = _randomColor.randomColor(colorHue: ColorHue.red);
  return _color;
}

Widget _listNew(){
  return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,pos){
        if(list[pos].name=="GL"){
          return CurvedListItem(
            title: list[pos].name,
            language: list[pos].link,
          /*  image: "assets/c.jpg",
            image2: list[pos].image,*/
            color: getColor(pos),
            nextColor: getColor(pos+1),
          );

        }/*else if(list[pos].fields=="GL"){
          return CurvedListItem(
            title: list[pos].name,
            language: list[pos].fields,
            image: "assets/android.jpg",
            image2: list[pos].image,
            color: getColor(pos),
            nextColor: getColor(pos+1),
          );
        }
        else if(list[pos].language=="Python"){
          return CurvedListItem(
            title: list[pos].topic,
            language: list[pos].language,
            image: "assets/python.jpg",
            image2: list[pos].image,
            color: getColor(pos),
            nextColor: getColor(pos+1),
          );
        }
        else if(list[pos].language=="C++"){
          return CurvedListItem(
            title: list[pos].topic,
            language: list[pos].language,
            image: "assets/cplus.jpg",
            image2: list[pos].image,
            color: getColor(pos),
            nextColor: getColor(pos+1),
          );
        }else{
          return CurvedListItem(
            title: list[pos].topic,
            language: list[pos].language,
            image: "assets/flutter.jpg",
            image2: list[pos].image,
            color: getColor(pos),
            nextColor: getColor(pos+1),
          );

        }*/
      }
  );
}

Color getColor(int number) {
  for(int i=0;i<list.length;i++){
    if(i==number){
      return colur[i];
    }
  }
}

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({
    this.title,
    this.language,
    this.image,
    this.image2,
    this.color,
    this.nextColor,
  });

  final String image;
  final String title;
  final String image2;
  final String language;
  final Color color;
  final Color nextColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: nextColor,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 32,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              language,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DancingScript'
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 100,
                  child:  new Stack(
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                image2,
                              ),
                            )
                        ),
                      ),
                      new Positioned(
                        left: 30,
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: new AssetImage(
                                  image,
                                ),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  language+" programming",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
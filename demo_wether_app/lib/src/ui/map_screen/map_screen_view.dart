import 'package:circular_menu/circular_menu.dart';
import 'package:demo_wether_app/src/Const/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'map_screen_logic.dart';

class MapScreenPage extends StatelessWidget {
  MapScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MapScreenLogic>();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(title: const Text('Map',),backgroundColor: cBlack,centerTitle: true,),
        body: SizedBox(height: h,
            width: w,
            child: Image.network(
              logic.map!.value,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            )),
        floatingActionButton: CircularMenu(
          radius: 150,
          alignment: Alignment.bottomRight,
          toggleButtonColor: cBlack,
          toggleButtonBoxShadow: const [BoxShadow(blurRadius: 0),],
          items: [
            CircularMenuItem(
                boxShadow: const [BoxShadow(blurRadius: 0,)],
                icon: Icons.filter_1,
                color: cGreen,
                onTap: () {
                  logic.map!.value =
                  'https://tile.openweathermap.org/map/clouds_new/0/0/0.png?appid=61fc8f2fbdf28deb396db828a62a1641&area=worldwide&cities=true';
                }),
            CircularMenuItem(
                boxShadow: const [BoxShadow(blurRadius: 0,)],
                icon: Icons.filter_2,
                color: cBlue,
                onTap: () {
                  logic.map!.value =
                  'https://tile.openweathermap.org/map/precipitation_new/0/0/0.png?appid=61fc8f2fbdf28deb396db828a62a1641&area=worldwide&cities=true';
                }),
            CircularMenuItem(
                boxShadow: const [BoxShadow(blurRadius: 0,)],
                icon: Icons.filter_3,
                color: cOrange,
                onTap: () {
                  logic.map!.value =
                  'https://tile.openweathermap.org/map/pressure_new/0/0/0.png?appid=61fc8f2fbdf28deb396db828a62a1641&area=worldwide&cities=true';
                }),
            CircularMenuItem(
                boxShadow: const [BoxShadow(blurRadius: 0,)],
                icon: Icons.filter_4,
                color: cPurple,
                onTap: () {
                  logic.map!.value =
                  'https://tile.openweathermap.org/map/wind_new/0/0/0.png?appid=61fc8f2fbdf28deb396db828a62a1641&area=worldwide&cities=true';
                }),
            CircularMenuItem(
                boxShadow: const [BoxShadow(blurRadius: 0,)],
                icon: Icons.filter_5,
                color: cBrown,
                onTap: () {
                  logic.map!.value =
                  'https://tile.openweathermap.org/map/temp_new/0/0/0.png?appid=61fc8f2fbdf28deb396db828a62a1641&area=worldwide&cities=true';
                })
          ],
        ),
      );
    });
  }

}

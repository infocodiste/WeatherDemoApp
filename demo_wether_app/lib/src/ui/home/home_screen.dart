import 'package:demo_wether_app/src/AppRoutes/app_route.dart';
import 'package:demo_wether_app/src/Const/Colors.dart';
import 'package:demo_wether_app/src/Const/app_image.dart';
import 'package:demo_wether_app/src/model/current_weather_data.dart';
import 'package:demo_wether_app/src/model/five_days_data.dart';
import 'package:demo_wether_app/src/ui/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cBlackBackGround,
      resizeToAvoidBottomInset: false,
      body:
      GetBuilder<HomeController>(
        builder: (controller) => Column(
          children: <Widget>[
            Container(
              height: h / 3,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(Assets.imgBackground),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(w * 0.05),
                  bottomRight: Radius.circular(w * 0.05),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  AppBar(
                    backgroundColor: cTransparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.menu, color: cBlack),
                      onPressed: () {},
                    ),
                    actions: [
                      GestureDetector(
                          onTap: (){
                              Get.toNamed(AppRoutes.mapScreen);
                          },
                          child: Padding(padding: EdgeInsets.only(right: w * 0.04), child: Icon(Icons.language,color: cBlack,size: h * 0.04)))
                    ],
                  ),
                  Container(
                    height: h * 0.16,
                    padding: EdgeInsets.only(top: h * 0.1, left: h * 0.05, right: h * 0.05),
                    alignment: Alignment.center,
                    child: TextField(
                      onChanged: (value) => controller.city = value,
                      style:  TextStyle(color: cBlack,),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) => controller.updateWeather(),
                      decoration: InputDecoration(
                        suffix:  GestureDetector(
                            onTap: () => controller.updateWeather(),
                            child: Icon(Icons.search, color: cBlack,)),
                        label: Text('Search', style: Theme.of(context).textTheme.caption!.copyWith(color: cBlack, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'flutterfonts'),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(color: cBlack),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(color: cBlack),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(color: cBlack),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.0, 1.0),
                    child: SizedBox(
                      height: 10,
                      width: 10,
                      child: OverflowBox(
                        minWidth: 0.0,
                        maxWidth: w,
                        minHeight: 0.0,
                        maxHeight: (h * 0.25),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: w / 25),
                              width: double.infinity,
                              height: double.infinity,
                              child: Card(
                                color: cGrey,
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * 0.05)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              controller.city == null ?  '-' : controller.city!.capitalize.toString(),
                                              style: Theme.of(context).textTheme.caption!.copyWith(color: cWhite, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'flutterfonts'),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                                              style: Theme.of(context).textTheme.caption!.copyWith(color: cWhite, fontSize: 12, fontFamily: 'flutterfonts'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                                (controller.hourlyData.value.current != null)
                                                    ? controller.hourlyData.value.current!.weather![0].description!
                                                    : '',
                                                style: Theme.of(context).textTheme.caption!.copyWith(color: cWhite, fontSize: 20, fontFamily: 'flutterfonts')),
                                            Text(
                                                (controller.hourlyData.value.current != null)
                                                    ? '${(controller.hourlyData.value.current!.temp! - 273.15).round().toString()}\u2103'
                                                    : '',
                                                style: Theme.of(context).textTheme.headline4!.copyWith(color: cWhite, fontFamily: 'flutterfonts')),
                                            ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Obx(() => SizedBox(
                                                width: w * 0.2,
                                                height: w * 0.2,
                                                child: SvgPicture.asset(controller.currentCityImage.value, fit: BoxFit.contain))),
                                            Text(
                                                (controller.hourlyData.value.current != null)
                                                    ? 'wind ${controller.hourlyData.value.current!.windSpeed!.toString()} m/s'
                                                    : '',
                                                style: Theme.of(context).textTheme.caption!.copyWith(color: cWhite, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'flutterfonts',)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w/20),
                  child: Container(
                    height: h * 2 / 3,
                    padding: EdgeInsets.only(top: h/7.5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Hourly Forecast'.capitalize.toString(),
                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: cWhite),
                            ),
                            SizedBox(height: h * 0.01),
                            SizedBox(
                              height: h * 0.17,
                              // color: Colors.red,
                              // padding: EdgeInsets.symmetric(vertical: h * 0.02),
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context,index){
                                    return SizedBox(width: w * 0.01,);
                                  },
                                  itemCount: controller.hourlyData.value.hourly == null ? 0 : controller.hourlyData.value.hourly!.length,
                                  itemBuilder: (context,index){
                                    var dateTime = DateFormat('MM-d-yyyy HH:mm:ss a').format(DateTime.fromMillisecondsSinceEpoch(controller.hourlyData.value.hourly![index].dt! * 1000));
                                    debugPrint('dateTime : $dateTime');
                                    int hours = int.parse(dateTime.substring(10,12));
                                    String hhmm = dateTime.substring(10,15);
                                    debugPrint('hours : $hours');
                                    debugPrint('hhmm : $hhmm');
                                    var temp = (controller.hourlyData.value.hourly![index].temp! - 273.15).toStringAsFixed(2);
                                    debugPrint('controller.hourlyData.value.hourly![index].temp! : ${controller.hourlyData.value.hourly![index].temp!}');
                                    debugPrint('temp : $temp');
                                    var icon = '1F4A7';
                                    return Container(
                                      width: w * 0.2,
                                      height: h * 0.15,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: cGrey),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(hhmm, style: TextStyle(color: cWhiteOpacity, fontSize: 14, fontFamily: 'flutterfonts')),
                                          hours >= 6 && hours <= 18
                                              ? Icon(Icons.wb_sunny,color: cAmber,size: h * 0.05)
                                              : Transform.rotate(angle: -180, child: Icon(Icons.brightness_2,color: cWhite,size: h * 0.05,)),
                                          Text('$temp\u00B0', style: TextStyle(color: cWhite, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'flutterfonts')),
                                          Text.rich(
                                            TextSpan(
                                              text: '💧',style: TextStyle(fontSize: 12),
                                              children: [
                                                TextSpan(text: ' ${controller.hourlyData.value.hourly![index].pop.toString()} %', style: TextStyle(color: cWhiteOpacity, fontSize: 12, fontFamily: 'flutterfonts'))
                                              ],
                                            )),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(height: h * 0.01),
                            Text(
                              'Next 5 days forecast'.capitalize.toString(),
                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: cWhite),
                            ),
                            SizedBox(height: h * 0.01),
                            Container(
                              width: w,
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                color: cWhite,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SfCartesianChart(
                                margin: EdgeInsets.only(left: w/30, top: h/60, right: w/30),
                                primaryXAxis: CategoryAxis(),
                                series: <ChartSeries<FiveDayData, String>>[
                                  SplineSeries<FiveDayData, String>(
                                    dataSource: controller.fiveDaysData,
                                    xValueMapper: (FiveDayData f, _) =>
                                        f.dateTime ,
                                    yValueMapper: (FiveDayData f, _) =>
                                        f.temp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Text(
                              'Other cities'.capitalize.toString(),
                              style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: cWhite),
                            ),
                            SizedBox(height: h / 100),
                            SizedBox(
                              height: h / 5,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    VerticalDivider(
                                  color: cTransparent,
                                  width: w / 50,
                                ),
                                itemCount: controller.dataList.length,
                                itemBuilder: (context, index) {
                                  CurrentWeatherData? data;
                                  (controller.dataList.isNotEmpty)
                                      ? data = controller.dataList[index]
                                      : data = null;
                                  return Container(
                                    width: w / 2.8,
                                    decoration: BoxDecoration(
                                        color: cGrey,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          (data != null) ? '${data.name}' : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: cWhite,
                                                fontFamily: 'flutterfonts',
                                              ),
                                        ),
                                        SizedBox(
                                          height: h / 100,
                                        ),
                                        Text(
                                          (data != null)
                                              ? '${(data.main!.temp! - 273.15).round().toString()}\u2103'
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: cWhite,
                                                fontFamily: 'flutterfonts',
                                              ),
                                        ),
                                        SizedBox(
                                          height: h / 100,
                                        ),

                                        Container(
                                          width: w/8,
                                          height: h/25,
                                          child: SvgPicture.asset(
                                            controller.imageSett(controller.dataList[index]
                                                .weather![0].main
                                                .toString()),
                                            fit: BoxFit.contain,
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        SizedBox(
                                          height: h / 100,
                                        ),
                                        Text(
                                          (data != null)
                                              ? '${data.weather![0].description}'.capitalize.toString()
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: cWhite,
                                                fontFamily: 'flutterfonts',
                                                fontSize: 14,
                                              ),
                                        ),
                                        SizedBox(
                                          height: h / 100,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: invalid_use_of_protected_member, use_super_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/weather_card.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/weather_controller.dart';
import '../../theme.dart';

class WeatherDetail extends StatefulWidget {
  const WeatherDetail({Key? key}) : super(key: key);

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var day = DateFormat('EEEE, d MMM, yyyy').format(date).toString();

    final weather = Get.put(WeatherController());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemGroupedBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Stack(
            children: [
              Container(
                width: 396,
                height: 427,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [
                      Color(0xAD3BB368),
                      Color(0x5DFEFEFE),
                      Color(0x00F4FCF7)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4, left: 10, top: 15),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            day,
                            style: sub1.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3FACACAC),
                                  blurRadius: 34,
                                  offset: Offset(0, 9),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Image.network(
                              'https://openweathermap.org/img/wn/${weather.weather.value.weather![0].icon}@2x.png',
                              scale: 1,
                            ),
                          ),
                          Text(
                            '${weather.weather.value.main!.temp.toString()}°',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 55,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.12,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text('${weather.weather.value.weather![0].main}',
                              style: sub1.copyWith(fontSize: 18)),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                              'Feels Like ${weather.weather.value.main!.feelsLike}°',
                              style: sub1.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            width: size.width * 0.85,
                            height: size.height * 0.17,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3FACACAC),
                                  blurRadius: 26,
                                  offset: Offset(0, 19),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 18.0, left: 25, right: 25, bottom: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            'assets/images/wind.gif'),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.007,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: weather
                                                  .weather.value.wind!.speed
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.73,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.66,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: 'Km/hr',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.28,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Wind",
                                        style: sub1.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: VerticalDivider(
                                      width: 10,
                                      thickness: 2,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            'assets/images/hot.gif'),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.007,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: weather
                                                  .weather.value.main!.pressure
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.73,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.66,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: 'Ha',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.28,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Pressure",
                                        style: sub1.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: VerticalDivider(
                                      width: 10,
                                      thickness: 2,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            'assets/images/humidity.gif'),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.007,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: weather
                                                  .weather.value.main!.humidity
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.73,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.66,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: '%',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.28,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Humidity",
                                        style: sub1.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "Next 4 Days",
                              style: h1.copyWith(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                          height: size.height * 0.37,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: weather.forecastWeatherList.length,
                              itemBuilder: (context, i) {
                                return WeatherCard(
                                    // ignore: duplicate_ignore
                                    // ignore: invalid_use_of_protected_member
                                    size,
                                    weather.forecastWeatherList.value[i]);
                              })),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

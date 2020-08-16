import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stock_graph/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stock_graph/notification/local_notification_screen.dart';

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  String selectedData = 'Reliance';
  String stock = '2,115.75';
  String day, mon, year, hour, min;
  bool showAvg = false;
  double sl1 = 37900;
  double sl2 = 39000;
  double sl3 = 37800;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String data in company) {
      var newItem = DropdownMenuItem(
        child: Text(
          data,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        value: data,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedData,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedData = value;
          showNoti();
        });
      },
    );
  }

  void timeDate() {
    setState(() {
      var now = new DateTime.now();
      day = now.day.toString();
      mon = months[now.month];
      year = now.year.toString();
      hour = now.hour.toString();
      min = now.minute.toString();
    });
  }

  Future showNoti() async{
    await notificationPlugin.showNotification(selectedData, stock);
  }

  @override
  void initState() {
    super.initState();
    timeDate();
    notificationPlugin.setListenerForLowerVersion(onNotificationInLowerVersion);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
    showNoti();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.notifications,
              color: Colors.black,
              size: 30.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.search,
              color: Colors.black,
              size: 30.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.person_pin,
              color: Colors.black,
              size: 30.0,
            ),
          ],
        ),
      ),
    );

    final dropDownItems = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  androidDropdown(),
                  Text(
                    stock,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Vol: 13,860,687',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$day $mon $year $hour:$min',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
    );

    final overview = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 12, bottom: 12),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'OFFER PRICE',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              '12,456.23',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'TODAY\'S LOW/HIGH',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '37694.92',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 45,
                                ),
                                Text(
                                  '38540.57',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbColor: Colors.grey,
                                activeTrackColor: Colors.red,
                                overlayColor: Color(0x29EB1555),
                                trackShape: CustomTrackShape(),
                                thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5.0),
                                overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 25.0),
                              ),
                              child: Slider(
                                value: sl1,
                                min: 37694.92,
                                max: 38540.57,
                                inactiveColor: Color(0xFF8D8E98),
                                onChanged: (double newValue) {
                                  setState(() {
                                    sl1 = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'PRIVIOUS CLOSE',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                ),
                                Text(
                                  '38,310.49',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '52 WK LOW/HIGH',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '25,638.90',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      width: 38,
                                    ),
                                    Text(
                                      '42,273.87',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: Colors.grey,
                                    activeTrackColor: Colors.red,
                                    overlayColor: Color(0x29EB1555),
                                    trackShape: CustomTrackShape(),
                                    thumbShape:
                                    RoundSliderThumbShape(enabledThumbRadius: 5.0),
                                    overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 25.0),
                                  ),
                                  child: Slider(
                                    value: sl2,
                                    min: 25638.90,
                                    max: 42273.87,
                                    inactiveColor: Color(0xFF8D8E98),
                                    onChanged: (double newValue) {
                                      setState(() {
                                        sl2 = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'OPEN PRICE',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              '12,456.23',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'L/U PRICE BRAND',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '37694.92',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 45,
                                ),
                                Text(
                                  '38540.57',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbColor: Colors.grey,
                                activeTrackColor: Colors.red,
                                overlayColor: Color(0x29EB1555),
                                trackShape: CustomTrackShape(),
                                thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5.0),
                                overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 25.0),
                              ),
                              child: Slider(
                                value: sl3,
                                min: 37694.92,
                                max: 38540.57,
                                inactiveColor: Color(0xFF8D8E98),
                                onChanged: (double newValue) {
                                  setState(() {
                                    sl3 = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                appBar,
                dropDownItems,
                SizedBox(
                  height: 5.0,
                ),
                overview,
                Container(
                  width: double.infinity,
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onNotificationInLowerVersion(ReceivedNotification receivedNotification) {}

  onNotificationClick(String payload){
    print('Payload $payload');
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1D';
              case 4:
                return '5D';
              case 7:
                return '1M';
              case 10:
                return '3M';
              case 13:
                return '6M';
              case 16:
                return '1Y';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '2000';
              case 3:
                return '2100';
              case 5:
                return '2200';
              case 7:
                return '2400';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 18,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
            FlSpot(12, 3),
            FlSpot(12.6, 2),
            FlSpot(13.9, 5),
            FlSpot(16, 3.1),
            FlSpot(17, 4),
            FlSpot(18, 3.1),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1D';
              case 4:
                return '5D';
              case 7:
                return '1M';
              case 10:
                return '3M';
              case 13:
                return '6M';
              case 16:
                return '1Y';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '2000';
              case 3:
                return '2100';
              case 5:
                return '2200';
              case 7:
                return '2400';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 18,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
            FlSpot(12, 3),
            FlSpot(12.6, 2),
            FlSpot(13.9, 5),
            FlSpot(16, 3.1),
            FlSpot(17, 4),
            FlSpot(18, 3.1),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
          ],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}


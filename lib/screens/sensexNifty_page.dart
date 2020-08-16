import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stock_graph/constant.dart';
import 'package:stock_graph/notification/local_notification_screen.dart';

class SensexNifty extends StatefulWidget {
  @override
  _SensexNiftyState createState() => _SensexNiftyState();
}

class _SensexNiftyState extends State<SensexNifty> {
  String selectedData = 'SENSEX';
  String stock = '37,762.56';
  String day, mon, year, hour, min;
  double sl1 = 37800;
  double sl2 = 39000;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String data in sensexNiftyData) {
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

  Future showNoti() async {
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
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
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
                      fontSize: 25.0,
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
                        padding: const EdgeInsets.only(left: 10, right: 30),
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
                        padding: const EdgeInsets.only(left: 10, right: 30),
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
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 5.0),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 25.0),
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
                            padding: const EdgeInsets.only(left: 10, right: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'PRIVIOUS PRICE',
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
                            padding: const EdgeInsets.only(left: 10, right: 30),
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
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 5.0),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 25.0),
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
              ],
            ),
          ),
        ],
      ),
    );

    final returns = Container(
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
                'Returns',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'YTD',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '-8.44%',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '1 WEEK',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '-1.07%',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 3.0, 50.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '1 MONTH',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '3.44%',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '3 MONTHS',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '25.79%',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 3.0, 50.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '6 MONTHS',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '-8.00%',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '1 YEAR',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '1.24%',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 3.0, 50.0, 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '2 YEARS',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '-0.21%',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '3 YEARS',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '20.11%',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final simpleMovingAverage = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Simple Moving Averages',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '30 DAYS',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '37,395.77',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '50 DAYS',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '36,233.90',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 3.0, 50.0, 5.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '150 DAYS',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '35,563.70',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '200 DAYS',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '36,869.83',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
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
                SizedBox(
                  height: 5.0,
                ),
                returns,
                SizedBox(
                  height: 5.0,
                ),
                simpleMovingAverage,
              ],
            ),
          ),
        ),
      ),
    );
  }

  onNotificationInLowerVersion(ReceivedNotification receivedNotification) {}

  onNotificationClick(String payload) {
    print('Payload $payload');
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

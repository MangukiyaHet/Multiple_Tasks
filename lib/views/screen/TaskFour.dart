import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:logic_app/helper/LoginAPIHelper.dart';
import 'package:logic_app/views/utils/VariableUtils.dart';
import 'package:logic_app/views/widget/BuildWeekDay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskFour extends StatefulWidget {
  const TaskFour({Key? key}) : super(key: key);

  @override
  _TaskFourState createState() => _TaskFourState();
}

class _TaskFourState extends State<TaskFour> {
  late DateTime _currentDate;
  List<Map<String, dynamic>> _calendarData = [];
  final _apiHelper = APIHelper.apiHelper;
  late Future<void> _fetchCalendarDataFuture;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _fetchCalendarDataFuture = _fetchCalendarData();
  }

  Future<void> _fetchCalendarData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String getName = prefs.getString(TokenKey) ?? "API not show";
      String token = getName;
      String userId = "1";
      String from = "app";
      String month = _currentDate.month.toString();
      String year = _currentDate.year.toString();

      Map? calendarData =
          await _apiHelper.fetchCalendarData(token, userId, from, month, year);

      log('===============================================================');
      log('Calendar Data: $calendarData');
      log('===============================================================');

      if (calendarData != null && calendarData['data'] != null) {
        List<dynamic> rawData = calendarData['data'];
        List<Map<String, dynamic>> structuredData = [];

        rawData.forEach((item) {
          structuredData.add({
            'date': item['date'],
            'day': item['day'],
            'istoday': item['istoday'],
          });
        });
        if (mounted) {
          setState(() {
            _calendarData = structuredData;
          });
        }
      } else {
        throw Exception('Failed to load calendar data');
      }
    } on ClientException catch (e) {
      log('ClientException: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to connect to the server.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on PlatformException catch (e) {
      log('PlatformException: $e');
    } catch (e) {
      log('Error: $e');
    }
  }

  int _startWeekdayIndex() {
    return (_currentDate.weekday + 6) % 7;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calendar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _fetchCalendarDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            log("===========================================");
            log("${snapshot.error}");
            log("===========================================");
            return Center(
              child: Text(
                "Error : ${snapshot.error}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentDate = DateTime(
                                _currentDate.year, _currentDate.month - 1);
                            _fetchCalendarDataFuture = _fetchCalendarData();
                          });
                        },
                        child: const Text(
                          "Previous",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "${_currentDate.month}/${_currentDate.year}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentDate = DateTime(
                                _currentDate.year, _currentDate.month + 1);
                            _fetchCalendarDataFuture = _fetchCalendarData();
                          });
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      for (var day in [
                        'Mon',
                        'Tue',
                        'Wed',
                        'Thu',
                        'Fri',
                        'Sat',
                        'Sun'
                      ])
                        BuildWeekDay(day),
                    ],
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio:
                          1, // Adjust this value as needed for the aspect ratio
                    ),
                    itemCount: _calendarData.length + _startWeekdayIndex(),
                    itemBuilder: (context, index) {
                      if (index < _startWeekdayIndex()) {
                        // Empty cells before the first date
                        return Container();
                      }
                      final dateIndex = index - _startWeekdayIndex();
                      final date = _calendarData[dateIndex]['date'].toString();
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color:
                                      _calendarData[dateIndex]['istoday'] == 1
                                          ? Colors.red
                                          : Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

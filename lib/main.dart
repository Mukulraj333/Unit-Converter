import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:const Text('Unit Converter'),
        ),
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextStyle labelStyle = const TextStyle(
    fontSize: 16.0,
    color: Colors.blue,
  );

  final TextStyle resultSyle = TextStyle(
    color: Colors.blue,
    fontSize: 25.0,
    fontWeight: FontWeight.w600,
  );

  final List<String> _measurement = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms',
    'Feet',
    'Miles',
    // 'Pounds',
    // 'Ounces'
  ];

  late double _value;
  String _fromMeasurement = 'Meters';
  String _toMeasurement = 'Kilometers';
  String _results = "";

  final Map<String, int> _measuresMap = {
    'Meters': 0,
    'Kilometers': 1,
    'Grams': 2,
    'Kilograms': 3,
    'Feet': 4,
    'Miles': 5,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: "Enter the Value",
                focusColor: Colors.blue,
              ),
              onChanged: (value) {
                setState(() {
                  _value = double.parse(value);
                });
              },
            ),

            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    DropdownButton(
                      items: _measurement
                          .map((String value) => DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _fromMeasurement = value!;
                        });
                      },
                      value: _fromMeasurement,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    DropdownButton(
                      items: _measurement
                          .map((String value) => DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _toMeasurement = value!;
                        });
                      },
                      value: _toMeasurement,
                    )
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              // decoration: BoxDecoration(
              //   color: Colors.teal,
              //   borderRadius: BorderRadius.circular(10),
              //   border: Border.all(
              //     width: 2,
              //     color: Colors.teal,
              //   )
              // ),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: _convert,
                child: Text(
                  'Convert',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              _results,
              style: resultSyle,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  void _convert() {
    print("Cliked");
    print(_value);

    if (_value != 0 && _fromMeasurement.isNotEmpty && _toMeasurement.isNotEmpty) {
      var from = _measuresMap[_fromMeasurement];
      var to = _measuresMap[_toMeasurement];

      var multiplier = _formulas[from.toString()][to];
      setState(() {
        _results =
            "$_value $_fromMeasurement = ${_value * multiplier} $_toMeasurement";
      });
    } else {
      setState(() {
        _results = "Enter a non zero value";
      });
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models.dart';
import 'dart:math' as math;
import 'package:syncfusion_flutter_charts/charts.dart';

class FarmScreen extends StatefulWidget {
  final Farm farm;
  final Organisation org;

  FarmScreen({required this.farm, required this.org});

  @override
  _FarmScreenState createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {
  List<TimeSeriesData> _chartData = []; // Track chart data for display
  final List<String> _timeOptions = ['1D', '1M', '6M', '1Y', 'All'];
  String _selectedTimeOption = '1D';
  double _maxYValue = 1.0; // Initialize maximum Y value
  int _numHoursToShow = 24; // Number of hours to show initially
  double _primaryXAxisLabelInterval = 1; // Interval for X-axis labels

  @override
  void initState() {
    super.initState();
    // Fetch initial chart data
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        backgroundColor: Color(0xff252525),
        primaryColor: Colors.lightGreenAccent,
        scaffoldBackgroundColor: Color(0xff252525),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.farm.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 300, // Adjust height as needed
                child: SfCartesianChart(
                  borderWidth: 0,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    visibleMaximum: _numHoursToShow.toDouble(),
                    majorGridLines: MajorGridLines(width: 0),
                    labelIntersectAction: _selectedTimeOption == '1D'
                        ? AxisLabelIntersectAction.rotate45
                        : AxisLabelIntersectAction
                            .none, // Rotate labels for 1D option
                    labelPlacement: LabelPlacement.onTicks,
                    interval: _primaryXAxisLabelInterval,
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                  primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: _maxYValue,
                    majorGridLines: MajorGridLines(width: 0),
                    title: AxisTitle(
                      text: 'Energy Generated',
                    ),
                  ),
                  series: <ChartSeries>[
                    LineSeries<TimeSeriesData, String>(
                      dataSource: _chartData,
                      xValueMapper: (TimeSeriesData sales, _) => sales.time,
                      yValueMapper: (TimeSeriesData sales, _) => sales.value,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _timeOptions.map((option) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTimeOption = option;
                          fetchData(); // Fetch data for the selected time option
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: _selectedTimeOption == option
                            ? Colors.lightGreen
                            : Colors.grey, // Change color based on selection
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    // Construct the API endpoint URL based on selected time option
    String url = 'http://172.16.17.4:3000/fetch/${widget.farm.id}/returns';
    if (_selectedTimeOption != 'All') {
      url += '?duration=$_selectedTimeOption';
    }

    // Make HTTP GET request
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse response JSON
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> rawData = jsonData['data'];
      List<TimeSeriesData> data = [];

      // Convert JSON data to TimeSeriesData objects
      for (var item in rawData) {
        data.add(TimeSeriesData(
          item['timestamp'], // Use 'timestamp' field as time
          double.parse(item['energyGeneratedKilowattHours']
              .toString()), // Parse energyGeneratedKilowattHours to double
        ));
      }

      // Update state with fetched data
      setState(() {
        _chartData = data;
        _updateMaxYValue(_chartData); // Update maximum Y value
        _updateAxisLabels(_selectedTimeOption); // Update axis labels
      });
    } else {
      // Handle error
      print('Failed to fetch data: ${response.statusCode}');
      // Optionally, you can show an error message to the user
    }
  }

  // Function to update maximum Y value based on chart data
  void _updateMaxYValue(List<TimeSeriesData> data) {
    double max =
        data.isNotEmpty ? data.map((e) => e.value).reduce(math.max) : 1.0;
    setState(() {
      _maxYValue = max;
    });
  }

  // Function to update X-axis labels based on selected time option
  void _updateAxisLabels(String selectedTimeOption) {
    setState(() {
      switch (selectedTimeOption) {
        case '1D':
          _primaryXAxisLabelInterval = 1; // Show hourly labels
          break;
        case '1M':
          _primaryXAxisLabelInterval = 5; // Show 5 day interval labels
          break;
        case '6M':
          _primaryXAxisLabelInterval = 1; // Show monthly labels
          break;
        case '1Y':
        case 'All':
          _primaryXAxisLabelInterval = 1; // Show yearly labels (every month)
          break;
        default:
          _primaryXAxisLabelInterval = 1;
      }
    });
  }
}

// Model class for time series data
class TimeSeriesData {
  final String time;
  final double value;

  TimeSeriesData(this.time, this.value);
}

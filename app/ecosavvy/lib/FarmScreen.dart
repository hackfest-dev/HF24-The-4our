import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'models.dart';
import 'dart:math' as math;

class FarmScreen extends StatefulWidget {
  final Farm farm;
  final Organisation org;

  FarmScreen({required this.farm, required this.org});

  @override
  _FarmScreenState createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> with TickerProviderStateMixin {
  late List<TimeSeriesData> _chartData =
      []; // Initialize _chartData to an empty list
  final List<String> _timeOptions = ['1D', '1M', '6M', '1Y', 'All'];
  String _selectedTimeOption = '1D';
  double _maxYValue = 1.0; // Initialize maximum Y value
  double _primaryXAxisVisibleMaximum =
      24.0; // Initial visible maximum for 1D option
  double _primaryXAxisInterval = 3.0; // Initial interval for 1D option
  bool _isLoading = false; // Flag to track loading state
  late TabController _tabController;
  late PageController _pageController;
  int _selectedTabIndex = 0;
  String _tooltipText = '';
  Offset _tooltipPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    // Initialize chart data with data from API for the selected time option
    _fetchDataForTimeOption(_selectedTimeOption);
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: 0);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
    _pageController.animateToPage(
      _selectedTabIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Apply the theme
    final ThemeData theme = Theme.of(context).copyWith(
      backgroundColor: Color.fromARGB(255, 0, 0, 0), // Set background color
      primaryColor: Colors.lightGreenAccent, // Set primary color
      scaffoldBackgroundColor:
          Color.fromARGB(255, 0, 0, 0), // Set scaffold background color
      textTheme: Theme.of(context).textTheme.copyWith(
            bodyText1: TextStyle(color: Colors.white), // Set text color
            bodyText2: TextStyle(color: Colors.white), // Set text color
          ),
    );

    return Theme(
      data: theme,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    widget.farm.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
                height: 300, // Adjust height as needed
                child: Stack(
                  children: [
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        final dynamic xPos =
                            (details.localPosition.dx / context.size!.width) *
                                _primaryXAxisVisibleMaximum;
                        final int nearestIndex =
                            (xPos.round()).clamp(0, _chartData.length - 1);
                        final TimeSeriesData dataPoint =
                            _chartData[nearestIndex];
                        showTooltip(dataPoint.time, dataPoint.value,
                            details.localPosition);
                      },
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        borderWidth: 0,
                        plotAreaBorderColor: Color.fromARGB(255, 138, 188, 80),
                        primaryXAxis: CategoryAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            minorGridLines: MinorGridLines(width: 0),
                            isVisible: false),
                        primaryYAxis: NumericAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            minorGridLines: MinorGridLines(width: 0),
                            isVisible: false),
                        series: <ChartSeries>[
                          LineSeries<TimeSeriesData, String>(
                            dataSource: _chartData,
                            xValueMapper: (TimeSeriesData sales, _) =>
                                sales.time,
                            yValueMapper: (TimeSeriesData sales, _) =>
                                sales.value,
                            color: Color.fromARGB(186, 162, 204, 98),
                          )
                        ],
                        crosshairBehavior: CrosshairBehavior(
                            lineType: CrosshairLineType.both,
                            lineColor: Colors.grey,
                            lineWidth: 1,
                            enable: true,
                            activationMode: ActivationMode.singleTap,
                            lineDashArray: [5, 5]),
                      ),
                    ),
                    Positioned(
                      left: _tooltipPosition.dx - 50,
                      top: _tooltipPosition.dy - 50,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _tooltipText,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 20),
            TabBar(
              indicatorColor: Colors.lightGreen,
              controller: _tabController,
              tabs: [
                Tab(text: 'Details'),
                Tab(text: 'News'),
                Tab(text: 'My Shares'),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  _tabController.animateTo(index);
                },
                children: [
                  // Details Tab
                  Center(child: Text('Details Tab')),
                  // News Tab
                  Center(child: Text('News Tab')),
                  // My Shares Tab
                  Center(child: Text('My Shares Tab')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to fetch data from API for the selected time option
  Future<void> _fetchDataForTimeOption(String timeOption) async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    // Construct the API endpoint URL based on selected time option
    String url =
        'http://172.16.17.4:3000/fetch/${widget.farm.id}/returns?duration=$timeOption';

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
      List<TimeSeriesData> processData(List<TimeSeriesData> rawData) {
        // Extract hour from the timestamp and create new TimeSeriesData objects
        List<TimeSeriesData> processedData = rawData.map((data) {
          String hour = data.time.split('T')[1].split(':')[0];
          return TimeSeriesData(hour, data.value);
        }).toList();

        return processedData;
      }

      // Update state with fetched data
      setState(() {
        _chartData = processData(data);
        _updateMaxYValue(_chartData); // Update maximum Y value
        _updateXAxisOptions(
            _selectedTimeOption); // Update X-axis options based on selected time option
        _updateVisibleRange(); // Update visible range
        _isLoading = false; // Set loading state to false
      });
    } else {
      // Handle error
      print('Failed to fetch data: ${response.statusCode}');
      // Optionally, you can show an error message to the user
      setState(() {
        _isLoading = false; // Set loading state to false
      });
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

  // Function to update X-axis options based on selected time option
  void _updateXAxisOptions(String selectedTimeOption) {
    setState(() {
      switch (selectedTimeOption) {
        case '1D':
          _primaryXAxisVisibleMaximum = 24.0;
          _primaryXAxisInterval =
              3.0; // Show hourly labels with an interval of 3 hours
          break;
        case '1M':
          _primaryXAxisVisibleMaximum = 24 * 30.0;
          _primaryXAxisInterval = 5 * 24.0; // Show 5 day interval labels
          break;
        case '6M':
          _primaryXAxisVisibleMaximum = 24 * 30 * 6.0;
          _primaryXAxisInterval =
              30 * 24 * 3.0; // Show monthly labels with an interval of 3 months
          break;
        case '1Y':
          _primaryXAxisVisibleMaximum = 24 * 365.0;
          _primaryXAxisInterval = 30 *
              24 *
              3 *
              4.0; // Show yearly labels with an interval of 4 years
          break;
        case 'All':
          _primaryXAxisVisibleMaximum = _chartData.length.toDouble();
          _primaryXAxisInterval = 30 *
              24 *
              3 *
              4 *
              10.0; // Show labels for every 10 years for all data
          break;
        default:
          _primaryXAxisInterval = 1.0;
      }
    });
  }

  // Function to update visible range based on the selected time option
  void _updateVisibleRange() {
    setState(() {
      // Reset the visible range to show the latest data
      if (_selectedTimeOption == 'All') {
        _primaryXAxisVisibleMaximum = _chartData.length.toDouble();
      }
    });
  }

  void showTooltip(String time, double value, Offset tapPosition) {
    setState(() {
      _tooltipText =
          'Time: $time:00 hrs\nEnergy: ${value.toStringAsFixed(2)} kwh';
      _tooltipPosition = tapPosition;
    });
  }
}

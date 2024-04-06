import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'models.dart';
import 'dart:math' as math;

class FarmScreen extends StatefulWidget {
  final Farm farm;
  final Organisation org;
  final List<Portfolio> userPortfolio;

  FarmScreen(
      {required this.farm, required this.org, required this.userPortfolio});

  @override
  _FarmScreenState createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> with TickerProviderStateMixin {
  late List<TimeSeriesData> _chartData =
      []; // Initialize _chartData to an empty list
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
  int sharesToBuy = 0;
  bool isLoading = false;
  double? avgEnergyOutput;
  double? avgReturns;
  double? highestOutput;
  double? highestLastYear;
  double? lowestLastYear;
  double? farmDegradePercent;
  double? farmMaintenancePercent;
  double? currentOutput;


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
                        final double xPos = details.localPosition.dx;

                        // Calculate index of the nearest data point based on the tap position
                        final int nearestIndex =
                            (xPos / context.size!.width * _chartData.length)
                                .round();

                        // Ensure that the index is within valid bounds
                        if (nearestIndex >= 0 &&
                            nearestIndex < _chartData.length) {
                          final TimeSeriesData dataPoint =
                              _chartData[nearestIndex];

                          // Use the energy value from the TimeSeriesData directly
                          final double energyValue = dataPoint.value;

                          // Use the obtained energyValue along with the time value in your tooltip or wherever it's needed
                          showTooltip(dataPoint.time, energyValue,
                              details.localPosition);
                        }
                      },
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        borderWidth: 0,
                        plotAreaBorderColor: Color.fromARGB(255, 138, 188, 80),
                        primaryXAxis: CategoryAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            minorGridLines: MinorGridLines(width: 0),
                            isVisible: true),
                        primaryYAxis: NumericAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            minorGridLines: MinorGridLines(width: 0),
                            isVisible: false),
                        series: <ChartSeries>[
                        StackedAreaSeries<TimeSeriesData, String>(
                          dataSource: _chartData,
                          xValueMapper: (TimeSeriesData sales, _) => sales.time,
                        yValueMapper: (TimeSeriesData sales, _) => sales.value,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 0, 255, 247).withOpacity(0.5),
                              Color.fromARGB(255, 0, 255, 247).withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),

                          LineSeries<TimeSeriesData, String>(
                            dataSource: _chartData,
                            xValueMapper: (TimeSeriesData sales, _) => sales.time,
                            yValueMapper: (TimeSeriesData sales, _) => sales.value,
                            color: Color.fromARGB(255, 0, 255, 247), // Define the color for the line
                          ),
                        ],
                        crosshairBehavior: CrosshairBehavior(
                          lineType: CrosshairLineType.both,
                          lineColor: Colors.grey,
                          lineWidth: 1,
                          enable: true,
                          activationMode: ActivationMode.singleTap,
                          lineDashArray: [5, 5],
                        ),
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
              indicatorColor: Colors.teal,
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
                  Center(
                      child: // Details Tab
                          Container(
                    padding: EdgeInsets.all(16),
                    child:// Inside your Details Tab child
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Average Energy Output: ${avgEnergyOutput?.toStringAsFixed(2) ?? 'Loading...'} kWh'),
                        Text('Average Returns: ${avgReturns?.toStringAsFixed(2) ?? 'Loading...'}'),
                        Text('Highest Output: ${highestOutput?.toStringAsFixed(2) ?? 'Loading...'} kWh'),
                        Text('Highest Output Last Year: ${highestLastYear?.toStringAsFixed(2) ?? 'Loading...'} kWh'),
                        Text('Lowest Output Last Year: ${lowestLastYear?.toStringAsFixed(2) ?? 'Loading...'} kWh'),
                        Text('Farm Degradation Percent: ${farmDegradePercent?.toStringAsFixed(2) ?? 'Loading...'}%'),
                        Text('Farm Maintenance Percent: ${farmMaintenancePercent?.toStringAsFixed(2) ?? 'Loading...'}%'),
                        Text('Current Output: ${currentOutput?.toStringAsFixed(2) ?? 'Loading...'} kWh'),
                      ],
                    ),

                          )),
                  // News Tab
                  Center(child: Text('News Tab')),
                  // My Shares Tab
                  widget.userPortfolio.isNotEmpty
                      ? MySharesTab(
                          farm: widget.farm,
                          org: widget.org,
                          userPortfolio: widget.userPortfolio)
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Invest in ${widget.farm.name} today',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         BuySharesPage(farmId: widget.farm.id),
                                  //   ),
                                  // );
                                  _showBuyDialog();
                                },
                                child: Text('Buy'),
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
      Map<String, dynamic> analyticsData = jsonData['analytics'];
      List<dynamic> rawData = jsonData['data'];

      List<TimeSeriesData> data = [];

      // Convert JSON data to TimeSeriesData objects
      for (var item in rawData) {
        print(item);
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


// Now set your state variables
      setState(() {
        avgEnergyOutput = (analyticsData['avgEnergyOutput'] is int) ? (analyticsData['avgEnergyOutput'] as int).toDouble() : analyticsData['avgEnergyOutput'];
        avgReturns = (analyticsData['avgReturns'] is int) ? (analyticsData['avgReturns'] as int).toDouble() : analyticsData['avgReturns'];
        highestOutput = (analyticsData['highestOutput'] is int) ? (analyticsData['highestOutput'] as int).toDouble() : analyticsData['highestOutput'];
        highestLastYear = (analyticsData['highestLastYear'] is int) ? (analyticsData['highestLastYear'] as int).toDouble() : analyticsData['highestLastYear'];
        lowestLastYear = (analyticsData['lowestLastYear'] is int) ? (analyticsData['lowestLastYear'] as int).toDouble() : analyticsData['lowestLastYear'];
        farmDegradePercent = (analyticsData['farmDegradePercent'] is int) ? (analyticsData['farmDegradePercent'] as int).toDouble() : double.tryParse(analyticsData['farmDegradePercent'].toString());
        farmMaintenancePercent = (analyticsData['farmMaintenancePercent'] is int) ? (analyticsData['farmMaintenancePercent'] as int).toDouble() : double.tryParse(analyticsData['farmMaintenancePercent'].toString());
        currentOutput = (analyticsData['currentOutput'] is int) ? (analyticsData['currentOutput'] as int).toDouble() : analyticsData['currentOutput'];

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

  void _showBuyDialog() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Buy Shares'),
              backgroundColor: Colors.black,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Energy Type: ${widget.farm.energytype}',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Number of Investors: ${widget.farm.noofinvestors}',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Farm Valuation: ${widget.farm.farmValuation}',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Total Investors: ${widget.farm.noofinvestors}',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Number of Shares: ${widget.farm.numberOfShares}',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Available Shares: ${widget.farm.availableShares}',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Each Share Price: ${widget.farm.eachSharePrice}',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Energy Unit: ${widget.farm.energyUnit}',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Energy Per Share: ${widget.farm.energyPerShare}',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter the number of shares to buy:',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Optionally, make the text bold
                      // Add more text style properties as needed
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        sharesToBuy = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (sharesToBuy > 0 &&
                          sharesToBuy <= widget.farm.availableShares) {
                        _buyShares(sharesToBuy);
                      } else {
                        // Handle invalid input
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(
                              255, 30, 102, 12)), // Change color as needed
                    ),
                    child: Text('Buy'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    return prefs.getString('token');
  }

  void _buyShares(int sharesToBuy) async {
    setState(() {
      isLoading = true;
    });

    String farmId = widget.farm.id;
    String transactionId =
        'shiuffiufgfgsiddferrbuygsrt'; // Generate a random transaction ID
    String timestamp = DateTime.now().toIso8601String();

    // Send a request to the specified URL with the required attributes
    final String apiUrl = 'http://172.16.17.4:3000/investor/invest';
    final String? userToken = await _getToken();

    http
        .post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'farmId': farmId,
        'noOfShares': sharesToBuy,
        'transactionID': transactionId,
        'timestamp': timestamp,
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        // Handle success
        print('Shares bought successfully!');
        _showSuccessDialog();
      } else {
        // Handle error
        print('Failed to buy shares: ${response.statusCode}');
        _showFailureDialog();
      }
    }).catchError((error) {
      // Handle error
      print('Error buying shares: $error');
      _showFailureDialog();
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Shares bought successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFailureDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Failure'),
        content: Text('Failed to buy shares.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class MySharesTab extends StatefulWidget {
  final Farm farm;
  final Organisation org;
  final List<Portfolio> userPortfolio;

  MySharesTab(
      {required this.farm, required this.org, required this.userPortfolio});

  @override
  _MySharesTabState createState() => _MySharesTabState();
}

class _MySharesTabState extends State<MySharesTab> {
  int sharesToBuy = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Filter user's portfolio data for the current farm
    List<Portfolio> farmShares = widget.userPortfolio
        .where((portfolio) => portfolio.farm.farmID == widget.farm.id)
        .toList();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Invest in ${widget.farm.name} today',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          // Display details of purchased shares
          if (farmShares.isNotEmpty)
            Column(
              children: [
                Text(
                  'Your Shares:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                // Display details of each purchased share
                for (var share in farmShares)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Number of Shares: ${share.investmentDetails.noOfShares}'),
                      Text(
                          'Returns: ₹${share.investmentDetails.returns.toStringAsFixed(3)}'),
                      SizedBox(height: 10),
                    ],
                  ),
              ],
            ),
          // Button to buy additional shares
        ],
      ),
    );
  }

  // Function to show the buy shares dialog
}

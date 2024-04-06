import 'dart:convert';
import 'package:ecosavvy/FarmScreen.dart';
import 'package:ecosavvy/Portfolio_farm_details.dart';
import 'package:ecosavvy/fetchapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models.dart'; // Import your models

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  List<Portfolio> userPortfolio = []; // List to hold user's portfolio
  late Future<List<Organisation>> futureOrganisations;
  List<Organisation>? organisations; // Add this line
  late Farm selectedFarm;
  late Organisation selectedOrg;

  @override
  void initState() {
    super.initState();
    futureOrganisations = fetchOrganisations()
      ..then((orgs) => organisations = orgs);
    // Fetch user's portfolio data when the widget is initialized
    fetchUserPortfolio();
  }

  Future<void> fetchUserPortfolio() async {
    final String userToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoiaW52ZXN0b3IiLCJhYWRoYXJOdW1iZXIiOiJLTkZLTkJHMDAzIiwiaWF0IjoxNzEyMzQwNzAzfQ.5_cirnavbaCkWu6YDTGAe271LELEtAGMQ83yhTbQjXU'; // Assuming userToken is available
    final String apiUrl = 'http://172.16.17.4:3000/investor/portfolio';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        // Check if the response body is not null
        if (response.body != null) {
          // Decode the response body
          List<dynamic> data = await jsonDecode(response.body);
          List<Portfolio> portfolioList =
              data.map((json) => Portfolio.fromJson(json)).toList();

          setState(() {
            userPortfolio = portfolioList;
          });
        } else {
          // Handle the case where the response body is null
          throw Exception('Response body is null');
        }
      } else {
        // Handle non-200 status code
        throw Exception('Failed to fetch user portfolio');
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error fetching user portfolio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Your Investments",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: userPortfolio.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator(), // Show a loading indicator while fetching data
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: userPortfolio.map((portfolio) {
                  return GestureDetector(
                    onTap: () {
                      // Find the farm details based on the farmID

                      for (var org in organisations!) {
                        for (var farm in org.farms) {
                          if (farm.id == portfolio.farm.farmID) {
                            selectedFarm = farm;
                            selectedOrg = org;
                            break;
                          }
                        }
                      }

                      // Navigate to farm screen and pass farm details

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FarmScreen(
                            farm: selectedFarm,
                            org: selectedOrg,
                            userPortfolio: userPortfolio,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Farm Name: ${portfolio.farm.farmName ?? ''}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${portfolio.org.orgName}',
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'No. of shares: ${portfolio.investmentDetails.noOfShares}',
                                    //'${portfolio.investmentDetails.returns}',
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 75, 75, 75),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 50, // Define the height
                                width: 100, // Define the width
                                child: Center(
                                  child: Text(
                                    '₹ ${portfolio.investmentDetails.returns.toStringAsFixed(3)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}

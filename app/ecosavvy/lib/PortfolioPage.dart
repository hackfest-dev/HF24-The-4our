import 'dart:convert';
import 'package:ecosavvy/FarmScreen.dart';
import 'package:ecosavvy/Portfolio_farm_details.dart';
import 'package:ecosavvy/fetchapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
    final String? userToken = await _getToken() ;
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
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
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
              CircularProgressIndicator(color: Colors.lightGreenAccent))
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
                        color: Color.fromARGB(255, 0, 0, 0),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 0, 0),
                            border: Border.all(
                              color: Color.fromARGB(205, 125, 122, 128),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(205, 0, 0, 0),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
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
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '${portfolio.org.orgName}',
                                      style: TextStyle(

                                        color: Colors.white70,

                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'No. of shares: ${portfolio.investmentDetails.noOfShares}',
                                      style: TextStyle(

                                        color: Colors.white70,

                                      ),
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
                                    color: Colors.teal,
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
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}

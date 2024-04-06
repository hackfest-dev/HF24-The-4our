import 'dart:convert';
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

  @override
  void initState() {
    super.initState();
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
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff252525),
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
          : ListView.builder(
              itemCount: userPortfolio.length,
              itemBuilder: (context, index) {
                Portfolio portfolio = userPortfolio[index];
                return ListTile(
                  title: Text(portfolio.farm.farmName ?? ''),
                  subtitle: Text(portfolio.farm.location ?? ''),
                  onTap: () {
                    // Handle farm item tap
                  },
                );
              },
            ),
    );
  }
}

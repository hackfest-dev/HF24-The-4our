import 'package:flutter/material.dart';

class PortfolioPage extends StatelessWidget {
  final Map<String, dynamic> portfolioData;

  PortfolioPage({required this.portfolioData});

  @override
  Widget build(BuildContext context) {
    final farm = portfolioData['farm'];
    final org = portfolioData['org'];
    final investmentDetails = portfolioData['investmentDetails'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Farm Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Farm Name: ${farm['farmName']}'),
            Text('Location: ${farm['Location']}'),
            Text('Energy Category: ${farm['energyCategory']}'),
            Text('Description: ${farm['description']}'),
            SizedBox(height: 20),
            Text(
              'Organization Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Organization Name: ${org['orgName']}'),
            Text('Permanent Address: ${org['permanentAddress']}'),
            Text('Description: ${org['description']}'),
            SizedBox(height: 20),
            Text(
              'Investment Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Number of Shares: ${investmentDetails['noOfShares']}'),
            Text('Share Price: ${investmentDetails['sharePrice']}'),
            Text('Transaction ID: ${investmentDetails['transactionID']}'),
            Text('Returns: ${investmentDetails['returns']}'),
            Text('Timestamp: ${investmentDetails['timestamp']}'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PortfolioPage(
      portfolioData: {
        "farm": {
          "news": [],
          "_id": "6609dff76f72e93bcdf07fe7",
          "farmName": "Farm1",
          "orgId": "bc03babf-6658-48a5-aa01-a130d729f2b2",
          "farmID": "871e7540-7bdf-48d9-b84b-8cb1bd1c9579",
          "Location": "Spain",
          "energyCategory": "Solar",
          "farmValuation": 11000000,
          "totalInvestors": 1,
          "numberOfShares": 1000,
          "availableShares": 998,
          "eachSharePrice": 5000,
          "govtSubsidy": 1000000,
          "orgInvestment": 5000000,
          "orgInvestmentPercent": 45.45454545454545,
          "expectedEnergyOutput": 100000,
          "energyUnit": "kWH",
          "description": "This is farm1. This is some info about it.",
          "govtEquityPercent": 9.090909090909092,
          "govtEnergyOutput": 9090.909090909092,
          "investorEquityPercent": 45.45454545454545,
          "investorEnergyOutput": 45454.545454545456,
          "energyPerShare": 40.90909090909091,
          "orgEnergyOutput": 4545454.545454545,
          "farmReady": false,
          "farmExpectedReadyDate": "2024-03-11T18:30:00.000Z",
          "expectedDateOfReturns": "2024-04-11T18:30:00.000Z",
          "__v": 0
        },
        "org": {
          "orgName": "Organisation4",
          "permanentAddress": "Plot number 293, ORF, Los Alamos",
          "description":
              "This is Organisation3. Here's some description for it."
        },
        "investmentDetails": {
          "noOfShares": 2,
          "sharePrice": 5000,
          "transactionID": "AKJFUOEBFER848NG84",
          "returns": 0,
          "timestamp": "2024-01-02T00:00:00.000Z"
        }
      },
    ),
  ));
}

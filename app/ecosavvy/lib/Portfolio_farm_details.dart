import 'package:ecosavvy/models.dart';
import 'package:flutter/material.dart';

class PortfolioFarmDetailsPage extends StatelessWidget {
  final Portfolio portfolio;

  PortfolioFarmDetailsPage({required this.portfolio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farm Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Farm Name: ${portfolio.farm.farmName ?? ''}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Organization: ${portfolio.org.orgName}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Location: ${portfolio.farm.location}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Energy Type: ${portfolio.farm.energyCategory}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Number of Shares: ${portfolio.investmentDetails.noOfShares}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Share Price: ${portfolio.investmentDetails.sharePrice}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Transaction ID: ${portfolio.investmentDetails.transactionID}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Returns: ${portfolio.investmentDetails.returns}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Timestamp: ${portfolio.investmentDetails.timestamp}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

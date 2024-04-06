import 'dart:convert';

import 'package:flutter/material.dart';

import 'FarmScreen.dart';
import 'fetchapi.dart';
import 'package:http/http.dart' as http;
import 'models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Organisation>> futureOrganisations;
  List<Organisation>? organisations; // Add this line

  @override
  void initState() {
    super.initState();
    futureOrganisations = fetchOrganisations()
      ..then((orgs) =>
          organisations = orgs); // Update the organisations list on fetch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        leading: const Icon(Icons.electric_bolt_rounded, size: 27),
        title: const Text(
          "EcoSavvy",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: const Icon(Icons.search_rounded, size: 27),
              onPressed: () {
                // Ensure organisations is not null before showing search
                if (organisations != null) {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      organisations:
                          organisations!, // Use the updated organisations list
                    ),
                  );
                }
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<List<Organisation>>(
        future: futureOrganisations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator(color: Colors.lightGreenAccent));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!
                    .map((org) => Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: OrganisationCard(organisation: org),
                        ))
                    .toList(),
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

class OrganisationCard extends StatelessWidget {
  final Organisation organisation;

  OrganisationCard({required this.organisation});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF1E1E1E),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(99, 75, 75, 75),
          border: Border.all(
            color: Color.fromARGB(205, 125, 122, 128),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(205, 157, 143, 172),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    organisation.name,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '# Farms : ${organisation.farms.length}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  organisation.desc,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: organisation.farms.length,
                  itemBuilder: (context, index) {
                    final farm = organisation.farms[index];
                    return GestureDetector(
                      onTap: () async {
                        // Fetch user's portfolio data for the selected farm

                        // Navigate to FarmScreen and pass the fetched portfolio data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FarmScreen(
                                  farm: farm,
                                  org: organisation,
                                  userPortfolio: [],
                                ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: 180,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(186, 162, 204, 98),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              elevation: 3,
                              shadowColor: Colors.lightGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              color: Color.fromARGB(131, 137, 166, 94),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        farm.name!,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Location: ${farm.location}",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Energy Form: ${farm.energytype}",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Function to fetch user's portfolio data for the selected farm
}
  class CustomSearchDelegate extends SearchDelegate {
  final List<Organisation> organisations;

  CustomSearchDelegate({required this.organisations});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = organisations
        .where((org) =>
            org.name.toLowerCase().contains(query.toLowerCase()) ||
            org.farms.any((farm) =>
                farm.name!.toLowerCase().contains(query.toLowerCase())))
        .toList();

    return ListView(
      children: results
          .map<Widget>((org) => ListTile(
                title: Text(org.name),
                subtitle: Text('Farms: ${org.farms.length}'),
                onTap: () {
                  // You can handle navigation or display detailed information here
                  print('Selected: ${org.name}');
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions logic is similar to results, but you might return a subset or simplified view
    return buildResults(context);
  }
}

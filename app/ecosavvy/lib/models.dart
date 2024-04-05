class Organisation {
  final String id;
  final String name;
  final List<Farm> farms;
  final String desc;
  final String email;
  final String permanentaddress;
  final int marketcap;
  Organisation({required this.id, required this.name, required this.farms, required this.desc, required this.email, required this.marketcap, required this.permanentaddress});

  factory Organisation.fromJson(Map<String, dynamic> json) {
    var farmsList = json['farms'] as List;
    List<Farm> farms = farmsList.map((i) => Farm.fromJson(i)).toList();
    return Organisation(
      id: json['orgID'],
      desc : json['description'],
      name: json['orgName'],
      email: json['email'],
      permanentaddress: json['permanentAddress'],
      marketcap : json['marketCap'],
      farms: farms,
    );
  }
}

class Farm {
  final String id;
  final String name;
  final String location;
  final String energytype;
  final int noofinvestors;
  Farm({required this.id, required this.name, required this.location, required this.energytype, required this.noofinvestors});

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
        id: json['farmID'],
        name: json['farmName'],
        location: json['Location'],
        energytype: json['energyCategory'],
        noofinvestors : json['totalInvestors']!
    );
  }
}


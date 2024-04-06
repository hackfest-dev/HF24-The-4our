class Organisation {
  final String id;
  final String name;
  final List<Farm> farms;
  final String desc;
  final String email;
  final String permanentaddress;
  final int marketcap;
  Organisation(
      {required this.id,
      required this.name,
      required this.farms,
      required this.desc,
      required this.email,
      required this.marketcap,
      required this.permanentaddress});

  factory Organisation.fromJson(Map<String, dynamic> json) {
    var farmsList = json['farms'] as List;
    List<Farm> farms = farmsList.map((i) => Farm.fromJson(i)).toList();
    return Organisation(
      id: json['orgID'],
      desc: json['description'],
      name: json['orgName'],
      email: json['email'],
      permanentaddress: json['permanentAddress'],
      marketcap: json['marketCap'],
      farms: farms,
    );
  }
}

class Farm {
  final String id;
  final String farmName;
  final String orgId;
  final String farmID;
  final String location;
  final String energyCategory;
  final int farmValuation;
  final int totalInvestors;
  final int numberOfShares;
  final int availableShares;
  final int eachSharePrice;
  final int govtSubsidy;
  final int orgInvestment;
  final double orgInvestmentPercent;
  final int expectedEnergyOutput;
  final String energyUnit;
  final String description;
  final double govtEquityPercent;
  final double govtEnergyOutput;
  final double investorEquityPercent;
  final double investorEnergyOutput;
  final double energyPerShare;
  final double orgEnergyOutput;
  final bool farmReady;
  final String farmExpectedReadyDate;
  final String expectedDateOfReturns;

  Farm({
    required this.id,
    required this.farmName,
    required this.orgId,
    required this.farmID,
    required this.location,
    required this.energyCategory,
    required this.farmValuation,
    required this.totalInvestors,
    required this.numberOfShares,
    required this.availableShares,
    required this.eachSharePrice,
    required this.govtSubsidy,
    required this.orgInvestment,
    required this.orgInvestmentPercent,
    required this.expectedEnergyOutput,
    required this.energyUnit,
    required this.description,
    required this.govtEquityPercent,
    required this.govtEnergyOutput,
    required this.investorEquityPercent,
    required this.investorEnergyOutput,
    required this.energyPerShare,
    required this.orgEnergyOutput,
    required this.farmReady,
    required this.farmExpectedReadyDate,
    required this.expectedDateOfReturns,
  });

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['_id'],
      farmName: json['farmName'],
      orgId: json['orgId'],
      farmID: json['farmID'],
      location: json['Location'],
      energyCategory: json['energyCategory'],
      farmValuation: json['farmValuation'],
      totalInvestors: json['totalInvestors'],
      numberOfShares: json['numberOfShares'],
      availableShares: json['availableShares'],
      eachSharePrice: json['eachSharePrice'],
      govtSubsidy: json['govtSubsidy'],
      orgInvestment: json['orgInvestment'],
      orgInvestmentPercent: json['orgInvestmentPercent'],
      expectedEnergyOutput: json['expectedEnergyOutput'],
      energyUnit: json['energyUnit'],
      description: json['description'],
      govtEquityPercent: json['govtEquityPercent'],
      govtEnergyOutput: json['govtEnergyOutput'],
      investorEquityPercent: json['investorEquityPercent'],
      investorEnergyOutput: json['investorEnergyOutput'],
      energyPerShare: json['energyPerShare'],
      orgEnergyOutput: json['orgEnergyOutput'],
      farmReady: json['farmReady'],
      farmExpectedReadyDate: json['farmExpectedReadyDate'],
      expectedDateOfReturns: json['expectedDateOfReturns'],
    );
  }
}

// Model class for time series data
class TimeSeriesData {
  final String time;
  final double value;

  TimeSeriesData(this.time, this.value);
}

class Portfolio {
  final Farm farm;
  final Organisation org;
  final InvestmentDetails investmentDetails;

  Portfolio({
    required this.farm,
    required this.org,
    required this.investmentDetails,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      farm: Farm.fromJson(json['farm']),
      org: Organisation.fromJson(json['org']),
      investmentDetails: InvestmentDetails.fromJson(json['investmentDetails']),
    );
  }
}

class InvestmentDetails {
  final int noOfShares;
  final int sharePrice;
  final String transactionID;
  final int returns;
  final String timestamp;

  InvestmentDetails({
    required this.noOfShares,
    required this.sharePrice,
    required this.transactionID,
    required this.returns,
    required this.timestamp,
  });

  factory InvestmentDetails.fromJson(Map<String, dynamic> json) {
    return InvestmentDetails(
      noOfShares: json['noOfShares'],
      sharePrice: json['sharePrice'],
      transactionID: json['transactionID'],
      returns: json['returns'],
      timestamp: json['timestamp'],
    );
  }
}

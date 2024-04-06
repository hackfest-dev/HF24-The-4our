class Organisation {
  final String id;
  final String name;
  final List<Farm> farms;
  final String desc;
  final String email;
  final String permanentaddress;
  final int marketcap;

  Organisation({
    required this.id,
    required this.name,
    required this.farms,
    required this.desc,
    required this.email,
    required this.permanentaddress,
    required this.marketcap,
  });

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
  final String name;
  final String location;
  final String energytype;
  final int noofinvestors;
  final int? farmValuation;
  final int totalInvestors;
  final int? numberOfShares;
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
    required this.name,
    required this.location,
    required this.energytype,
    required this.noofinvestors,
    this.farmValuation,
    required this.totalInvestors,
    this.numberOfShares,
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
      id: json['farmID'],
      name: json['farmName'],
      location: json['Location'],
      energytype: json['energyCategory'],
      noofinvestors: json['totalInvestors']!,
      farmValuation: json['farmValuation'],
      totalInvestors: json['totalInvestors'],
      numberOfShares: json['numberOfShares'],
      availableShares: json['availableShares'],
      eachSharePrice: json['eachSharePrice'],
      govtSubsidy: json['govtSubsidy'],
      orgInvestment: json['orgInvestment'],
      orgInvestmentPercent: (json['orgInvestmentPercent'] as num).toDouble(), // Cast to double
      expectedEnergyOutput: json['expectedEnergyOutput'],
      energyUnit: json['energyUnit'],
      description: json['description'],
      govtEquityPercent: (json['govtEquityPercent'] as num).toDouble(), // Cast to double
      govtEnergyOutput: (json['govtEnergyOutput'] as num).toDouble(), // Cast to double
      investorEquityPercent: (json['investorEquityPercent'] as num).toDouble(), // Cast to double
      investorEnergyOutput: (json['investorEnergyOutput'] as num).toDouble(), // Cast to double
      energyPerShare: (json['energyPerShare'] as num).toDouble(), // Cast to double
      orgEnergyOutput: (json['orgEnergyOutput'] as num).toDouble(), // Cast to double
      farmReady: json['farmReady'],
      farmExpectedReadyDate: json['farmExpectedReadyDate'],
      expectedDateOfReturns: json['expectedDateOfReturns'],
    );
  }
}


class OrganisationFarm {
  final String? farmName;
  final String? orgId;
  final String? farmID;
  final String? location;
  final String? energyCategory;
  final int? farmValuation;
  final int? totalInvestors;
  final int? numberOfShares;
  final int? availableShares;
  final int? eachSharePrice;
  final int? govtSubsidy;
  final int? orgInvestment;
  final double? orgInvestmentPercent;
  final int? expectedEnergyOutput;
  final String? energyUnit;
  final String? description;
  final double? govtEquityPercent;
  final double? govtEnergyOutput;
  final double? investorEquityPercent;
  final double? investorEnergyOutput;
  final double? energyPerShare;
  final double? orgEnergyOutput;
  final bool? farmReady;
  final String? farmExpectedReadyDate;
  final String? expectedDateOfReturns;

  OrganisationFarm({
    this.farmName,
    this.orgId,
    this.farmID,
    this.location,
    this.energyCategory,
    this.farmValuation,
    this.totalInvestors,
    this.numberOfShares,
    this.availableShares,
    this.eachSharePrice,
    this.govtSubsidy,
    this.orgInvestment,
    this.orgInvestmentPercent,
    this.expectedEnergyOutput,
    this.energyUnit,
    this.description,
    this.govtEquityPercent,
    this.govtEnergyOutput,
    this.investorEquityPercent,
    this.investorEnergyOutput,
    this.energyPerShare,
    this.orgEnergyOutput,
    this.farmReady,
    this.farmExpectedReadyDate,
    this.expectedDateOfReturns,
  });

  factory OrganisationFarm.fromJson(Map<String, dynamic> json) {
    return OrganisationFarm(
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
      orgInvestmentPercent: (json['orgInvestmentPercent'] is int) ? (json['orgInvestmentPercent'] as int).toDouble() : json['orgInvestmentPercent'],
      expectedEnergyOutput: json['expectedEnergyOutput'],
      energyUnit: json['energyUnit'],
      description: json['description'],
      govtEquityPercent: (json['govtEquityPercent'] is int) ? (json['govtEquityPercent'] as int).toDouble() : json['govtEquityPercent'],
      govtEnergyOutput: (json['govtEnergyOutput'] is int) ? (json['govtEnergyOutput'] as int).toDouble() : json['govtEnergyOutput'],
      investorEquityPercent: (json['investorEquityPercent'] is int) ? (json['investorEquityPercent'] as int).toDouble() : json['investorEquityPercent'],
      investorEnergyOutput: (json['investorEnergyOutput'] is int) ? (json['investorEnergyOutput'] as int).toDouble() : json['investorEnergyOutput'],
      energyPerShare: (json['energyPerShare'] is int) ? (json['energyPerShare'] as int).toDouble() : json['energyPerShare'],
      orgEnergyOutput: (json['orgEnergyOutput'] is int) ? (json['orgEnergyOutput'] as int).toDouble() : json['orgEnergyOutput'],
      farmReady: json['farmReady'],
      farmExpectedReadyDate: json['farmExpectedReadyDate'],
      expectedDateOfReturns: json['expectedDateOfReturns'],
    );
  }
}


class SimpleOrganisationFarm {
  final String? farmName;
  final String? location;

  SimpleOrganisationFarm({this.farmName, this.location});

  factory SimpleOrganisationFarm.fromJson(Map<String, dynamic> json) {
    return SimpleOrganisationFarm(
      farmName: json['farmName'],
      location: json['Location'],
    );
  }
}

class POrganisation {
  final String orgName;
  final String permanentAddress;
  final String description;

  POrganisation({
    required this.orgName,
    required this.permanentAddress,
    required this.description,
  });

  factory POrganisation.fromJson(Map<String, dynamic> json) {
    return POrganisation(
      orgName: json['orgName'],
      permanentAddress: json['permanentAddress'],
      description: json['description'],
    );
  }
}

// Model class for time series data
class TimeSeriesData {
  final String time;
  final double value;

  TimeSeriesData(this.time, this.value);
}

class InvestmentDetails {
  final int noOfShares;
  final int sharePrice;
  final String transactionID;
  final double returns;
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
      returns: json['returns'].toDouble(),
      timestamp: json['timestamp'],
    );
  }
}

class Portfolio {
  final OrganisationFarm farm;
  final POrganisation org;
  final InvestmentDetails investmentDetails;

  Portfolio({
    required this.farm,
    required this.org,
    required this.investmentDetails,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      farm: OrganisationFarm.fromJson(json['farm']),
      org: POrganisation.fromJson(json['org']),
      investmentDetails: InvestmentDetails.fromJson(json['investmentDetails']),
    );
  }
}

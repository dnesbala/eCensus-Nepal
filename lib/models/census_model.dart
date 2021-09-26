import 'dart:convert';

Census censusFromJson(String str) => Census.fromJson(json.decode(str));

String censusToJson(Census data) => json.encode(data.toJson());

class Census {
  Census({
    this.province,
    this.district,
    this.municipality,
    this.wardNo,
    this.tole,
    this.familyHeadName,
    this.familyHeadContact,
    this.ownHouse,
    this.baseHouseMade,
    this.householdFacilitiesEquipments,
    this.isDeathWithinPast12Months,
    this.noOfDeaths,
    this.deathPersons,
    this.isPersonAbroad,
    this.abroadPersons,
    this.individualDetail,
    this.collectedBy,
  });

  String? province;
  String? district;
  String? municipality;
  int? wardNo;
  String? tole;
  String? familyHeadName;
  int? familyHeadContact;
  String? ownHouse;
  String? baseHouseMade;
  List<String>? householdFacilitiesEquipments;
  bool? isDeathWithinPast12Months;
  int? noOfDeaths;
  List<dynamic>? deathPersons;
  String? isPersonAbroad;
  List<String>? abroadPersons;
  List<dynamic>? individualDetail;
  CollectedBy? collectedBy;

  factory Census.fromJson(Map<String, dynamic> json) => Census(
        province: json["province"],
        district: json["district"],
        municipality: json["municipality"],
        wardNo: json["wardNo"],
        tole: json["tole"],
        familyHeadName: json["familyHeadName"],
        familyHeadContact: json["familyHeadContact"],
        ownHouse: json["ownHouse"],
        baseHouseMade: json["baseHouseMade"],
        householdFacilitiesEquipments: List<String>.from(
            json["householdFacilitiesEquipments"].map((x) => x)),
        isDeathWithinPast12Months: json["isDeathWithinPast12Months"],
        noOfDeaths: json["noOfDeaths"],
        deathPersons: List<dynamic>.from(json["deathPersons"].map((x) => x)),
        isPersonAbroad: json["isPersonAbroad"],
        abroadPersons: List<String>.from(json["abroadPersons"].map((x) => x)),
        individualDetail:
            List<dynamic>.from(json["individualDetail"].map((x) => x)),
        collectedBy: CollectedBy.fromJson(json["collectedBy"]),
      );

  Map<String, dynamic> toJson() => {
        "province": province,
        "district": district,
        "municipality": municipality,
        "wardNo": wardNo,
        "tole": tole,
        "familyHeadName": familyHeadName,
        "familyHeadContact": familyHeadContact,
        "ownHouse": ownHouse,
        "baseHouseMade": baseHouseMade,
        "householdFacilitiesEquipments":
            List<dynamic>.from(householdFacilitiesEquipments!.map((x) => x)),
        "isDeathWithinPast12Months": isDeathWithinPast12Months,
        "noOfDeaths": noOfDeaths,
        "deathPersons": List<dynamic>.from(deathPersons!.map((x) => x)),
        "isPersonAbroad": isPersonAbroad,
        "abroadPersons": List<dynamic>.from(abroadPersons!.map((x) => x)),
        "individualDetail": List<dynamic>.from(individualDetail!.map((x) => x)),
        "collectedBy": collectedBy?.toJson(),
      };

  Census initial() {
    return Census(
      province: '',
      district: '',
      municipality: '',
      wardNo: 0,
      tole: '',
      familyHeadName: '',
      familyHeadContact: 0,
      ownHouse: '',
      baseHouseMade: '',
      householdFacilitiesEquipments: [],
      isDeathWithinPast12Months: false,
      noOfDeaths: 0,
      deathPersons: [],
      isPersonAbroad: '',
      abroadPersons: [],
      individualDetail: [],
      collectedBy: CollectedBy(email: '', name: '', password: ''),
    );
  }

  Census copyWith(
      {String? province,
      String? district,
      String? municipality,
      int? wardNo,
      String? tole,
      String? familyHeadName,
      int? familyHeadContact,
      String? ownHouse,
      String? baseHouseMade,
      List<String>? householdFacilitiesEquipments,
      bool? isDeathWithinPast12Months,
      int? noOfDeaths,
      List<dynamic>? deathPersons,
      String? isPersonAbroad,
      List<String>? abroadPersons,
      List<dynamic>? individualDetail,
      CollectedBy? collectedBy}) {
    return Census(
      province: province ?? this.province,
      district: district ?? this.district,
      municipality: municipality ?? this.municipality,
      wardNo: wardNo ?? this.wardNo,
      tole: tole ?? this.tole,
      familyHeadName: familyHeadName ?? this.familyHeadName,
      familyHeadContact: familyHeadContact ?? this.familyHeadContact,
      ownHouse: ownHouse ?? this.ownHouse,
      baseHouseMade: baseHouseMade ?? this.baseHouseMade,
      householdFacilitiesEquipments:
          householdFacilitiesEquipments ?? this.householdFacilitiesEquipments,
      isDeathWithinPast12Months:
          isDeathWithinPast12Months ?? this.isDeathWithinPast12Months,
      noOfDeaths: noOfDeaths ?? this.noOfDeaths,
      deathPersons: deathPersons ?? this.deathPersons,
      isPersonAbroad: isPersonAbroad ?? this.isPersonAbroad,
      abroadPersons: abroadPersons ?? this.abroadPersons,
      individualDetail: individualDetail ?? this.individualDetail,
      collectedBy: collectedBy ?? this.collectedBy,
    );
  }
}

class CollectedBy {
  CollectedBy({
    required this.email,
    required this.password,
    required this.name,
  });

  String email;
  String password;
  String name;

  factory CollectedBy.fromJson(Map<String, dynamic> json) => CollectedBy(
        email: json["email"],
        password: json["password"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
      };
}

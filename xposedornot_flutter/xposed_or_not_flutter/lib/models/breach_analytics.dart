// To parse this JSON data, do
//
//     final breachAnalytics = breachAnalyticsFromJson(jsonString);

import 'dart:convert';

BreachAnalytics breachAnalyticsFromJson(String str) =>
    BreachAnalytics.fromJson(json.decode(str));

String breachAnalyticsToJson(BreachAnalytics data) =>
    json.encode(data.toJson());

class BreachAnalytics {
  BreachMetrics breachMetrics;
  BreachesSummary breachesSummary;
  ExposedBreaches exposedBreaches;
  dynamic exposedPastes;
  dynamic pasteMetrics;
  PastesSummary pastesSummary;

  BreachAnalytics({
    required this.breachMetrics,
    required this.breachesSummary,
    required this.exposedBreaches,
    required this.exposedPastes,
    required this.pasteMetrics,
    required this.pastesSummary,
  });

  factory BreachAnalytics.fromJson(Map<String, dynamic> json) =>
      BreachAnalytics(
        breachMetrics: BreachMetrics.fromJson(json["BreachMetrics"]),
        breachesSummary: BreachesSummary.fromJson(json["BreachesSummary"]),
        exposedBreaches: ExposedBreaches.fromJson(json["ExposedBreaches"]),
        exposedPastes: json["ExposedPastes"],
        pasteMetrics: json["PasteMetrics"],
        pastesSummary: PastesSummary.fromJson(json["PastesSummary"]),
      );

  Map<String, dynamic> toJson() => {
        "BreachMetrics": breachMetrics.toJson(),
        "BreachesSummary": breachesSummary.toJson(),
        "ExposedBreaches": exposedBreaches.toJson(),
        "ExposedPastes": exposedPastes,
        "PasteMetrics": pasteMetrics,
        "PastesSummary": pastesSummary.toJson(),
      };
}

class BreachMetrics {
  List<dynamic> getDetails;
  List<List<List<dynamic>>> industry;
  List<PasswordsStrength> passwordsStrength;
  List<Risk> risk;
  List<XposedDatum> xposedData;
  List<Map<String, int>> yearwiseDetails;

  BreachMetrics({
    required this.getDetails,
    required this.industry,
    required this.passwordsStrength,
    required this.risk,
    required this.xposedData,
    required this.yearwiseDetails,
  });

  factory BreachMetrics.fromJson(Map<String, dynamic> json) => BreachMetrics(
        getDetails: List<dynamic>.from(json["get_details"].map((x) => x)),
        industry: List<List<List<dynamic>>>.from(json["industry"].map((x) =>
            List<List<dynamic>>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
        passwordsStrength: List<PasswordsStrength>.from(
            json["passwords_strength"]
                .map((x) => PasswordsStrength.fromJson(x))),
        risk: List<Risk>.from(json["risk"].map((x) => Risk.fromJson(x))),
        xposedData: List<XposedDatum>.from(
            json["xposed_data"].map((x) => XposedDatum.fromJson(x))),
        yearwiseDetails: List<Map<String, int>>.from(json["yearwise_details"]
            .map(
                (x) => Map.from(x).map((k, v) => MapEntry<String, int>(k, v)))),
      );

  Map<String, dynamic> toJson() => {
        "get_details": List<dynamic>.from(getDetails.map((x) => x)),
        "industry": List<dynamic>.from(industry.map((x) => List<dynamic>.from(
            x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
        "passwords_strength":
            List<dynamic>.from(passwordsStrength.map((x) => x.toJson())),
        "risk": List<dynamic>.from(risk.map((x) => x.toJson())),
        "xposed_data": List<dynamic>.from(xposedData.map((x) => x.toJson())),
        "yearwise_details": List<dynamic>.from(yearwiseDetails.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}

class PasswordsStrength {
  int easyToCrack;
  int plainText;
  int strongHash;
  int unknown;

  PasswordsStrength({
    required this.easyToCrack,
    required this.plainText,
    required this.strongHash,
    required this.unknown,
  });

  factory PasswordsStrength.fromJson(Map<String, dynamic> json) =>
      PasswordsStrength(
        easyToCrack: json["EasyToCrack"],
        plainText: json["PlainText"],
        strongHash: json["StrongHash"],
        unknown: json["Unknown"],
      );

  Map<String, dynamic> toJson() => {
        "EasyToCrack": easyToCrack,
        "PlainText": plainText,
        "StrongHash": strongHash,
        "Unknown": unknown,
      };
}

class Risk {
  String riskLabel;
  int riskScore;

  Risk({
    required this.riskLabel,
    required this.riskScore,
  });

  factory Risk.fromJson(Map<String, dynamic> json) => Risk(
        riskLabel: json["risk_label"],
        riskScore: json["risk_score"],
      );

  Map<String, dynamic> toJson() => {
        "risk_label": riskLabel,
        "risk_score": riskScore,
      };
}

class XposedDatum {
  List<XposedDatumChild> children;

  XposedDatum({
    required this.children,
  });

  factory XposedDatum.fromJson(Map<String, dynamic> json) => XposedDatum(
        children: List<XposedDatumChild>.from(
            json["children"].map((x) => XposedDatumChild.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class XposedDatumChild {
  List<ChildChild> children;
  String colname;
  String name;

  XposedDatumChild({
    required this.children,
    required this.colname,
    required this.name,
  });

  factory XposedDatumChild.fromJson(Map<String, dynamic> json) =>
      XposedDatumChild(
        children: List<ChildChild>.from(
            json["children"].map((x) => ChildChild.fromJson(x))),
        colname: json["colname"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "colname": colname,
        "name": name,
      };
}

class ChildChild {
  String colname;
  String group;
  String name;
  int value;

  ChildChild({
    required this.colname,
    required this.group,
    required this.name,
    required this.value,
  });

  factory ChildChild.fromJson(Map<String, dynamic> json) => ChildChild(
        colname: json["colname"],
        group: json["group"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "colname": colname,
        "group": group,
        "name": name,
        "value": value,
      };
}

class BreachesSummary {
  String site;

  BreachesSummary({
    required this.site,
  });

  factory BreachesSummary.fromJson(Map<String, dynamic> json) =>
      BreachesSummary(
        site: json["site"],
      );

  Map<String, dynamic> toJson() => {
        "site": site,
      };
}

class ExposedBreaches {
  List<BreachesDetail> breachesDetails;

  ExposedBreaches({
    required this.breachesDetails,
  });

  factory ExposedBreaches.fromJson(Map<String, dynamic> json) =>
      ExposedBreaches(
        breachesDetails: List<BreachesDetail>.from(
            json["breaches_details"].map((x) => BreachesDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "breaches_details":
            List<dynamic>.from(breachesDetails.map((x) => x.toJson())),
      };
}

class BreachesDetail {
  String breach;
  String details;
  String domain;
  String industry;
  String logo;
  String passwordRisk;
  String references;
  String searchable;
  String verified;
  String xposedData;
  String xposedDate;
  int xposedRecords;

  BreachesDetail({
    required this.breach,
    required this.details,
    required this.domain,
    required this.industry,
    required this.logo,
    required this.passwordRisk,
    required this.references,
    required this.searchable,
    required this.verified,
    required this.xposedData,
    required this.xposedDate,
    required this.xposedRecords,
  });

  factory BreachesDetail.fromJson(Map<String, dynamic> json) => BreachesDetail(
        breach: json["breach"],
        details: json["details"],
        domain: json["domain"],
        industry: json["industry"],
        logo: json["logo"],
        passwordRisk: json["password_risk"],
        references: json["references"],
        searchable: json["searchable"],
        verified: json["verified"],
        xposedData: json["xposed_data"],
        xposedDate: json["xposed_date"],
        xposedRecords: json["xposed_records"],
      );

  Map<String, dynamic> toJson() => {
        "breach": breach,
        "details": details,
        "domain": domain,
        "industry": industry,
        "logo": logo,
        "password_risk": passwordRisk,
        "references": references,
        "searchable": searchable,
        "verified": verified,
        "xposed_data": xposedData,
        "xposed_date": xposedDate,
        "xposed_records": xposedRecords,
      };
}

class PastesSummary {
  int cnt;
  String domain;
  String tmpstmp;

  PastesSummary({
    required this.cnt,
    required this.domain,
    required this.tmpstmp,
  });

  factory PastesSummary.fromJson(Map<String, dynamic> json) => PastesSummary(
        cnt: json["cnt"],
        domain: json["domain"],
        tmpstmp: json["tmpstmp"],
      );

  Map<String, dynamic> toJson() => {
        "cnt": cnt,
        "domain": domain,
        "tmpstmp": tmpstmp,
      };
}

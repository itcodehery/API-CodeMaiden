// To parse this JSON data, do
//
//     final breachedSites = breachedSitesFromJson(jsonString);

import 'dart:convert';

BreachedSites breachedSitesFromJson(String str) =>
    BreachedSites.fromJson(json.decode(str));

String breachedSitesToJson(BreachedSites data) => json.encode(data.toJson());

class BreachedSites {
  List<List<String>> breaches;

  BreachedSites({
    required this.breaches,
  });

  factory BreachedSites.fromJson(Map<String, dynamic> json) => BreachedSites(
        breaches: List<List<String>>.from(
            json["breaches"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "breaches": List<dynamic>.from(
            breaches.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

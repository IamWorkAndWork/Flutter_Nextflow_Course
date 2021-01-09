// To parse this JSON data, do
//
//     final covidTodayResponse = covidTodayResponseFromJson(jsonString);

import 'dart:convert';

CovidTodayResponse covidTodayResponseFromJson(String str) =>
    CovidTodayResponse.fromJson(json.decode(str));

String covidTodayResponseToJson(CovidTodayResponse data) =>
    json.encode(data.toJson());

class CovidTodayResponse {
  CovidTodayResponse({
    this.confirmed,
    this.recovered,
    this.hospitalized,
    this.deaths,
    this.newConfirmed,
    this.newRecovered,
    this.newHospitalized,
    this.newDeaths,
    this.updateDate,
    this.source,
    this.devBy,
    this.severBy,
  });

  int confirmed;
  int recovered;
  int hospitalized;
  int deaths;
  int newConfirmed;
  int newRecovered;
  int newHospitalized;
  int newDeaths;
  String updateDate;
  String source;
  String devBy;
  String severBy;

  factory CovidTodayResponse.fromJson(Map<String, dynamic> json) =>
      CovidTodayResponse(
        confirmed: json["Confirmed"] == null ? null : json["Confirmed"],
        recovered: json["Recovered"] == null ? null : json["Recovered"],
        hospitalized:
            json["Hospitalized"] == null ? null : json["Hospitalized"],
        deaths: json["Deaths"] == null ? null : json["Deaths"],
        newConfirmed:
            json["NewConfirmed"] == null ? null : json["NewConfirmed"],
        newRecovered:
            json["NewRecovered"] == null ? null : json["NewRecovered"],
        newHospitalized:
            json["NewHospitalized"] == null ? null : json["NewHospitalized"],
        newDeaths: json["NewDeaths"] == null ? null : json["NewDeaths"],
        updateDate: json["UpdateDate"] == null ? null : json["UpdateDate"],
        source: json["Source"] == null ? null : json["Source"],
        devBy: json["DevBy"] == null ? null : json["DevBy"],
        severBy: json["SeverBy"] == null ? null : json["SeverBy"],
      );

  Map<String, dynamic> toJson() => {
        "Confirmed": confirmed == null ? null : confirmed,
        "Recovered": recovered == null ? null : recovered,
        "Hospitalized": hospitalized == null ? null : hospitalized,
        "Deaths": deaths == null ? null : deaths,
        "NewConfirmed": newConfirmed == null ? null : newConfirmed,
        "NewRecovered": newRecovered == null ? null : newRecovered,
        "NewHospitalized": newHospitalized == null ? null : newHospitalized,
        "NewDeaths": newDeaths == null ? null : newDeaths,
        "UpdateDate": updateDate == null ? null : updateDate,
        "Source": source == null ? null : source,
        "DevBy": devBy == null ? null : devBy,
        "SeverBy": severBy == null ? null : severBy,
      };
}

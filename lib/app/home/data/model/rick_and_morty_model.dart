import 'dart:convert';

import '../../domain/entity/rick_and_morty.dart';

RickAndMortyModel rickAndMortyModelFromJson(String str) =>
    RickAndMortyModel.fromJson(json.decode(str));

String rickAndMortyModelToJson(RickAndMortyModel data) =>
    json.encode(data.toJson());

class RickAndMortyModel extends RickAndMorty {
  RickAndMortyModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  }) : super(
          id: id,
          name: name,
          species: species,
          status: status,
        );

  final String id;
  final String name;
  final String status;
  final String species;
  String? type;
  String? gender;
  Location? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  factory RickAndMortyModel.fromJson(Map<String, dynamic> json) =>
      RickAndMortyModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin:
            json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null
            ? null
            : List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": image,
        "episode": episode,
        "url": url,
        "created": created,
      };
}

class Location {
  Location({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.created,
  });

  String? id;
  String? name;
  String? type;
  String? dimension;
  DateTime? created;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "created": created?.toIso8601String(),
      };
}

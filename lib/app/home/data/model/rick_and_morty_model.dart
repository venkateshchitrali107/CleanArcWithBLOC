import 'dart:convert';

import '../../domain/entity/rick_and_morty.dart';

RickAndMortyModel rickAndMortyModelFromJson(String str) =>
    RickAndMortyModel.fromJson(json.decode(str));

String rickAndMortyModelToJson(RickAndMortyModel data) =>
    json.encode(data.toJson());

// ignore: must_be_immutable
class RickAndMortyModel extends RickAndMorty {
  RickAndMortyModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    this.type,
    this.gender,
    this.image,
    this.created,
  }) : super(
          id: id,
          name: name,
          species: species,
          status: status,
        );

  @override
  // ignore: overridden_fields
  final String id;
  @override
  // ignore: overridden_fields
  final String name;
  @override
  // ignore: overridden_fields
  final String status;
  @override
  // ignore: overridden_fields
  final String species;
  String? type;
  String? gender;
  String? image;
  DateTime? created;

  factory RickAndMortyModel.fromJson(Map<String, dynamic> json) =>
      RickAndMortyModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        image: json["image"],
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
        "image": image,
        "created": created,
      };
}

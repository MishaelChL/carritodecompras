// To parse this JSON data, do
//
//     final galeria = galeriaFromJson(jsonString);

import 'dart:convert';
import 'package:carritodecomprasdefrutas/model/galeria.dart';

FetchRespondGaleria galeriaFromJson(String str) => FetchRespondGaleria.fromJson(json.decode(str));

String galeriaToJson(FetchRespondGaleria data) => json.encode(data.toJson());

class FetchRespondGaleria {
    FetchRespondGaleria({
        this.data,
    });

    List<Galeria> data;

    factory FetchRespondGaleria.fromJson(Map<String, dynamic> json) => FetchRespondGaleria(
        data: List<Galeria>.from(json["data"].map((x) => Galeria.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}



import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  String answer;

  ResponseModel({
    required this.answer,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "answer": answer,
  };
}

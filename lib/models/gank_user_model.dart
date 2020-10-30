import 'package:gank_global_test/models/message_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'gank_user_model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class GankUserModel {
  final String name;
  final String uid;
  @JsonKey(fromJson: timeStampToDateFromJson, toJson: dateTimeToTimeStampToJson)
  final DateTime lastLogin;

  GankUserModel({
    this.name,
    this.uid,
    this.lastLogin,
  });

  factory GankUserModel.fromJson(Map<String, dynamic> json) =>
      _$GankUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$GankUserModelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'gank_user_model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class GankUserModel {
  final String name;
  final String uid;

  GankUserModel({
    this.name,
    this.uid,
  });

  factory GankUserModel.fromJson(Map<String, dynamic> json) =>
      _$GankUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$GankUserModelToJson(this);
}

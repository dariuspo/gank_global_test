// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gank_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GankUserModel _$GankUserModelFromJson(Map json) {
  return GankUserModel(
    name: json['name'] as String,
    uid: json['uid'] as String,
    lastLogin: timeStampToDateFromJson(json['lastLogin'] as Timestamp),
  );
}

Map<String, dynamic> _$GankUserModelToJson(GankUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'lastLogin': dateTimeToTimeStampToJson(instance.lastLogin),
    };

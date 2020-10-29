// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallModel _$CallModelFromJson(Map json) {
  return CallModel(
    callerId: json['callerId'] as String,
    callerName: json['callerName'] as String,
    receiverId: json['receiverId'] as String,
    receiverName: json['receiverName'] as String,
    channelId: json['channelId'] as String,
    hasDialled: json['hasDialled'] as bool,
  );
}

Map<String, dynamic> _$CallModelToJson(CallModel instance) => <String, dynamic>{
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'receiverId': instance.receiverId,
      'receiverName': instance.receiverName,
      'channelId': instance.channelId,
      'hasDialled': instance.hasDialled,
    };

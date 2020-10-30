import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class MessageModel {
  final String message;
  final String fromUid;
  @JsonKey(fromJson: timeStampToDateFromJson, toJson: dateTimeToTimeStampToJson)
  final DateTime dateTime;
  final String channelId;

  MessageModel({
    this.message,
    this.fromUid,
    this.dateTime,
    this.channelId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

DateTime timeStampToDateFromJson(Timestamp timestamp) {
  if (timestamp == null) return null;
  return DateTime.fromMillisecondsSinceEpoch(timestamp?.millisecondsSinceEpoch);
}

Timestamp dateTimeToTimeStampToJson(DateTime time) {
  if (time == null) return null;
  return Timestamp.fromDate(time);
}

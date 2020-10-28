// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cocktails_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CocktailsModel _$CocktailsModelFromJson(Map json) {
  return CocktailsModel(
    drinks: (json['drinks'] as List)
        ?.map((e) => e == null
            ? null
            : CocktailModel.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
  );
}

Map<String, dynamic> _$CocktailsModelToJson(CocktailsModel instance) =>
    <String, dynamic>{
      'drinks': instance.drinks?.map((e) => e?.toJson())?.toList(),
    };

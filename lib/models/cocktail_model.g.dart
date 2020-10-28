// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cocktail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CocktailModel _$CocktailModelFromJson(Map json) {
  return CocktailModel(
    idDrink: json['idDrink'] as String,
    strDrinkThumb: json['strDrinkThumb'] as String,
    strDrink: json['strDrink'] as String,
    strCategory: json['strCategory'] as String,
  );
}

Map<String, dynamic> _$CocktailModelToJson(CocktailModel instance) =>
    <String, dynamic>{
      'idDrink': instance.idDrink,
      'strDrinkThumb': instance.strDrinkThumb,
      'strDrink': instance.strDrink,
      'strCategory': instance.strCategory,
    };

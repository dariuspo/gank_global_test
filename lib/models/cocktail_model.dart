import 'package:json_annotation/json_annotation.dart';

part 'cocktail_model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class CocktailModel {
  final String idDrink;
  final String strDrinkThumb;
  final String strDrink;
  final String strCategory;

  CocktailModel({
    this.idDrink,
    this.strDrinkThumb,
    this.strDrink,
    this.strCategory,
  });

  factory CocktailModel.fromJson(Map<String, dynamic> json) =>
      _$CocktailModelFromJson(json);

  Map<String, dynamic> toJson() => _$CocktailModelToJson(this);
}

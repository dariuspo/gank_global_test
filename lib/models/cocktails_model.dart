import 'package:gank_global_test/models/cocktail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cocktails_model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class CocktailsModel {
  List<CocktailModel> drinks;

  CocktailsModel({
    this.drinks,
  });

  factory CocktailsModel.fromJson(Map<String, dynamic> json) =>
      _$CocktailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CocktailsModelToJson(this);
}

import 'dart:convert';
import 'package:gank_global_test/apis/cocktail_api.dart';
import 'package:gank_global_test/models/cocktail_model.dart';
import 'package:gank_global_test/models/cocktails_model.dart';

class CocktailRepository {
  List<CocktailModel> cocktails = [];

  //fetch cocktail from rest API
  Future<List<CocktailModel>> fetchCocktails() async {
    final response = await CocktailApi.fetchCocktails();
    cocktails = CocktailsModel.fromJson(jsonDecode(response.body)).drinks;
    return cocktails;
  }
}

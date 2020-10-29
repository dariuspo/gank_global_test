import 'package:http/http.dart' as http;

class CocktailApi {
  static String baseURL = "https://www.thecocktaildb.com/api/json/v1/1";

  static String allCocktailList = "$baseURL/search.php?s=";

  static Future<http.Response> fetchCocktails() async {
    return await http.get(
      allCocktailList,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        'Accept': 'application/json',
      },
    );
  }
}

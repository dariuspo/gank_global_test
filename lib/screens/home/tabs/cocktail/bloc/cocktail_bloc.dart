import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gank_global_test/screens/home/tabs/cocktail/bloc/cocktail_bloc_components.dart';

class CocktailBloc extends Bloc<CocktailEvent, CocktailState> {
  final CocktailRepository _cocktailRepository;

  CocktailBloc({
    @required CocktailRepository cocktailRepository,
    CocktailState initialState,
  })  : assert(cocktailRepository != null),
        _cocktailRepository = cocktailRepository,
        super(initialState ?? CocktailInitial());

  @override
  Stream<CocktailState> mapEventToState(
    CocktailEvent event,
  ) async* {
    if (event is FetchCocktails) {
      try {
        final cocktails = await _cocktailRepository.fetchCocktails();
        yield CocktailLoaded(cocktails: cocktails);
      } catch (_) {
        yield CocktailError();
      }
    }
  }
}

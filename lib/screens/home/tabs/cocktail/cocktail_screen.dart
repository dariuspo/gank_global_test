import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_global_test/screens/home/tabs/cocktail/cocktail_list.dart';

import 'bloc/bloc.dart';

class CocktailScreen extends StatelessWidget {
  final BuildContext context;

  CocktailScreen(this.context);

  @override
  Widget build(BuildContext context) {
    CocktailRepository cocktailRepository =
        context.repository<CocktailRepository>();

    return BlocProvider<CocktailBloc>(
      create: (context) => CocktailBloc(
          cocktailRepository: cocktailRepository,
          initialState: cocktailRepository.cocktails.isNotEmpty
              ? CocktailLoaded(cocktails: cocktailRepository.cocktails)
              : null)
        ..add(cocktailRepository.cocktails.isNotEmpty
            ? CocktailsHaveData()
            : FetchCocktails()),
      child: CocktailList(this.context),
    );
  }
}

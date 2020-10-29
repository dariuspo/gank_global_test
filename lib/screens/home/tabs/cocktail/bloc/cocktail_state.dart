import 'package:equatable/equatable.dart';
import 'package:gank_global_test/models/cocktail_model.dart';

abstract class CocktailState extends Equatable {
  const CocktailState();

  @override
  List<Object> get props => [];
}

class CocktailInitial extends CocktailState {}

class CocktailLoading extends CocktailState {}

class CocktailError extends CocktailState {}

class CocktailLoaded extends CocktailState {
  final List<CocktailModel> cocktails;

  const CocktailLoaded({
    this.cocktails,
  });

  CocktailLoaded copyWith({List<CocktailModel> cocktails}) {
    return CocktailLoaded(
      cocktails: cocktails ?? this.cocktails,
    );
  }

  @override
  List<Object> get props => [cocktails];

  @override
  String toString() => 'GameLoaded { games: $cocktails }';
}


import 'package:equatable/equatable.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameError extends GameState {}

class GameLoaded extends GameState {
  final List<GameModel> games;
  final List<DeviceModel> devices;

  const GameLoaded({
    this.games,
    this.devices
  });

  GameLoaded copyWith({
    List<GameModel> games
  }) {
    return GameLoaded(
      games: games ?? this.games,
      devices: devices ?? this.devices,
    );
  }

  @override
  List<Object> get props => [games];

  @override
  String toString() => 'GameLoaded { games: $games }';
}

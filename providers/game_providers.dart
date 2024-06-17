import 'exports_providers.dart';

final gameLogicProvider = StateNotifierProvider<GameLogicNotifier, GameLogic>(
  (ref) => GameLogicNotifier(),
);

final gameListProvider = StateNotifierProvider<GameListNotifier, List<HangmanModel>>(
  (ref) => GameListNotifier(),
);
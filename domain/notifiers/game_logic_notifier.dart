import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hangman/core/data/repositories/game_repository.dart';
import 'package:hangman/core/domain/entities/game_logic.dart';

class GameLogicNotifier extends StateNotifier<GameLogic> {
  final _repository = GameRepository.instance;

  GameLogicNotifier()
      : super(GameLogic(
          attempts: 6,
          obtainedWord: 'HOLA',
          selectedLetters: [],
          viewKeyboard: true, 
        ));

  Future<void> getWordRandom() async {
    final obtainedWord = await _repository.getWordRandom();
    state = state.copyWith(obtainedWord: obtainedWord ?? 'NUEVAPALABRA');
  }

  void selectLetter(String letter) {
    if (!state.selectedLetters.contains(letter)) {
      final newWordsSelected = [...state.selectedLetters, letter];
      final attempts = state.obtainedWord.contains(letter) ? state.attempts : state.attempts - 1;

      state = state.copyWith(
        selectedLetters: newWordsSelected,
        attempts: attempts,
      );
    }
  }

  void resetGame() async {
    await getWordRandom();
    state = state.copyWith(
      attempts: 6,
      selectedLetters: [],
      gameLost: false,
      gameEnded: false,
      viewKeyboard: true, 
    );
  }
}
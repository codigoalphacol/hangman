import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hangman/core/data/models/hangman_model.dart';
import 'package:hangman/core/data/repositories/game_repository.dart';

class GameListNotifier extends StateNotifier<List<HangmanModel>> {
  GameListNotifier() : super([]);

  final _repository = GameRepository.instance;

  Future<void> loadWords() async {
    final games = await _repository.readAll();
    state = games;
  }

  Future<void> addGame(HangmanModel game) async {
    await _repository.create(game);
    loadWords();
  }

  Future<void> updateGame(HangmanModel game) async {
    await _repository.update(game);
    loadWords();
  }

  Future<void> deleteGame(String id) async {
    await _repository.delete(id);
    loadWords();
  }

  Future<List<String>> getAllWords() async {
    return await _repository.getAllWords();
  }
}

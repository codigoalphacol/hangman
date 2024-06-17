import 'package:hangman/core/domain/entities/game_entities.dart';

class HangmanModel extends GameEntities {
  HangmanModel({required super.id, required super.vocabulary});

  factory HangmanModel.fromMap(Map<String, dynamic> map) {
    return HangmanModel(
      id: map['id'] as String? ?? '1',
      vocabulary: map['vocabulary'] as String? ?? 'HOLA',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vocabulary': vocabulary,
    };
  }
}

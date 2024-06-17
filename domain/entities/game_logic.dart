class GameLogic {
  int attempts;
  bool gameLost;
  bool gameEnded;
  bool viewKeyboard;
  String obtainedWord;
  List<String> selectedLetters;

  GameLogic({
    required this.attempts,
    this.gameLost = false,
    this.gameEnded = false,
    this.viewKeyboard = false,
    required this.obtainedWord,
    required this.selectedLetters,
  });

  GameLogic copyWith({
    int? attempts,
    bool? gameLost,
    bool? gameEnded,
    bool? viewKeyboard,
    String? obtainedWord,
    List<String>? selectedLetters,
  }) {
    return GameLogic(
      attempts: attempts ?? this.attempts,
      gameLost: gameLost ?? this.gameLost,
      gameEnded: gameEnded ?? this.gameEnded,
      viewKeyboard: viewKeyboard ?? this.viewKeyboard,
      obtainedWord: obtainedWord ?? this.obtainedWord,
      selectedLetters: selectedLetters ?? this.selectedLetters,
    );
  }

  void checkIfGameLost() {
    if(attempts <=0) {
      gameLost = true;
      viewKeyboard = false;
    }
  }

  String showWord(){
    String hiddenWord = '';
    if (attempts == 0 ) {
      gameLost = true;
      hiddenWord = 'PERDIO EL JUEGO';
      viewKeyboard = !viewKeyboard;
    }
    if(!gameEnded){
      for(int i = 0; i < obtainedWord.length; i++){
        String word = obtainedWord[i];
        if(selectedLetters.contains(word)){
          hiddenWord += word;
        }else {
          hiddenWord += '_';          
        }
        hiddenWord += ' ';
      }
      if(!hiddenWord.contains('_')){
        gameEnded = true;
        hiddenWord = 'GANO EL JUEGO';
        viewKeyboard = !viewKeyboard;
      }
    }
    return hiddenWord;
  }
}

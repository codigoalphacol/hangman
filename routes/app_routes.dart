import 'package:go_router/go_router.dart';
import 'package:hangman/core/data/models/hangman_model.dart';
import 'package:hangman/core/presentation/crud_words/game_add_ui.dart';
import 'package:hangman/core/presentation/crud_words/game_edit_ui.dart';
import 'package:hangman/core/presentation/crud_words/game_list_ui.dart';
import 'package:hangman/core/presentation/game_ui/hangmand_game_ui.dart';

final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',         
          builder: (context, state) => const HangmandGameUi(),         
        ),
        GoRoute(
          path: '/list',         
          builder: (context, state) => const GameListUi(),         
        ),
        GoRoute(
          path: '/add',
          builder: (context, state) => const GameAddUi(),
        ),        
        GoRoute(
          path: '/edit',
          builder: (context, state) {
            final game = state.extra as HangmanModel;
            return GameEditUi(game: game);
          },
        ),
      ],
    );
    


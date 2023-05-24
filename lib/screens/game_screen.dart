import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_game/providers/room_data_provider.dart';
import 'package:tictactoe_game/resources/socket_methods.dart';
import 'package:tictactoe_game/views/score_board.dart';
import 'package:tictactoe_game/views/tictactoe_board.dart';
import 'package:tictactoe_game/views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: Center(
          child: roomDataProvider.roomData['isJoin']
              ? const WaitingLobby()
              : SafeArea(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [ScoreBoard(), TictactoeBoard()],
                ))),
    );
  }
}

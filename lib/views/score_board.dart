import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_game/providers/room_data_provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                roomDataProvider.player1.nickname,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: roomDataProvider.roomData['turn']['nickname'] ==
                            roomDataProvider.player1.nickname
                        ? Colors.red
                        : null),
              ),
              Text(
                roomDataProvider.player1.points.toInt().toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                roomDataProvider.player2.nickname,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: roomDataProvider.roomData['turn']['nickname'] ==
                            roomDataProvider.player2.nickname
                        ? Colors.red
                        : null),
              ),
              Text(
                roomDataProvider.player2.points.toInt().toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

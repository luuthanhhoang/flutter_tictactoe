import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/src/socket.dart';
import 'package:tictactoe_game/providers/room_data_provider.dart';
import 'package:tictactoe_game/resources/game_method.dart';
import 'package:tictactoe_game/resources/socket_client.dart';
import 'package:tictactoe_game/screens/game_screen.dart';
import 'package:tictactoe_game/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;
  Socket? get socketClient => _socketClient;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient!.emit('createRoom', {'nickname': nickname});
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient!.emit('joinRoom', {'nickname': nickname, 'roomId': roomId});
    }
  }

  void tabGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient!.emit('tap', {'index': index, 'roomId': roomId});
    }
  }

  //listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketClient!.on('createRoomSuccess', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient!.on('joinRoomSuccess', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccurredListener(BuildContext context) {
    _socketClient!.on('errorOccurred', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersListener(BuildContext context) {
    _socketClient!.on('updatePlayers', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(data[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(data[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient!.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient!.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);

      roomDataProvider.updateDisplayElement(data['index'], data['choice']);
      roomDataProvider.updateRoomData(data['room']);
      GameMethod().checkWinner(context, _socketClient!);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient!.on('pointIncrease', (data) {
      var roomData = Provider.of<RoomDataProvider>(context, listen: false);
      if (data['socketId'] == roomData.player1.socketId) {
        roomData.updatePlayer1(data);
      } else {
        roomData.updatePlayer2(data);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient!.on('endGame', (data) {
      showGameDialog(context, "${data['nickname']} won this game!");
      Navigator.popUntil(context, (route) => false);
    });
  }
}

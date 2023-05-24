import 'package:flutter/material.dart';
import 'package:tictactoe_game/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  final List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;

  PlayerModel _player1 = PlayerModel('', '', 0, 'X');
  PlayerModel _player2 = PlayerModel('', '', 0, 'O');

  Map<String, dynamic> get roomData => _roomData;
  PlayerModel get player1 => _player1;
  PlayerModel get player2 => _player2;
  List<String> get displayElements => _displayElements;
  int get filledBoxes => _filledBoxes;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = PlayerModel.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = PlayerModel.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElement(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes++;
    notifyListeners();
  }

  void setFilledBoxesTo0() {
    _filledBoxes = 0;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_game/providers/room_data_provider.dart';
import 'package:tictactoe_game/resources/socket_methods.dart';

class TictactoeBoard extends StatefulWidget {
  const TictactoeBoard({Key? key}) : super(key: key);

  @override
  _TictactoeBoardState createState() => _TictactoeBoardState();
}

class _TictactoeBoardState extends State<TictactoeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tabGrid(index, roomDataProvider.roomData['_id'],
        roomDataProvider.displayElements);
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketId'] !=
            _socketMethods.socketClient!.id,
        child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  tapped(index, roomDataProvider);
                },
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white24)),
                  child: Center(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        roomDataProvider.displayElements[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 100,
                            shadows: [
                              Shadow(
                                  blurRadius: 4,
                                  color:
                                      roomDataProvider.displayElements[index] ==
                                              'O'
                                          ? Colors.red
                                          : Colors.blue)
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

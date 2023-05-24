import 'package:flutter/material.dart';
import 'package:tictactoe_game/resources/socket_methods.dart';
import 'package:tictactoe_game/responsive/responsive.dart';
import 'package:tictactoe_game/widget/custom_button.dart';
import 'package:tictactoe_game/widget/custom_text.dart';
import 'package:tictactoe_game/widget/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccurredListener(context);
    _socketMethods.updatePlayersListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [Shadow(blurRadius: 40, color: Colors.blue)],
                fontSize: 70,
                text: 'Join room',
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextfield(
                  controller: _nameController, hintText: 'Enter your nickname'),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomTextfield(
                  controller: _gameIdController, hintText: 'Enter Game Id'),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                  onTap: () {
                    _socketMethods.joinRoom(
                        _nameController.text, _gameIdController.text);
                  },
                  text: 'Join')
            ],
          ),
        ),
      ),
    );
  }
}

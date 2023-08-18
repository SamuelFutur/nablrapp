import 'package:flutter/material.dart';
import 'package:nablr/src/common_widgets/text_widget.dart';

import '../constants/constants.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.msg, required this.chatIndex}) : super(key: key);
  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex== 0? scaffoldBackgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                chatIndex==0
                ?Image.asset("assets/logo/follower.png", height: 30,width:30)
                        :Image.asset("assets/logo/alien.png", height: 30,width:30),


                SizedBox(width:8),
                Expanded(
                    child: TextWidget(label:msg))
            ]
            ),
          ),
        )
      ],
    );
  }
}

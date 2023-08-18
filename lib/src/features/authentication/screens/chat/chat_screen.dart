import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import'package:nablr/src/features/authentication/models/ResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controllers/profile_controller.dart';
import '../../models/user_model.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController promptController;
  String responseTxt='';
  late ResponseModel _responseModel;
  late UserModel userData;
  final controller = Get.put(ProfileController());
  @override
  void initState(){
    promptController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    promptController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done ){
                if(snapshot.hasData){
                   userData = snapshot.data as UserModel;
                  return Scaffold(
                      resizeToAvoidBottomInset: true,
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        title: Text("NABLR-CHAT", style: TextStyle(color: Colors.black)),
                      ),
                      body: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PromptBldr(responseTxt: responseTxt),
                              TextFormFieldBldr(
                                  promptController: promptController, btnFun: completionFun, user: userData
                              ),
                            ]
                        ),
                      )
                  );
                }else if (snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()));
                }else {
                  return const Center(child:Text("Quelque chose ne s'est pas bien passé."));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }

            }
        );


  }



 completionFun() async {
    setState(() => responseTxt= 'Chargement...');
    final response= await http.post(
      Uri.parse('https://dualspace.azurewebsites.net/chat'),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "id":userData.id,
        "question": promptController.text,
      }),
    );

    setState(() {
      _responseModel= ResponseModel.fromJson(jsonDecode(response.body));
       responseTxt= _responseModel.answer;
    });
  }
}

class TextFormFieldBldr extends StatelessWidget {
  const TextFormFieldBldr({super.key,required this.user, required this.promptController, required this.btnFun});
  final TextEditingController promptController;
  final Function btnFun;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left:10, right:10, bottom: 50),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                cursorColor: Colors.grey,
                controller: promptController,
                autofocus: true,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,

                    ),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue
                    )
                  ),
                  filled: true,
                  fillColor: Colors.blue,
                  hintText: "J'attends votre question!",
                  hintStyle: const TextStyle(color: Colors.grey)
                )
              )
            ),
            Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  onPressed: () => btnFun(),
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}

class PromptBldr extends StatelessWidget {
  const PromptBldr({super.key, required this.responseTxt});
  final String responseTxt;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.35,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:  SizedBox(
            width: 300.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 20.0,
                fontFamily: 'Agne',
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(responseTxt),
                ],

              ),
            ),
          )
        )
      )
    );
  }
}



import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../controllers/profile_controller.dart';
import '../../models/user_model.dart';

class File extends StatefulWidget {
  const File({super.key});

  @override
  State<File> createState() => _FileState();
}

class _FileState extends State<File> {
  final _formKey = GlobalKey<FormState>();
  var text = "";
  final controller = Get.put(ProfileController());
  Future<String> convertSpeechToText(String filePath) async {
    const apiKey = "";
    var url = Uri.https("api.openai.com", "v1/audio/transcriptions");
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(({"Authorization": "Bearer $apiKey"}));
    request.fields["model"] = 'whisper-1';
    request.fields["language"] = "fr";
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    var response = await request.send();
    var newresponse = await http.Response.fromStream(response);
    final responseData = json.decode(newresponse.body);

    return responseData['text'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  late DocumentReference documentReference = FirebaseFirestore.instance.collection('User').doc(user.id);
                  late CollectionReference referenceConversation= documentReference.collection('Conversations');
                  final inter= TextEditingController(text: "Interlocuteur(s)");
                  final sujet= TextEditingController(text:"Sujet");
                  DateTime now = new DateTime.now();

                  return Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: ElevatedButton(
                                onPressed: () async {
                                  FilePickerResult? result = await FilePicker.platform
                                      .pickFiles();
                                  if (result != null) {
                                    //call openai's transcription api
                                    convertSpeechToText(result.files.single.path!)
                                        .then((value) {
                                      setState(() {
                                        text = value;
                                      });
                                    });
                                  }
                                },
                                child: Text(" Fichier "),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Transcription : " + text,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: inter,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.person_outline_outlined),
                                        labelText: "Interlocuteurs",
                                        hintText: "Interlocuteurs",
                                        border: OutlineInputBorder()),
                                  ),
                                  SizedBox(height: 10.0),
                                  TextFormField(
                                    controller: sujet,
                                    decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.person_outline_outlined),
                                              labelText: "Sujet",
                                              hintText: "Sujet",
                                              border: OutlineInputBorder()),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Map< String, String> conversToAdd = {
                                        "Conversations": text,
                                        "Interlocuteurs": inter.text.trim(),
                                        "Sujet": sujet.text.trim(),
                                        "Date": now.toString(),
                                      };
                                      referenceConversation.add(conversToAdd);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Envoyer".toUpperCase()),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black, // Background color
                                    ),
                                  )
                                ],
                              )
                          )


                        ],
                      ),
                    );

                } else if (snapshot.hasError){
                      return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child:Text("Quelque chose ne s'est pas bien passé."));
                }
              } else{
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

}

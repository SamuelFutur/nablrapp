import 'package:flutter/material.dart';
import 'package:nablr/src/features/authentication/screens/transcription/transcription_screen.dart';
import 'package:nablr/src/features/authentication/screens/file_transcription/file_transcription_screen.dart';

class Choice extends StatelessWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            SizedBox(width: 100 ,),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  AudioRecognize()),
              );
            }, child: Text("Streaming"), style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),),
            SizedBox(width: 20 ,),
            ElevatedButton(onPressed: (){ Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  File()),
            );}, child: Text("Fichier"), style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),)
          ],
        ),
      )
    );
  }
}

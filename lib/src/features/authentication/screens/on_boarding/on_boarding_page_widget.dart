import 'package:flutter/material.dart';

import '../../models/model_on_boarding.dart';


class OnBoardingPage extends StatelessWidget {


  const OnBoardingPage({
    Key? key,
    required this.model,
  }): super(key:key);

  final  OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: model.bgColor,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Image(image: AssetImage(model.image), height: model.height* 0.4),
          Column(
            children: [
              Text(model.title, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40),textAlign: TextAlign.center,),
              Text(model.subTitle, style:Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20), textAlign: TextAlign.center),
            ],
          ),
          Text(model.counterText, style: Theme.of(context).textTheme.headline6),
          SizedBox(height: 80.0,)
        ] ,
      ),

    );
  }
}

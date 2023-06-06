import 'package:flutter/material.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../component/component.dart';
import '../../network/local.dart';
import '../login/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  List<OnBoardingModel> onBoarding = [
    OnBoardingModel('Quick Delivery', 'body',
        'https://www.pngmart.com/files/11/Fashon-Shopping-PNG-Pic.png'),
    OnBoardingModel('Quick Delivery', 'body',
        'https://www.clipartmax.com/png/middle/260-2601318_shopping-fashion-girl-illustration-shopping-girl-png.png'),
    OnBoardingModel('Quick Delivery', 'body',
        'https://w7.pngwing.com/pngs/176/725/png-transparent-shopping-girl-shopping-woman-business-woman-people-coffee-shop.png'),
  ];
  var pageController = PageController();
  int currentPage =0;
  void submit(){
    CacheHelper.saveData(key:'onBoarding', value: true)!.then((value){
      if(value) {
        navigateReplacementTo(context: context,widget: LoginScreen());
       // print(value);
      }
    }).catchError((error){
      print(error);
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(onPressed: (){submit();}, text: 'SKIP')
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage=index;
                    });
                    if (index == onBoarding.length- 1) {
                      setState(() {
                        isLast = true;
                      });
                     // print(isLast);
                    } else {
                      isLast = false;
                    }
                  },
                  itemCount: onBoarding.length,
                  itemBuilder: (context, index) =>
                      onBoardingItem(onBoarding[index]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StepProgressIndicator(
                    totalSteps: onBoarding.length-1,
                    currentStep: currentPage,
                    size: 10,
                    padding: 0,
                    selectedColor: Colors.yellow,
                    unselectedColor: Colors.cyan,
                    roundedEdges: Radius.circular(10),
                    selectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.yellowAccent, Colors.deepOrange],
                    ),
                    unselectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.blue],
                    ),
                  ),                  FloatingActionButton(
                    child:isLast?Text('Start') :Text('Next'),
                    onPressed: () {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOutQuart);
                      if(isLast){
                        submit();
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}

Widget onBoardingItem(OnBoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 15,
      ),
      Text(
        model.title,
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 25,
      ),
      Text(model.body,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
      SizedBox(
        height: 40,
      ),
      Container(
        height: 450,
        child: Image(
          image: NetworkImage(model.image),
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}

class OnBoardingModel {
  final String title;
  final String body;
  final String image;

  OnBoardingModel(this.title, this.body, this.image);
}



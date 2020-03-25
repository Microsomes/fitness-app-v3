import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TutorialScreen

class TutorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  TextEditingController controller= new TextEditingController();

  bool isEmailAdded=false;
  //determines if email was added
  

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      initialPage: 4,
      pages: [
        PageViewModel(
          title: "Fitness Buddy",
          body:
              "Your personal fitness friend. Learn from me and let me help you workout",
          image: Align(
            child: Image.network(
              "https://tayyabprojects.info/fitnessicon/005-weight.png",
              width: 300,
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Interval Timer",
          body:
              "Create fitness timers, to workout to custom workouts. Set a duration, rest and work intervals and begin working out.",
          image: Align(
            child: Image.network(
                "https://tayyabprojects.info/fitnessicon/008-smartwatch.png",
                width: 250),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fitness Articles",
          body:
              "Read through, specially crafted curated Fitness Articles. We publish articles weekly!!!",
          image: Align(
            child: Image.network(
                "https://tayyabprojects.info/fitnessicon/023-yoga-mat.png",
                width: 300),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Dedicated Forum",
          body:
              "Forums to share fitness topics, ask questions and read reviews. We will also curate content from other popular sites such as bodybuilder.com",
          image: Align(
            child: Image.network(
                "https://tayyabprojects.info/fitnessicon/031-fitness-step.png",
                width: 300),
          ),
          footer: RaisedButton(
            onPressed: () {
              //introKey.currentState?.animateScroll(0);
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext b) {
                    return isEmailAdded==false ? Container(
                        height: 300,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Sign up for more info",
                                style: TextStyle(fontSize: 30),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: controller,
                                  decoration:
                                      InputDecoration(hintText: "email"),
                                ),
                              ),
                              MaterialButton(
                                color: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text("Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                onPressed: () {
                                  if(controller.text=="thanks for signing up"){
                                    print("already signed up");
                                    return;
                                  }else if(controller.text.length<=0){
                                    controller.text="please type an email";
                                    return;
                                  }
                                  print("add to db"+controller.text);
                                  Firestore.instance.collection("emaillist").add({
                                    "email":controller.text,
                                    "type":"dedicedforumn"
                                  }).then((done){
                                    setState(() { 
                                      isEmailAdded=true;
                                      //flag email as added
                                      controller.text="thanks for signing up";
                                      print(isEmailAdded);
                                    });
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Your email will only be used to give you more information about our new Forum section.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(222, 222, 222, 1)
                                  ),
                                ),
                              )
                            ],
                          ),
                        )):Container(
                          child: Center(child: Text("Thanks for signing up!"),),
                        );
                  });
            },
            child: const Text(
              'Sign Up for more info',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Good Luck!",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Lets get stuck in", style: bodyStyle),
           
            ],
          ),
          image: Align(
            child: Image.network(
                "https://tayyabprojects.info/fitnessicon/005-weight.png",
                width: 300),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Finish', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}

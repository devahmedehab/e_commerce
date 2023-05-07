import 'package:e_commerce/data/network/cache_helper.dart';
import 'package:e_commerce/presentation/resources/assets_manager.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: ImageAssets.onBoardingLogo1,
      title: AppStrings.onBoardingTitle1,
      body: AppStrings.onBoardingSubTitle1,
    ),
    BoardingModel(
      image: ImageAssets.onBoardingLogo2,
      title: AppStrings.onBoardingTitle2,
      body: AppStrings.onBoardingSubTitle2,
    ),
    BoardingModel(
      image: ImageAssets.onBoardingLogo3,
      title: AppStrings.onBoardingTitle3,
      body: AppStrings.onBoardingSubTitle3,
    ),
  ];
  bool isLast =false;

  void submit(){
    CacheHelper.saveData(key: AppStrings.onBoarding, value: true).then((value) {
      if(value){
       // navigateAndFinish(context, ShopLoginScreen(),);
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed:() {
              submit;
            },
            child:Text(AppStrings.skip),
          ),


        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p28),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller:  boardController,
                onPageChanged: (int index){
                  if(index == boarding.length - AppSize.s1)
                  {
                    setState(() {
                      isLast=true;
                    });
                  }else
                  {

                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics:  BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: AppSize.s40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    activeDotColor: ColorManager.primary,
                    dotColor: Colors.grey,
                    dotHeight: AppSize.s10,
                    expansionFactor:AppSize.s3,
                    dotWidth: AppSize.s10,
                    spacing: AppSize.s5,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    }else
                    {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: AppSize.s700,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}',),
            // fit: BoxFit.cover,
          ),
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}




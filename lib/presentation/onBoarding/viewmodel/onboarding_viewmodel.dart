import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

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
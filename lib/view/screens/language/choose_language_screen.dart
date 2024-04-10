import 'package:flutter/material.dart';
import 'package:resturant_delivery_boy/data/model/response/language_model.dart';
import 'package:resturant_delivery_boy/localization/language_constrants.dart';
import 'package:resturant_delivery_boy/provider/language_provider.dart';
import 'package:resturant_delivery_boy/provider/localization_provider.dart';
import 'package:resturant_delivery_boy/utill/app_constants.dart';
import 'package:resturant_delivery_boy/utill/dimensions.dart';
import 'package:resturant_delivery_boy/utill/images.dart';
import 'package:resturant_delivery_boy/view/base/custom_button.dart';
import 'package:resturant_delivery_boy/view/base/custom_snackbar.dart';
import 'package:resturant_delivery_boy/view/screens/auth/login_screen.dart';
import 'package:resturant_delivery_boy/view/screens/language/widget/search_widget.dart';
import 'package:provider/provider.dart';

class ChooseLanguageScreen extends StatelessWidget {
  final bool fromHomeScreen;

  const ChooseLanguageScreen({Key? key, this.fromHomeScreen = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context, listen: false).initializeAllLanguages(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall),
              child: Text(
                getTranslated('choose_the_language', context)!,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 22),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
              child: SearchWidget(),
            ),
            const SizedBox(height: 20),
            Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) => Expanded(
                    child: ListView.builder(
                        itemCount: languageProvider.languages.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => _languageWidget(
                            context: context, languageModel: languageProvider.languages[index], languageProvider: languageProvider, index: index)))),
            Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) => Padding(
                      padding: const EdgeInsets.only(
                          left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeLarge),
                      child: CustomButton(
                        btnTxt: getTranslated('save', context),
                        onTap: () {
                          if(languageProvider.languages.isNotEmpty && languageProvider.selectIndex != -1) {
                            Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                              AppConstants.languages[languageProvider.selectIndex!].languageCode!,
                              AppConstants.languages[languageProvider.selectIndex!].countryCode,
                            ));
                            if (fromHomeScreen) {
                              Navigator.pop(context);
                            } else {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
                            }
                          }else {
                            showCustomSnackBar(getTranslated('select_a_language', context)!);
                          }
                        },
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  Widget _languageWidget({required BuildContext context, required LanguageModel languageModel, required LanguageProvider languageProvider, int? index}) {
    return InkWell(
      onTap: () {
        languageProvider.changeSelectIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: languageProvider.selectIndex == index ? Theme.of(context).primaryColor.withOpacity(.15) : null,
          border: Border(
              top: BorderSide(
                  width: languageProvider.selectIndex == index ? 1.0 : 0.0,
                  color: languageProvider.selectIndex == index ? Theme.of(context).primaryColor : Colors.transparent),
              bottom: BorderSide(
                  width: languageProvider.selectIndex == index ? 1.0 : 0.0,
                  color: languageProvider.selectIndex == index ? Theme.of(context).primaryColor : Colors.transparent)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: languageProvider.selectIndex == index
                        ? Colors.transparent
                        : (languageProvider.selectIndex! - 1) == (index! - 1)
                            ? Colors.transparent
                            : Theme.of(context).dividerColor.withOpacity(.2))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(languageModel.imageUrl!, width: 34, height: 34),
                  const SizedBox(width: 30),
                  Text(
                    languageModel.languageName!,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ],
              ),
              languageProvider.selectIndex == index
                  ? Image.asset(
                      Images.done,
                      width: 17,
                      height: 17,
                      color: Theme.of(context).primaryColor,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

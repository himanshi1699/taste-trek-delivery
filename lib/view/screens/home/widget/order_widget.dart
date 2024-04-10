import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_delivery_boy/data/model/response/order_model.dart';
import 'package:resturant_delivery_boy/localization/language_constrants.dart';
import 'package:resturant_delivery_boy/provider/localization_provider.dart';
import 'package:resturant_delivery_boy/utill/dimensions.dart';
import 'package:resturant_delivery_boy/utill/images.dart';
import 'package:resturant_delivery_boy/utill/styles.dart';
import 'package:resturant_delivery_boy/view/base/custom_button.dart';
import 'package:resturant_delivery_boy/view/screens/order/order_details_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel? orderModel;
  final int index;
  const OrderWidget({Key? key, this.orderModel, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(.5), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    getTranslated('order_id', context)!,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  Text(
                    ' # ${orderModel!.id.toString()}',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ],
              ),
              Stack(
                clipBehavior: Clip.none, children: [
                  Container(),
                  Provider.of<LocalizationProvider>(context).isLtr
                      ? Positioned(
                          right: -10,
                          top: -23,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.fontSizeLarge, horizontal: Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.paddingSizeSmall),
                                    bottomLeft: Radius.circular(Dimensions.paddingSizeSmall))),
                            child: Text(
                              getTranslated('${orderModel!.orderStatus}', context)!,
                              style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                            ),
                          ),
                        )
                      : Positioned(
                          left: -10,
                          top: -28,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.fontSizeLarge, horizontal: Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.paddingSizeSmall),
                                    bottomLeft: Radius.circular(Dimensions.paddingSizeSmall))),
                            child: Text(
                              getTranslated('${orderModel!.orderStatus}', context)!,
                              style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                            ),
                          ),
                        )
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Image.asset(Images.location, color: Theme.of(context).textTheme.bodyLarge!.color, width: 15, height: 20),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                orderModel!.deliveryAddress != null ? orderModel!.deliveryAddress!.address! : 'Address not found',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
              )),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                btnTxt: getTranslated('view_details', context),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderModelItem: orderModel)));
                },
                isShowBorder: true,
              )),
              const SizedBox(width: 20),
              Expanded(
                  child: CustomButton(
                      btnTxt: getTranslated('direction', context),
                      onTap: () async {
                        String url ='https://www.google.com/maps/dir/?api=1&destination=${orderModel!.deliveryAddress!.latitude
                        },${orderModel!.deliveryAddress!.longitude}&mode=d';
                        if (await canLaunchUrlString(url)) {
                          await launchUrlString(url, mode: LaunchMode.externalApplication);
                        } else {
                          throw '${'could_not_launch'} $url';
                        }
                      })),
            ],
          ),
        ],
      ),
    );
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double destinationLatitude, double destinationLongitude, double userLatitude, double userLongitude) async {
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude'
        '&destination=$destinationLatitude,$destinationLongitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }
}

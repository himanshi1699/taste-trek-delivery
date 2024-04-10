import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:resturant_delivery_boy/data/model/response/order_model.dart';
import 'package:resturant_delivery_boy/localization/language_constrants.dart';
import 'package:resturant_delivery_boy/main.dart';
import 'package:resturant_delivery_boy/provider/order_provider.dart';
import 'package:resturant_delivery_boy/provider/profile_provider.dart';
import 'package:resturant_delivery_boy/provider/splash_provider.dart';
import 'package:resturant_delivery_boy/provider/tracker_provider.dart';
import 'package:resturant_delivery_boy/utill/dimensions.dart';
import 'package:resturant_delivery_boy/utill/images.dart';
import 'package:resturant_delivery_boy/view/screens/home/widget/order_widget.dart';
import 'package:resturant_delivery_boy/view/screens/language/choose_language_screen.dart';
import 'package:resturant_delivery_boy/view/screens/order/widget/permission_dialog.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getAllOrders(context);
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
    checkPermission(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        leadingWidth: 0,
        actions: [
          Consumer<OrderProvider>(
            builder: (context, orderProvider, child) {
              if(orderProvider.currentOrders.isNotEmpty) {
                for(OrderModel order in orderProvider.currentOrders) {
                  if(order.orderStatus == 'out_for_delivery') {
                    Provider.of<TrackerProvider>(context, listen: false).setOrderID(order.id!);
                    Provider.of<TrackerProvider>(context, listen: false).startLocationService();
                    break;
                  }
                }
              }
              return orderProvider.currentOrders.isNotEmpty
                  ? const SizedBox.shrink()
                  : IconButton(icon: Icon(Icons.refresh, color: Theme.of(context).textTheme.bodyLarge!.color),
                  onPressed: () {
                    orderProvider.refresh(context);
                  });
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'language':
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChooseLanguageScreen(fromHomeScreen: true)));
              }
            },
            icon: Icon(
              Icons.more_vert_outlined,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'language',
                child: Row(
                  children: [
                    Icon(Icons.language, color: Theme.of(context).textTheme.bodyLarge!.color),
                    const SizedBox(width: Dimensions.paddingSizeLarge),
                    Text(
                      getTranslated('change_language', context)!,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        leading: const SizedBox.shrink(),
        title: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) => profileProvider.userInfoModel != null
              ? Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholderUser, width: 40, height: 40, fit: BoxFit.fill,
                          image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.deliveryManImageUrl}/${profileProvider.userInfoModel!.image}',
                          imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholderUser, width: 40, height: 40, fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      profileProvider.userInfoModel!.fName != null
                          ? '${profileProvider.userInfoModel!.fName ?? ''} ${profileProvider.userInfoModel!.lName ?? ''}'
                          : "",
                      style:
                          Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color),
                    )
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: Consumer<OrderProvider>(
          builder: (context, orderProvider, child) => Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated('active_order', context)!, style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    )),
                    const SizedBox(height: 10),

                    Expanded(
                      child: RefreshIndicator(
                        key: _refreshIndicatorKey,
                        displacement: 0,
                        color: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        onRefresh: () {
                          return orderProvider.refresh(context);
                        },
                        child: orderProvider.currentOrders.isNotEmpty
                            ? orderProvider.currentOrders.isNotEmpty
                                ? ListView.builder(
                                    itemCount: orderProvider.currentOrders.length,
                                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                    itemBuilder: (context, index) => OrderWidget(
                                      orderModel: orderProvider.currentOrders[index],
                                      index: index,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      getTranslated('no_order_found', context)!,
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              )),
    );
  }

  static void checkPermission(BuildContext context, {Function? callBack}) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      showDialog(context: Get.context!, barrierDismissible: false, builder: (ctx) => PermissionDialog(isDenied: true, onPressed: () async {
        Navigator.pop(context);
        await Geolocator.requestPermission();
        if(callBack != null) {
          checkPermission(Get.context!, callBack: callBack);
        }

      }));
    }else if(permission == LocationPermission.deniedForever) {
      showDialog(context: Get.context!, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: false, onPressed: () async {
        Navigator.pop(context);
        await Geolocator.openAppSettings();
        if(callBack != null) {
          checkPermission(Get.context!, callBack: callBack);
        }

      }));
    }else if(callBack != null){
      callBack();
    }
  }


}

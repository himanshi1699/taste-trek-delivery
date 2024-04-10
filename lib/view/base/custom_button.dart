import 'package:flutter/material.dart';
import 'package:resturant_delivery_boy/utill/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String? btnTxt;
  final bool isShowBorder;

  const CustomButton({Key? key, this.onTap, required this.btnTxt, this.isShowBorder = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: !isShowBorder ? Colors.grey.withOpacity(0.2) : Colors.transparent, spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isShowBorder ? Theme.of(context).hintColor.withOpacity(0.5) : Colors.transparent),
          color: !isShowBorder ? Theme.of(context).primaryColor : Colors.transparent),
      child: TextButton(
        onPressed: onTap as void Function()?,
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Text(btnTxt ?? "",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: !isShowBorder ?  Colors.white : Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resturant_delivery_boy/provider/splash_provider.dart';

class DateConverter {
  static String formatDate(DateTime dateTime, BuildContext context, {bool isSecond = true}) {
    return isSecond
        ?  DateFormat('yyyy-MM-dd ${_timeFormatter(context)}:ss').format(dateTime) :
    DateFormat('yyyy-MM-dd ${_timeFormatter(context)}').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
  }

  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('h:mm a | d-MMM-yyyy ').format(dateTime.toLocal());
  }
  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm').format(isoStringToLocalDate(dateTime));
  }
  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  static String deliveryDateAndTimeToDate(String deliveryDate, String deliveryTime, BuildContext context) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(deliveryDate);
    DateTime time = DateFormat('HH:mm').parse(deliveryTime);
    return '${DateFormat('dd-MMM-yyyy').format(date)} ${DateFormat(_timeFormatter(context)).format(time)}';
  }

  static String _timeFormatter(BuildContext context) {
    return Provider.of<SplashProvider>(context, listen: false).configModel!.timeFormat == '24' ? 'HH:mm' : 'hh:mm a';
  }


}

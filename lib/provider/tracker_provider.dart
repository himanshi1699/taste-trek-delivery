// ignore_for_file: empty_catches

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resturant_delivery_boy/data/model/response/response_model.dart';
import 'package:resturant_delivery_boy/data/model/body/track_body.dart';
import 'package:resturant_delivery_boy/data/model/response/base/api_response.dart';
import 'package:resturant_delivery_boy/data/repository/tracker_repo.dart';
import 'package:resturant_delivery_boy/helper/api_checker.dart';

class TrackerProvider extends ChangeNotifier {
  final TrackerRepo? trackerRepo;
  TrackerProvider({required this.trackerRepo});

  final List<TrackBody> _trackList = [];
  final int _selectedTrackIndex = 0;
  final bool _isBlockButton = false;
  final bool _canDismiss = true;
  bool _startTrack = false;
  Timer? _timer;

  List<TrackBody> get trackList => _trackList;
  int get selectedTrackIndex => _selectedTrackIndex;
  bool get isBlockButton => _isBlockButton;
  bool get canDismiss => _canDismiss;
  bool get startTrack => _startTrack;

  void startLocationService() async {
    _startTrack = true;
    addTrack();
    if(_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      addTrack();
    });
  }

  void stopLocationService() {
    _startTrack = false;
    if(_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    notifyListeners();
  }

  Future<ResponseModel?> addTrack() async {
    ResponseModel? responseModel;
    if (_startTrack) {
      Geolocator.getCurrentPosition().then((location) async {
        String locationText = 'demo';
        try {
          List<Placemark> placeMark = await placemarkFromCoordinates(location.latitude, location.longitude);
          Placemark address = placeMark.first;
          locationText = '${address.name ?? ''}, ${address.subAdministrativeArea ?? ''}, ${address.isoCountryCode ?? ''}';
        }catch(e) {}
        ApiResponse apiResponse = await trackerRepo!.addTrack(location.latitude, location.longitude, locationText);
        if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
          responseModel = ResponseModel(true, 'Successfully start track');
        } else {
          responseModel = ResponseModel(false, ApiChecker.getError(apiResponse).errors![0].message);
        }
      });
    } else {
      _timer!.cancel();
    }
    notifyListeners();

    return responseModel;
  }

  Future<bool> setOrderID(int orderID) async {
    return await trackerRepo!.setOrderID(orderID);
  }
}

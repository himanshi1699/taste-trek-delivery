class ConfigModel {
  String? _restaurantName;
  String? _restaurantOpenTime;
  String? _restaurantCloseTime;
  String? _restaurantLogo;
  String? _restaurantAddress;
  String? _restaurantPhone;
  String? _restaurantEmail;
  BaseUrls? _baseUrls;
  String? _currencySymbol;
  double? _deliveryCharge;
  String? _cashOnDelivery;
  String? _digitalPayment;
  String? _termsAndConditions;
  String? _privacyPolicy;
  String? _aboutUs;
  bool? _emailVerification;
  bool? _phoneVerification;
  String? _currencySymbolPosition;
  bool? _maintenanceMode;
  String? _countryCode;
  bool? _selfPickup;
  bool? _homeDelivery;
  RestaurantLocationCoverage? _restaurantLocationCoverage;
  double? _minimumOrderValue;
  List<Branches>? _branches;
  DeliveryManagement? _deliveryManagement;
  int? _decimalPointSettings;
  String? _timeFormat;
  bool? _toggleDmRegistration;
  bool? _isVegNonVegActive;



  ConfigModel(
      {String? restaurantName,
        String? restaurantOpenTime,
        String? restaurantCloseTime,
        String? restaurantLogo,
        String? restaurantAddress,
        String? restaurantPhone,
        String? restaurantEmail,
        BaseUrls? baseUrls,
        String? currencySymbol,
        double? deliveryCharge,
        String? cashOnDelivery,
        String? digitalPayment,
        String? termsAndConditions,
        String? privacyPolicy,
        String? aboutUs,
        bool? emailVerification,
        bool? phoneVerification,
        String? currencySymbolPosition,
        bool? maintenanceMode,
        String? countryCode,
        RestaurantLocationCoverage? restaurantLocationCoverage,
        double? minimumOrderValue,
        List<Branches>? branches,
        bool? selfPickup,
        bool? homeDelivery,
        DeliveryManagement? deliveryManagement,
        int? decimalPointSettings,
        String? timeFormat,
        bool? toggleDmRegistration,
        bool? isVegNonVegActive,

      }) {
    _restaurantName = restaurantName;
    _restaurantOpenTime = restaurantOpenTime;
    _restaurantCloseTime = restaurantCloseTime;
    _restaurantLogo = restaurantLogo;
    _restaurantAddress = restaurantAddress;
    _restaurantPhone = restaurantPhone;
    _restaurantEmail = restaurantEmail;
    _baseUrls = baseUrls;
    _currencySymbol = currencySymbol;
    _deliveryCharge = deliveryCharge;
    _cashOnDelivery = cashOnDelivery;
    _digitalPayment = digitalPayment;
    _termsAndConditions = termsAndConditions;
    _aboutUs = aboutUs;
    _privacyPolicy = privacyPolicy;
    _restaurantLocationCoverage = restaurantLocationCoverage;
    _minimumOrderValue = minimumOrderValue;
    _branches = branches;
    _emailVerification = emailVerification;
    _phoneVerification = phoneVerification;
    _currencySymbolPosition = currencySymbolPosition;
    _maintenanceMode = maintenanceMode;
    _countryCode = countryCode;
    _selfPickup = selfPickup;
    _homeDelivery = homeDelivery;
    _deliveryManagement = deliveryManagement;
    _decimalPointSettings = decimalPointSettings;
    _timeFormat = timeFormat;
    _toggleDmRegistration = toggleDmRegistration;
    _isVegNonVegActive = isVegNonVegActive;

  }

  String? get restaurantName => _restaurantName;
  String? get restaurantOpenTime => _restaurantOpenTime;
  String? get restaurantCloseTime => _restaurantCloseTime;
  String? get restaurantLogo => _restaurantLogo;
  String? get restaurantAddress => _restaurantAddress;
  String? get restaurantPhone => _restaurantPhone;
  String? get restaurantEmail => _restaurantEmail;
  BaseUrls? get baseUrls => _baseUrls;
  String? get currencySymbol => _currencySymbol;
  double? get deliveryCharge => _deliveryCharge;
  String? get cashOnDelivery => _cashOnDelivery;
  String? get digitalPayment => _digitalPayment;
  String? get termsAndConditions => _termsAndConditions;
  String? get aboutUs=> _aboutUs;
  String? get privacyPolicy=> _privacyPolicy;
  RestaurantLocationCoverage? get restaurantLocationCoverage => _restaurantLocationCoverage;
  double? get minimumOrderValue => _minimumOrderValue;
  List<Branches>? get branches => _branches;
  bool? get emailVerification => _emailVerification;
  bool? get phoneVerification => _phoneVerification;
  String? get currencySymbolPosition => _currencySymbolPosition;
  bool? get maintenanceMode => _maintenanceMode;
  String? get countryCode => _countryCode;
  bool? get selfPickup => _selfPickup;
  bool? get homeDelivery => _homeDelivery;
  DeliveryManagement? get deliveryManagement => _deliveryManagement;
  int? get decimalPointSettings => _decimalPointSettings;
  String? get timeFormat => _timeFormat;
  bool? get toggleDmRegistration => _toggleDmRegistration;
  bool? get isVegNonVegActive => _isVegNonVegActive;


  ConfigModel.fromJson(Map<String, dynamic> json) {
    _restaurantName = json['restaurant_name'];
    _restaurantOpenTime = json['restaurant_open_time'];
    _restaurantCloseTime = json['restaurant_close_time'];
    _restaurantLogo = json['restaurant_logo'];
    _restaurantAddress = json['restaurant_address'];
    _restaurantPhone = json['restaurant_phone'];
    _restaurantEmail = json['restaurant_email'];
    _baseUrls = json['base_urls'] != null
        ? BaseUrls.fromJson(json['base_urls'])
        : null;
    _currencySymbol = json['currency_symbol'];
    _deliveryCharge = json['delivery_charge'].toDouble();
    _cashOnDelivery = json['cash_on_delivery'];
    _digitalPayment = json['digital_payment'];
    _termsAndConditions = json['terms_and_conditions'];
    _privacyPolicy = json['privacy_policy'];
    _aboutUs = json['about_us'];
    _emailVerification = json['email_verification'];
    _phoneVerification = json['phone_verification'];
    _currencySymbolPosition = json['currency_symbol_position'];
    _maintenanceMode = json['maintenance_mode'];
    _countryCode = json['country'];
    _selfPickup = json['self_pickup'];
    _homeDelivery = json['delivery'];
    _restaurantLocationCoverage = json['restaurant_location_coverage'] != null
        ? RestaurantLocationCoverage.fromJson(json['restaurant_location_coverage']) : null;
    _minimumOrderValue = json['minimum_order_value'] != null ? json['minimum_order_value'].toDouble() : 0;
    if (json['branches'] != null) {
      _branches = [];
      json['branches'].forEach((v) {
        _branches!.add(Branches.fromJson(v));
      });
    }
    _deliveryManagement = json['delivery_management'] != null
        ? DeliveryManagement.fromJson(json['delivery_management'])
        : null;
    _decimalPointSettings = json['decimal_point_settings'] ?? 1;
    _timeFormat =  json['time_format'];
    _toggleDmRegistration =  '${json['toggle_dm_registration']}'.contains('1');
    _isVegNonVegActive = '${json['is_veg_non_veg_active']}'.contains('1');

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['restaurant_name'] = _restaurantName;
    data['restaurant_open_time'] = _restaurantOpenTime;
    data['restaurant_close_time'] = _restaurantCloseTime;
    data['restaurant_logo'] = _restaurantLogo;
    data['restaurant_address'] = _restaurantAddress;
    data['restaurant_phone'] = _restaurantPhone;
    data['restaurant_email'] = _restaurantEmail;
    if (_baseUrls != null) {
      data['base_urls'] = _baseUrls!.toJson();
    }
    data['currency_symbol'] = _currencySymbol;
    data['delivery_charge'] = _deliveryCharge;
    data['cash_on_delivery'] = _cashOnDelivery;
    data['digital_payment'] = _digitalPayment;
    data['terms_and_conditions'] = _termsAndConditions;
    data['privacy_policy'] = privacyPolicy;
    data['about_us'] = aboutUs;
    data['email_verification'] = emailVerification;
    data['phone_verification'] = phoneVerification;
    data['currency_symbol_position'] = currencySymbolPosition;
    data['maintenance_mode'] = maintenanceMode;
    data['country'] = countryCode;
    data['self_pickup'] = selfPickup;
    data['delivery'] = homeDelivery;
    if (_restaurantLocationCoverage != null) {
      data['restaurant_location_coverage'] = _restaurantLocationCoverage!.toJson();
    }
    data['minimum_order_value'] = _minimumOrderValue;
    if (_branches != null) {
      data['branches'] = _branches!.map((v) => v.toJson()).toList();
    }
    if (_deliveryManagement != null) {
      data['delivery_management'] = _deliveryManagement!.toJson();
    }
    return data;
  }
}

class BaseUrls {
  String? _productImageUrl;
  String? _customerImageUrl;
  String? _bannerImageUrl;
  String? _categoryImageUrl;
  String? _reviewImageUrl;
  String? _notificationImageUrl;
  String? _restaurantImageUrl;
  String? _deliveryManImageUrl;
  String? _chatImageUrl;

  BaseUrls(
      {String? productImageUrl,
        String? customerImageUrl,
        String? bannerImageUrl,
        String? categoryImageUrl,
        String? reviewImageUrl,
        String? notificationImageUrl,
        String? restaurantImageUrl,
        String? deliveryManImageUrl,
        String? chatImageUrl}) {
    _productImageUrl = productImageUrl;
    _customerImageUrl = customerImageUrl;
    _bannerImageUrl = bannerImageUrl;
    _categoryImageUrl = categoryImageUrl;
    _reviewImageUrl = reviewImageUrl;
    _notificationImageUrl = notificationImageUrl;
    _restaurantImageUrl = restaurantImageUrl;
    _deliveryManImageUrl = deliveryManImageUrl;
    _chatImageUrl = chatImageUrl;
  }

  String? get productImageUrl => _productImageUrl;
  String? get customerImageUrl => _customerImageUrl;
  String? get bannerImageUrl => _bannerImageUrl;
  String? get categoryImageUrl => _categoryImageUrl;
  String? get reviewImageUrl => _reviewImageUrl;
  String? get notificationImageUrl => _notificationImageUrl;
  String? get restaurantImageUrl => _restaurantImageUrl;
  String? get deliveryManImageUrl => _deliveryManImageUrl;
  String? get chatImageUrl => _chatImageUrl;

  BaseUrls.fromJson(Map<String, dynamic> json) {
    _productImageUrl = json['product_image_url'];
    _customerImageUrl = json['customer_image_url'];
    _bannerImageUrl = json['banner_image_url'];
    _categoryImageUrl = json['category_image_url'];
    _reviewImageUrl = json['review_image_url'];
    _notificationImageUrl = json['notification_image_url'];
    _restaurantImageUrl = json['restaurant_image_url'];
    _deliveryManImageUrl = json['delivery_man_image_url'];
    _chatImageUrl = json['chat_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_image_url'] = _productImageUrl;
    data['customer_image_url'] = _customerImageUrl;
    data['banner_image_url'] = _bannerImageUrl;
    data['category_image_url'] = _categoryImageUrl;
    data['review_image_url'] = _reviewImageUrl;
    data['notification_image_url'] = _notificationImageUrl;
    data['restaurant_image_url'] = _restaurantImageUrl;
    data['delivery_man_image_url'] = _deliveryManImageUrl;
    data['chat_image_url'] = _chatImageUrl;
    return data;
  }
}

class RestaurantLocationCoverage {
  String? _longitude;
  String? _latitude;
  double? _coverage;

  RestaurantLocationCoverage(
      {String? longitude, String? latitude, double? coverage}) {
    _longitude = longitude;
    _latitude = latitude;
    _coverage = coverage;
  }

  String? get longitude => _longitude;
  String? get latitude => _latitude;
  double? get coverage => _coverage;

  RestaurantLocationCoverage.fromJson(Map<String, dynamic> json) {
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _coverage = json['coverage'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longitude'] = _longitude;
    data['latitude'] = _latitude;
    data['coverage'] = _coverage;
    return data;
  }
}

class Branches {
  int? _id;
  String? _name;
  String? _email;
  String? _longitude;
  String? _latitude;
  String? _address;
  double? _coverage;

  Branches(
      {int? id,
        String? name,
        String? email,
        String? longitude,
        String? latitude,
        String? address,
        double? coverage}) {
    _id = id;
    _name = name;
    _email = email;
    _longitude = longitude;
    _latitude = latitude;
    _address = address;
    _coverage = coverage;
  }

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get longitude => _longitude;
  String? get latitude => _latitude;
  String? get address => _address;
  double? get coverage => _coverage;

  Branches.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _address = json['address'];
    _coverage = json['coverage'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['email'] = _email;
    data['longitude'] = _longitude;
    data['latitude'] = _latitude;
    data['address'] = _address;
    data['coverage'] = _coverage;
    return data;
  }
}

class DeliveryManagement {
  int? _status;
  double? _minShippingCharge;
  double? _shippingPerKm;

  DeliveryManagement(
      {int? status, double? minShippingCharge, double? shippingPerKm}) {
    _status = status;
    _minShippingCharge = minShippingCharge;
    _shippingPerKm = shippingPerKm;
  }

  int? get status => _status;
  double? get minShippingCharge => _minShippingCharge;
  double? get shippingPerKm => _shippingPerKm;

  DeliveryManagement.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _minShippingCharge = json['min_shipping_charge'].toDouble();
    _shippingPerKm = json['shipping_per_km'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    data['min_shipping_charge'] = _minShippingCharge;
    data['shipping_per_km'] = _shippingPerKm;
    return data;
  }
}
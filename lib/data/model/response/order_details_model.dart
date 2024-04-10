

class OrderDetailsModel {
  int? _id;
  int? _productId;
  int? _orderId;
  double? _price;
  ProductDetails? _productDetails;
  List<OldVariation>? _oldVariations;
  List<Variation>? _variations;
  double? _discountOnProduct;
  String? _discountType;
  int? _quantity;
  double? _taxAmount;
  String? _createdAt;
  String? _updatedAt;
  List<int>? _addOnIds;
  List<int>? _addOnQtys;
  List<double>? _addOnPrices;
  double? _addOnTaxAmount;


  OrderDetailsModel(
      {int? id,
        int? productId,
        int? orderId,
        double? price,
        ProductDetails? productDetails,
        List<OldVariation>? oldVariations,
        List<Variation>? variations,
        double? discountOnProduct,
        String? discountType,
        int? quantity,
        double? taxAmount,
        String? createdAt,
        String? updatedAt,
        List<int>? addOnIds,
        List<int>? addOnQtys,
        List<double>? addOnPrices,
        double? addonTaxAmount,

      }) {
    _id = id;
    _productId = productId;
    _orderId = orderId;
    _price = price;
    _productDetails = productDetails;
    _oldVariations = oldVariations;
    _variations = variations;
    _discountOnProduct = discountOnProduct;
    _discountType = discountType;
    _quantity = quantity;
    _taxAmount = taxAmount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _addOnIds = addOnIds;
    _addOnQtys = addOnQtys;
    _addOnPrices = addOnPrices;
    _addOnTaxAmount = addonTaxAmount;

  }

  int? get id => _id;
  int? get productId => _productId;
  int? get orderId => _orderId;
  double? get price => _price;
  ProductDetails? get productDetails => _productDetails;
  List<OldVariation>? get oldVariations => _oldVariations;
  List<Variation>? get variations => _variations;
  double? get discountOnProduct => _discountOnProduct;
  String? get discountType => _discountType;
  int? get quantity => _quantity;
  double? get taxAmount => _taxAmount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<int>? get addOnIds => _addOnIds;
  List<int>? get addOnQtys => _addOnQtys;
  List<double>? get addOnPrices => _addOnPrices;
  double? get addonTaxAmount => _addOnTaxAmount;


  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _orderId = json['order_id'];
    _price = json['price'].toDouble();
    _productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;
    if (json['variation'] != null && json['variation'].isNotEmpty) {
      if(json['variation'][0]['values'] != null) {
        _variations = [];
        json['variation'].forEach((v) {
          _variations!.add(Variation.fromJson(v));
        });
      }else{
        _oldVariations = [];
        json['variation'].forEach((v) {
          _oldVariations!.add(OldVariation.fromJson(v));
        });
      }
    }
    _discountOnProduct = json['discount_on_product'].toDouble();
    _discountType = json['discount_type'];
    _quantity = json['quantity'];
    _taxAmount = json['tax_amount'].toDouble();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _addOnIds = json['add_on_ids'].cast<int>();
    _addOnQtys = json['add_on_qtys'].cast<int>();
    if(json['add_on_prices'] != null) {
      _addOnPrices = [];
      json['add_on_prices'].forEach((qun) {
        try {
          _addOnPrices?.add( double.parse('$qun'));
        }catch(e) {
          _addOnPrices?.add(qun);
        }

      });
    }
    _addOnTaxAmount = double.tryParse('${json['add_on_tax_amount']}');

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['product_id'] = _productId;
    data['order_id'] = _orderId;
    data['price'] = _price;
    if (_productDetails != null) {
      data['product_details'] = _productDetails!.toJson();
    }
    if (_variations != null) {
      data['variation'] = _variations;
    }
    data['discount_on_product'] = _discountOnProduct;
    data['discount_type'] = _discountType;
    data['quantity'] = _quantity;
    data['tax_amount'] = _taxAmount;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['add_on_ids'] = _addOnIds;
    data['add_on_qtys'] = _addOnQtys;
    data['add_on_prices'] = _addOnPrices;
    data['add_on_tax_amount'] = _addOnTaxAmount;
    return data;
  }
}

class ProductDetails {
  int? _id;
  String? _name;
  String? _description;
  String? _image;
  double? _price;
  List<Variation>? _variations;
  List<OldVariation>? _oldVariation;
  List<AddOns>? _addOns;
  double? _tax;
  String? _availableTimeStarts;
  String? _availableTimeEnds;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  List<String>? _attributes;
  List<CategoryIds>? _categoryIds;
  List<ChoiceOptions>? _choiceOptions;
  double? _discount;
  String? _discountType;
  String? _taxType;
  int? _setMenu;
  String? _productType;

  ProductDetails(
      {int? id,
        String? name,
        String? description,
        String? image,
        double? price,
        List<Variation>? variations,
        List<OldVariation>? oldVariation,
        List<AddOns>? addOns,
        double? tax,
        String? availableTimeStarts,
        String? availableTimeEnds,
        int? status,
        String? createdAt,
        String? updatedAt,
        List<String>? attributes,
        List<CategoryIds>? categoryIds,
        List<ChoiceOptions>? choiceOptions,
        double? discount,
        String? discountType,
        String? taxType,
        int? setMenu,
        String? productType,
      }) {
    _id = id;
    _name = name;
    _description = description;
    _image = image;
    _price = price;
    _variations = variations;
    _oldVariation = oldVariation;
    _addOns = addOns;
    _tax = tax;
    _availableTimeStarts = availableTimeStarts;
    _availableTimeEnds = availableTimeEnds;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _attributes = attributes;
    _categoryIds = categoryIds;
    _choiceOptions = choiceOptions;
    _discount = discount;
    _discountType = discountType;
    _taxType = taxType;
    _setMenu = setMenu;
    _productType = productType;
  }

  int? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get image => _image;
  double? get price => _price;
  List<Variation>? get variations => _variations;
  List<OldVariation>? get oldVariations => _oldVariation;
  List<AddOns>? get addOns => _addOns;
  double? get tax => _tax;
  String? get availableTimeStarts => _availableTimeStarts;
  String? get availableTimeEnds => _availableTimeEnds;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<String>? get attributes => _attributes;
  List<CategoryIds>? get categoryIds => _categoryIds;
  List<ChoiceOptions>? get choiceOptions => _choiceOptions;
  double? get discount => _discount;
  String? get discountType => _discountType;
  String? get taxType => _taxType;
  int? get setMenu => _setMenu;
  String? get productType => _productType;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _price = json['price'].toDouble();
    if (json['variation'] != null && json['variation'].isNotEmpty) {
      if(json['variation'][0]['values'] != null) {
        _variations = [];
        json['variation'].forEach((v) {
          _variations!.add(Variation.fromJson(v));
        });
      }else{
        _oldVariation = [];
        json['variation'].forEach((v) {
          _oldVariation!.add(OldVariation.fromJson(v));
        });
      }
    }
    if (json['add_ons'] != null) {
      _addOns = [];
      try{
        json['add_ons'].forEach((v) {

          if(v is List) {
            _addOns!.add(AddOns.fromJson(v[0]));
          }else{
            _addOns!.add(AddOns.fromJson(v));
          }
        });

      }catch(e){
        _addOns = [];
      }
    }
    _tax = json['tax'].toDouble();
    _availableTimeStarts = json['available_time_starts'];
    _availableTimeEnds = json['available_time_ends'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _attributes = json['attributes'].cast<String>();
    if (json['category_ids'] != null) {
      _categoryIds = [];
      json['category_ids'].forEach((v) {
        _categoryIds!.add(CategoryIds.fromJson(v));
      });
    }
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      json['choice_options'].forEach((v) {
        _choiceOptions!.add(ChoiceOptions.fromJson(v));
      });
    }
    _discount = json['discount'].toDouble();
    _discountType = json['discount_type'];
    _taxType = json['tax_type'];
    _setMenu = json['set_menu'];
    _productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['description'] = _description;
    data['image'] = _image;
    data['price'] = _price;
    if (_variations != null) {
      data['variations'] = _variations!.map((v) => v.toJson()).toList();
    }
    if (_addOns != null) {
      data['add_ons'] = _addOns!.map((v) => v.toJson()).toList();
    }
    data['tax'] = _tax;
    data['available_time_starts'] = _availableTimeStarts;
    data['available_time_ends'] = _availableTimeEnds;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['attributes'] = _attributes;
    if (_categoryIds != null) {
      data['category_ids'] = _categoryIds!.map((v) => v.toJson()).toList();
    }
    if (_choiceOptions != null) {
      data['choice_options'] =
          _choiceOptions!.map((v) => v.toJson()).toList();
    }
    data['discount'] = _discount;
    data['discount_type'] = _discountType;
    data['tax_type'] = _taxType;
    data['set_menu'] = _setMenu;
    data['product_type'] = _productType;
    return data;
  }
}
class VariationValue {
  String? level;
  double? optionPrice;

  VariationValue({this.level, this.optionPrice});

  VariationValue.fromJson(Map<String, dynamic> json) {
    level = json['label'];
    optionPrice = double.parse(json['optionPrice'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = level;
    data['optionPrice'] = optionPrice;
    return data;
  }
}

class Variation {
  String? name;
  int? min;
  int? max;
  bool? isRequired;
  bool? isMultiSelect;
  List<VariationValue>? variationValues;


  Variation({
    this.name, this.min, this.max,
    this.isRequired, this.variationValues,
    this.isMultiSelect,
  });

  Variation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isMultiSelect = '${json['type']}' == 'multi';
    min =  isMultiSelect! ? int.parse(json['min'].toString()) : 0;
    max = isMultiSelect! ? int.parse(json['max'].toString()) : 0;
    isRequired = '${json['required']}' == 'on';
    if (json['values'] != null) {
      variationValues = [];
      json['values'].forEach((v) {
        variationValues!.add(VariationValue.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = isMultiSelect;
    data['min'] = min;
    data['max'] = max;
    data['required'] = isRequired;
    if (variationValues != null) {
      data['values'] = variationValues!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class AddOns {
  int? _id;
  String? _name;
  double? _price;
  String? _createdAt;
  String? _updatedAt;

  AddOns(
      {int? id, String? name, double? price, String? createdAt, String? updatedAt}) {
    _id = id;
    _name = name;
    _price = price;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get name => _name;
  double? get price => _price;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  AddOns.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'].toDouble();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['price'] = _price;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class CategoryIds {
  String? _id;
  int? _position;

  CategoryIds({String? id, int? position}) {
    _id = id;
    _position = position;
  }

  String? get id => _id;
  int? get position => _position;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['position'] = _position;
    return data;
  }
}

class ChoiceOptions {
  String? _name;
  String? _title;
  List<String>? _options;

  ChoiceOptions({String? name, String? title, List<String>? options}) {
    _name = name;
    _title = title;
    _options = options;
  }

  String? get name => _name;
  String? get title => _title;
  List<String>? get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['title'] = _title;
    data['options'] = _options;
    return data;
  }
}

class OldVariation {
  String? type;
  double? price;

  OldVariation({this.type, this.price});

  OldVariation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    return data;
  }
}

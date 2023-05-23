// To parse this JSON data, do
//
//     final getProductResponse = getProductResponseFromJson(jsonString);

import 'dart:convert';

GetProductResponse getProductResponseFromJson(String str) => GetProductResponse.fromJson(json.decode(str));

String getProductResponseToJson(GetProductResponse data) => json.encode(data.toJson());

class GetProductResponse {
  bool? error;
  String? message;
  String? minPrice;
  String? maxPrice;
    List<dynamic> ?filters;
  List<dynamic>? tags;
  String? total;
  String? offset;
  List<ProductDataList>? data;

  GetProductResponse({
    this.error,
    this.message,
    this.minPrice,
    this.maxPrice,
    this.filters,
    this.tags,
    this.total,
    this.offset,
    this.data,
  });

  factory GetProductResponse.fromJson(Map<String, dynamic> json) => GetProductResponse(
    error: json["error"],
    message: json["message"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    filters: List<dynamic>.from(json["filters"].map((x) => x)),
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    total: json["total"],
    offset: json["offset"],
    data: List<ProductDataList>.from(json["data"].map((x) => ProductDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "min_price": minPrice,
    "max_price": maxPrice,
    "filters": List<dynamic>.from(filters!.map((x) => x)),
    "tags": List<dynamic>.from(tags!.map((x) => x)),
    "total": total,
    "offset": offset,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProductDataList {
  String? total;
  String? sales;
  String? isPricesInclusiveTax;
  String? type;
  String? attrValueIds;
  String? sellerRating;
  String? sellerSlug;
  String? sellerNoOfRatings;
  String? sellerProfile;
  String? storeName;
  String? storeDescription;
  String? sellerId;
  String? sellerName;
  String? id;
  String? name;
  String? categoryId;
  String? shortDescription;
  String? slug;
  String? description;
  String? deliverableType;
  String? minimumOrderQuantity;
  String? quantityStepSize;
  String? codAllowed;
  String? rowOrder;
  String? rating;
  String? noOfRatings;
  String? image;
  String? isReturnable;
  String? isCancelable;
  String? indicator;
  List<String>? otherImages;
  String? videoType;
  String? video;
  List<dynamic>? tags;
  String? warrantyPeriod;
  String? guaranteePeriod;
  String? madeIn;
  String? categoryName;
  String? taxPercentage;
  List<dynamic>? reviewImages;
  List<dynamic>? attributes;
  List<Variant>? variants;
  MinMaxPrice? minMaxPrice;
  bool? isDeliverable;
  bool? isPurchased;
  int? isFavorite;
  String? imageMd;
  String? imageSm;
  List<String>? otherImagesMd;
  List<String>? otherImagesSm;
  List<dynamic>? variantAttributes;
  bool? isSelected;

  ProductDataList({
    this.total,
    this.sales,
    this.isPricesInclusiveTax,
    this.type,
    this.attrValueIds,
    this.sellerRating,
    this.sellerSlug,
    this.sellerNoOfRatings,
    this.sellerProfile,
    this.storeName,
    this.storeDescription,
    this.sellerId,
    this.sellerName,
    this.id,
    this.name,
    this.categoryId,
    this.shortDescription,
    this.slug,
    this.description,
    this.minimumOrderQuantity,
    this.quantityStepSize,
    this.codAllowed,
    this.rowOrder,
    this.rating,
    this.noOfRatings,
    this.image,
    this.isReturnable,
    this.isCancelable,
    this.indicator,
    this.otherImages,
    this.videoType,
    this.video,
    this.tags,
    this.warrantyPeriod,
    this.guaranteePeriod,
    this.madeIn,
    this.categoryName,
    this.taxPercentage,
    this.reviewImages,
    this.attributes,
    this.variants,
    this.minMaxPrice,
    this.isDeliverable,
    this.isPurchased,
    this.isFavorite,
    this.imageMd,
    this.imageSm,
    this.otherImagesMd,
    this.otherImagesSm,
    this.variantAttributes,
    this.isSelected
  });

  factory ProductDataList.fromJson(Map<String, dynamic> json) => ProductDataList(
    isSelected: false,
    total: json["total"],
    sales: json["sales"],
    isPricesInclusiveTax: json["is_prices_inclusive_tax"],
    type: json["type"],
    attrValueIds: json["attr_value_ids"],
    sellerRating: json["seller_rating"],
    sellerSlug: json["seller_slug"],
    sellerNoOfRatings: json["seller_no_of_ratings"],
    sellerProfile: json["seller_profile"],
    storeName: json["store_name"],
    storeDescription: json["store_description"],
    sellerId: json["seller_id"],
    sellerName: json["seller_name"],
    id: json["id"],
    name: json["name"],
    categoryId: json["category_id"],
    shortDescription: json["short_description"],
    slug: json["slug"],
    description: json["description"],
    minimumOrderQuantity: json["minimum_order_quantity"],
    quantityStepSize: json["quantity_step_size"],
    codAllowed: json["cod_allowed"],
    rowOrder: json["row_order"],
    rating: json["rating"],
    noOfRatings: json["no_of_ratings"],
    image: json["image"],
    isReturnable: json["is_returnable"],
    isCancelable: json["is_cancelable"],
    indicator: json["indicator"],
    otherImages: List<String>.from(json["other_images"].map((x) => x)),
    videoType: json["video_type"],
    video: json["video"],
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    warrantyPeriod: json["warranty_period"],
    guaranteePeriod: json["guarantee_period"],
    madeIn: json["made_in"],
    categoryName: json["category_name"],
    taxPercentage: json["tax_percentage"],
    reviewImages: List<dynamic>.from(json["review_images"].map((x) => x)),
    attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
    minMaxPrice: MinMaxPrice.fromJson(json["min_max_price"]),
    isDeliverable: json["is_deliverable"],
    isPurchased: json["is_purchased"],
    isFavorite: json["is_favorite"],
    imageMd: json["image_md"],
    imageSm: json["image_sm"],
    otherImagesMd: List<String>.from(json["other_images_md"].map((x) => x)),
    otherImagesSm: List<String>.from(json["other_images_sm"].map((x) => x)),
    variantAttributes: List<dynamic>.from(json["variant_attributes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "sales": sales,
    "is_prices_inclusive_tax": isPricesInclusiveTax,
    "type": type,
    "attr_value_ids": attrValueIds,
    "seller_rating": sellerRating,
    "seller_slug": sellerSlug,
    "seller_no_of_ratings": sellerNoOfRatings,
    "seller_profile": sellerProfile,
    "store_name": storeName,
    "store_description": storeDescription,
    "seller_id": sellerId,
    "seller_name": sellerName,
    "id": id,
    "name": name,
    "category_id": categoryId,
    "short_description": shortDescription,
    "slug": slug,
    "description": description,
    "deliverable_type": deliverableType,
    "minimum_order_quantity": minimumOrderQuantity,
    "quantity_step_size": quantityStepSize,
    "cod_allowed": codAllowed,
    "row_order": rowOrder,
    "rating": rating,
    "no_of_ratings": noOfRatings,
    "image": image,
    "is_returnable": isReturnable,
    "is_cancelable": isCancelable,
    "indicator": indicator,
    "other_images": List<dynamic>.from(otherImages!.map((x) => x)),
    "video_type": videoType,
    "video": video,
    "tags": List<dynamic>.from(tags!.map((x) => x)),
    "warranty_period": warrantyPeriod,
    "guarantee_period": guaranteePeriod,
    "made_in": madeIn,
    "category_name": categoryName,
    "tax_percentage": taxPercentage,
    "review_images": List<dynamic>.from(reviewImages!.map((x) => x)),
    "attributes": List<dynamic>.from(attributes!.map((x) => x)),
    "variants": List<dynamic>.from(variants!.map((x) => x.toJson())),
    "min_max_price": minMaxPrice!.toJson(),
    "is_deliverable": isDeliverable,
    "is_purchased": isPurchased,
    "is_favorite": isFavorite,
    "image_md": imageMd,
    "image_sm": imageSm,
    "other_images_md": List<dynamic>.from(otherImagesMd!.map((x) => x)),
    "other_images_sm": List<dynamic>.from(otherImagesSm!.map((x) => x)),
    "variant_attributes": List<dynamic>.from(variantAttributes!.map((x) => x)),
  };
}

class MinMaxPrice {
  int? minPrice;
  int? maxPrice;
  int? specialPrice;
  int? maxSpecialPrice;
  int? discountInPercentage;

  MinMaxPrice({
    this.minPrice,
    this.maxPrice,
    this.specialPrice,
    this.maxSpecialPrice,
    this.discountInPercentage,
  });

  factory MinMaxPrice.fromJson(Map<String, dynamic> json) => MinMaxPrice(
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    specialPrice: json["special_price"],
    maxSpecialPrice: json["max_special_price"],
    discountInPercentage: json["discount_in_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "min_price": minPrice,
    "max_price": maxPrice,
    "special_price": specialPrice,
    "max_special_price": maxSpecialPrice,
    "discount_in_percentage": discountInPercentage,
  };
}

class Variant {
  String? id;
  String? productId;
  String? attributeValueIds;
  String? attributeSet;
  String? price;
  String? specialPrice;
  String? sku;
  List<dynamic>? images;
  String? availability;
  String? status;
  DateTime? dateAdded;
  String? variantIds;
  String? attrName;
  String? variantValues;
  String? swatcheType;
  String? swatcheValue;
  List<dynamic>? imagesMd;
  List<dynamic>? imagesSm;
  String? cartCount;
  int? isPurchased;

  Variant({
    this.id,
    this.productId,
    this.attributeValueIds,
    this.attributeSet,
    this.price,
    this.specialPrice,
    this.sku,
    this.images,
    this.availability,
    this.status,
    this.dateAdded,
    this.variantIds,
    this.attrName,
    this.variantValues,
    this.swatcheType,
    this.swatcheValue,
    this.imagesMd,
    this.imagesSm,
    this.cartCount,
    this.isPurchased,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    productId: json["product_id"],
    attributeValueIds: json["attribute_value_ids"],
    attributeSet: json["attribute_set"],
    price: json["price"],
    specialPrice: json["special_price"],
    sku: json["sku"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    availability: json["availability"],
    status: json["status"],
    dateAdded: DateTime.parse(json["date_added"]),
    variantIds: json["variant_ids"],
    attrName: json["attr_name"],
    variantValues: json["variant_values"],
    swatcheType: json["swatche_type"],
    swatcheValue: json["swatche_value"],
    imagesMd: List<dynamic>.from(json["images_md"].map((x) => x)),
    imagesSm: List<dynamic>.from(json["images_sm"].map((x) => x)),
    cartCount: json["cart_count"],
    isPurchased: json["is_purchased"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "attribute_value_ids": attributeValueIds,
    "attribute_set": attributeSet,
    "price": price,
    "special_price": specialPrice,
    "sku": sku,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "availability": availability,
    "status": status,
    "date_added": dateAdded!.toIso8601String(),
    "variant_ids": variantIds,
    "attr_name": attrName,
    "variant_values": variantValues,
    "swatche_type": swatcheType,
    "swatche_value": swatcheValue,
    "images_md": List<dynamic>.from(imagesMd!.map((x) => x)),
    "images_sm": List<dynamic>.from(imagesSm!.map((x) => x)),
    "cart_count": cartCount,
    "is_purchased": isPurchased,
  };
}

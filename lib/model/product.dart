class Product {
  int? productId;
  String? productImage;
  String? productName;
  int? originalPrice;
  double? rating;
  int? discountPercentage;
  int? discountPrice;
  String? brand;

  Product({
    this.productId,
    this.productImage,
    this.productName,
    this.originalPrice,
    this.rating,
    this.discountPercentage,
    this.discountPrice,
    this.brand,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_image'] = productImage;
    data['product_name'] = productName;
    data['brand'] = brand;
    data['original_price'] = originalPrice;
    data['discounted_price'] = discountPrice;
    data['discount_percentage'] = discountPercentage;
    data['rating'] = rating;

    return data;
  }

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productImage = json['product_image'];
    productName = json['product_name'];
    brand = json['brand'];
    originalPrice = json['original_price'];
    discountPrice = json['discounted_price'];
    rating = json['rating'];
  }
}
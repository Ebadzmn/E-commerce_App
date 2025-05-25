class AppUrls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';
  static const String signUpUrl = '$_baseUrl/auth/signup';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String signIn = '$_baseUrl/auth/login';
  static const String sliderUrl = '$_baseUrl/slides';
  static const String categoryListUrl = '$_baseUrl/categories';
  static const String productListUrl = '$_baseUrl/products';
  static const String addToCartUrl = '$_baseUrl/cart';
  static const String addToWishtUrl = '$_baseUrl/wishlist';
  static  String deleteCartUrl(String id) => '$_baseUrl/cart/$id';
  static  String updateCartUrl(String id) => '$_baseUrl/cart/$id';
  static String productDetailsUrl(String productId) => '$_baseUrl/products/id/$productId';
  static String productReviewUrl = '$_baseUrl/reviews';
  static String addProductReviewUrl = '$_baseUrl/review';
  // static String productReviewUrl(String productId) {
  //   productId = productId.replaceAll('?', ''); // remove accidental '?'
  //   return '$_baseUrl/reviews?product=$productId';
  // }
}
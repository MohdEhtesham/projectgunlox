// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings
class Endpoints {
  //BaseURLs
  static const String BASE_URL = 'http://159.89.234.66:8912/api'; //DEV
  static const BANNER_IMAGE_BASE_URL =
      'http://159.89.234.66:8912/banner/'; //DEV IMAGE
  static const String TANDC_URL =
      'http://159.89.234.66:8913/terms-and-conditions';
  static const String SAFETY_URL = 'http://159.89.234.66:8913/safety';
  static const String SHOP_NOW_URL = 'https://www.gunlox.com/';

  //APIs
  static const String LOGIN = BASE_URL + '/users/login?include=user';
  static const String SEND_OTP = BASE_URL + '/users/login-code';
  static const String RESEND_OTP = BASE_URL + '/users/resend-otp';
  static const String VERIFY_OTP = BASE_URL + '/users/mobile-login';
  static const String DELETE_ACCOUNT = BASE_URL + '/users';
  static const String RESET_USER_PASSWORD = BASE_URL + '/users/reset-password';
  static const String CHANGE_USER_PASSWORD =
      BASE_URL + '/users/change-password';
  static const String GET_USER = BASE_URL + '/users';
  static const String GET_FIREARMDETAILS = BASE_URL + '/firearms';
  static const String REMOVE_AUTHORIZED_USER = BASE_URL + '/firearm-mappings';
  static const String DELETE_FIREARM = BASE_URL + '/firearms';
  static const String UPDATE_USER = BASE_URL + '/users';
  static const String FORGOT_PASSWORD = BASE_URL + '/users/forgot-password';
  static const String VERIFY_CODE = BASE_URL + '/users/email-otp-validation';
  static const String CONTACT_US = BASE_URL + '/users/contact-support';
  static const String ADD_FIREARM = BASE_URL + '/firearms';
  static const String UPDATE_FIREARM = BASE_URL + '/firearms';
  static const String ADD_AUTHORIZED_USER = BASE_URL + '/firearm-mappings';
  static const String GET_AUTHORIZED_USER = BASE_URL + '/firearm-mappings?';
  static const String SIGNUP = BASE_URL + '/users';
  static const String CHANGE_PHONE_NUMBER = BASE_URL + '/users/change-phone';
  static const String UPDATE_EMERGENCY = BASE_URL + '/firearms/update-emergency';
  
}

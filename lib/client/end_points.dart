abstract class EndPoints {
  static const String getPubs = "/pubs/";

  static const String signupuser = "/users/signup";
  static const String signinuser = "/users/signin";

  static const String planadd="/plans/add/";

  static const String messageadd="  /conversations/handleMessage/";

  static const String partnersignup = "/partenaires/signup";
  static const String partnersignin = "/partenaires/signin";

  static const String places = "/place/page";

  static const String createcomment = "/comments";
  static const String deletecomment = "/comments/:id";

  static const String createrates = "/rates";
  static const String getrates = "/rates/page";

  static const String addfavorites = "/place/favorites/add";
  static const String removefavorites = "/place/favorites/remove";
  static const String getfavorites = "/place/favorites/get";

  static String queryPath(String endPoint, List<String> args) {
    String result = endPoint;
    for (var i = 0; i < args.length; i++) {
      result = result.replaceAll('<${i + 1}>', args[i]);
    }
    print("query path : " + result);
    return result;
  }

  /*static String getRates(String placeId) {
    return "$getrates?rated_id=$placeId";
  }*/
}

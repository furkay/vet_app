import 'package:vet_app/core/constants/enums.dart';

class User {
  String uid;
  UserRole role;
  String name;
  String email;
  String about;
  String instagram;
  String twitter;
  String city;
  SignInType signInType;

  User({
    this.uid,
    this.role,
    this.email,
    this.name,
    this.about,
    this.instagram,
    this.twitter,
    this.city,
    this.signInType,
  });

  void clearUser() {
    uid = null;
    role = null;
    email = null;
    name = null;
    about = null;
    instagram = null;
    twitter = null;
    city = null;
    signInType = null;
  }
}

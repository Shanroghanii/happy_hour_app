import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String uid;
  late String username;
  late String email;
  late String? firstName;
  late String? lastName;
  late String? mobilenumber;
  late String? profileImage;
  late List<dynamic> favoriteHours;
  late List<dynamic> claimHours;
  late bool hasSubscription;
  late bool isBusiness;
  late String? stripeCustomerId;
  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.mobilenumber,
    this.profileImage,
    required this.claimHours,
    required this.favoriteHours,
    required this.isBusiness,
    required this.hasSubscription,
    this.stripeCustomerId,
  });

  UserModel.fromDocument(DocumentSnapshot<Map<String, Object?>> doc) {
    uid = doc.id;
    username = doc.data()!.containsKey("username")
        ? doc["username"] as String
        : "Name not Found";
    email = doc.data()!.containsKey("email")
        ? doc["email"] as String
        : "Email not Found";
    firstName = doc.data()!.containsKey('firstname')
        ? doc["firstname"] as String
        : "first Name not found";
    lastName = doc.data()!.containsKey('lastname')
        ? doc["lastname"] as String
        : "last Name not found";
    mobilenumber = doc.data()!.containsKey('mobilenumber')
        ? doc["mobilenumber"] as String
        : "Number Name not found";
    profileImage = doc.data()!.containsKey('profile_image')
        ? doc["profile_image"] as String
        : "";
    favoriteHours = doc.data()!.containsKey("favorite_hours")
        ? doc["favorite_hours"] as List<dynamic>
        : [];
    claimHours = doc.data()!.containsKey("claim_hours")
        ? doc["claim_hours"] as List<dynamic>
        : [];
    isBusiness = doc.data()!.containsKey("isBusiness")
        ? doc["isBusiness"] as bool
        : false;
    hasSubscription = doc.data()!.containsKey("has_subscription")
        ? doc["has_subscription"] as bool
        : false;
    stripeCustomerId = doc.data()!.containsKey("stripe_customer_id")
        ? doc["stripe_customer_id"] as String
        : "";
  }
}

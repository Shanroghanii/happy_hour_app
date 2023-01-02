import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/hour_favorite_model.dart';
import 'package:happy_hour_app/global_widgets/hour_card.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

import '../core/colors.dart';
import '../global_controller/auth_controller.dart';
import '../global_controller/global_general_controller.dart';

class HoursListGenerator extends StatelessWidget {
  const HoursListGenerator({
    Key? key,
    required this.query,
    this.showUnfavoriteButton = false,
    this.showAllHours = false,
  }) : super(key: key);

  final Query<HoursFavoriteModel> query;
  final bool showUnfavoriteButton;
  final bool showAllHours;

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<HoursFavoriteModel>(
      query: query,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, snapshot) {
        // HappyHourModel happyHourModel = snapshot.data();
        HoursFavoriteModel hoursFavoriteModel = snapshot.data();
        HourCard hourCard = HourCard(
          name: hoursFavoriteModel.businessName,
          menuImage: hoursFavoriteModel.menuImage,
          description: hoursFavoriteModel.description,
          star: RatingBarIndicator(
            unratedColor: Colors.grey.shade300,
            direction: Axis.horizontal,
            rating: 5,
            //rating: hoursFavoriteModel.reviewList?[0]["stars"] ?? 0,
            itemCount: 5,
            itemSize: 20,
            itemBuilder: (context, index) => Image.asset(
              "assets/icons/Path 602@2x.png",
              height: 7,
              width: 10,
              color: primary,
            ),
          ),
          favourite: FavoriteButton(
            cardPadding: 10,
            size: 40,
            hoursFavoriteModel: hoursFavoriteModel,
          ),
          onTap: () {
            Get.toNamed(Routes.favoriteDetailScreen,
                arguments: hoursFavoriteModel);
            // Get.find<GlobalGeneralController>().onHourTap(
            //   hoursFavoriteModel: hoursFavoriteModel,
            // );
          },
          icon: showUnfavoriteButton
              ? UnFavoriteButton(hoursFavoriteModel: hoursFavoriteModel)
              : FavoriteButton(hoursFavoriteModel: hoursFavoriteModel),
        );
        if (showAllHours) {
          return hourCard;
        }
        return hourCard;
      },
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.hoursFavoriteModel,
    this.size,
    this.cardPadding,
  }) : super(key: key);

  final HoursFavoriteModel hoursFavoriteModel;
  final double? size;
  final double? cardPadding;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CardIcon(
        icon: Get.find<AuthController>()
                .user
                .favoriteHours
                .contains(hoursFavoriteModel.hid)
            ? FontAwesomeIcons.solidHeart
            : FontAwesomeIcons.heart,
        cardPadding: cardPadding ?? 6.0,
        size: size ?? 12,
        color: Get.find<AuthController>()
                .user
                .favoriteHours
                .contains(hoursFavoriteModel.hid)
            ? primary
            : Colors.black,
        onTap: () {
          // print("${hoursFavoriteModel.hid}==============hourid");
          // print("${Get.find<AuthController>().user.uid}==============userid");
          // print(Get.find<AuthController>()
          //     .user
          //     .favoriteHours
          //     .contains(hoursFavoriteModel.hid));
          Get.find<GlobalGeneralController>().changeHourFavoriteStatus(
            hourId: hoursFavoriteModel.hid,
            //letter it will be replace with  hoursFavoriteModel.hid,  "lkGGGmjXs7CZF0oUxmR4"
            //hourId: hoursFavoriteModel.hid,
            userId: Get.find<AuthController>().user.uid,
            previousState: Get.find<AuthController>()
                .user
                .favoriteHours
                .contains(hoursFavoriteModel.hid),
          );
        },
      ),
    );
  }
}

class UnFavoriteButton extends StatelessWidget {
  const UnFavoriteButton({
    Key? key,
    required this.hoursFavoriteModel,
  }) : super(key: key);

  final HoursFavoriteModel hoursFavoriteModel;

  @override
  Widget build(BuildContext context) {
    return CardIcon(
      icon: FontAwesomeIcons.solidCircleXmark,
      cardPadding: 0.0,
      size: 30,
      color: primary,
      onTap: () {
        Get.find<GlobalGeneralController>().changeHourFavoriteStatus(
          hourId: hoursFavoriteModel.hid,
          userId: Get.find<AuthController>().user.uid,
          previousState: Get.find<AuthController>()
              .user
              .favoriteHours
              .contains(hoursFavoriteModel.hid),
        );
      },
    );
  }
}

class CardIcon extends StatelessWidget {
  const CardIcon({
    Key? key,
    required this.icon,
    this.color,
    this.size,
    this.onTap,
    this.cardPadding,
  }) : super(key: key);

  final IconData icon;
  final Color? color;
  final double? size;
  final void Function()? onTap;
  final double? cardPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(cardPadding ?? 10.0),
          child: FaIcon(
            icon,
            color: color ?? Colors.black,
            size: size,
          ),
        ),
      ),
    );
  }
}

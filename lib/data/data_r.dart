import 'package:responsive_admin_dashboard/constants/constants_r.dart';
import 'package:responsive_admin_dashboard/models/analytic_info_model_r.dart';
import 'package:responsive_admin_dashboard/models/discussions_info_model_r.dart';
import 'package:responsive_admin_dashboard/models/referal_info_model_r.dart';

List analyticDatar = [
  AnalyticInfor(
    title: "Confirmed Reservations",
    count: 720,
    svgSrc: "assets/icons/Subscribers.svg",
    color: primaryColor,
  ),
  AnalyticInfor(
    title: "Failed Reservations",
    count: 820,
    svgSrc: "assets/icons/Post.svg",
    color: purple,
  ),
  AnalyticInfor(
    title: "Cancelled Reservations",
    count: 920,
    svgSrc: "assets/icons/Pages.svg",
    color: orange,
  ),
];

List discussionData = [
  DiscussionInfoModelr(
    imageSrc: "assets/images/photo1.jpg",
    name: "Lutfhi Chan",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModelr(
    imageSrc: "assets/images/photo2.jpg",
    name: "Devi Carlos",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModelr(
    imageSrc: "assets/images/photo3.jpg",
    name: "Danar Comel",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModelr(
    imageSrc: "assets/images/photo4.jpg",
    name: "Karin Lumina",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModelr(
    imageSrc: "assets/images/photo5.jpg",
    name: "Fandid Deadan",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModelr(
    imageSrc: "assets/images/photo1.jpg",
    name: "Lutfhi Chan",
    date: "Jan 25,2021",
  ),
];

List referalData = [
  ReferalInfoModelr(
    title: "hama boualeg ",
    count: "234 days",
    svgSrc: "assets/images/photo1.jpg",
    color: primaryColor,
  ),
  ReferalInfoModelr(
    title: "ahmed maadi",
    count: "234 days",
    svgSrc: "assets/images/photo1.jpg",
    color: primaryColor,
  ),
  ReferalInfoModelr(
    title: "ekbel zrelli",
    count: "234 days",
    svgSrc: "assets/images/photo1.jpg",
    color: primaryColor,
  ),
  ReferalInfoModelr(
    title: "yessine ezzar",
    count: "234 days",
    svgSrc: "assets/images/photo1.jpg",
    color: red,
  ),
];

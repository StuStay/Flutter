
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/models/analytic_info_model.dart';
import 'package:responsive_admin_dashboard/models/discussions_info_model.dart';
import 'package:responsive_admin_dashboard/models/referal_info_model.dart';

List<AnalyticInfo> analyticData = [
  AnalyticInfo(
    title: "Total Payments",
    count: 900,
    svgSrc: "assets/icons/GenericMoney.svg", // Placeholder for a money-related icon
    color: primaryColor,
  ),
  AnalyticInfo(
    title: "Successful Payments",
    count: 820,
    svgSrc: "assets/icons/GenericSuccess.svg", // Placeholder for a success-related icon
    color: purple,
  ),
  AnalyticInfo(
    title: "Pending Payments",
    count: 70,
    svgSrc: "assets/icons/GenericClock.svg", // Placeholder for a clock or time-related icon
    color: orange,
  ),
  AnalyticInfo(
    title: "Failed Payments",
    count: 10,
    svgSrc: "assets/icons/GenericFailed.svg", // Placeholder for a failure-related icon
    color: green,
  ),
];


List discussionData = [
  DiscussionInfoModel(
    imageSrc: "assets/images/photo1.jpg",
    name: "Lutfhi Chan",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo2.jpg",
    name: "Devi Carlos",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo3.jpg",
    name: "Danar Comel",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo4.jpg",
    name: "Karin Lumina",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo5.jpg",
    name: "Fandid Deadan",
    date: "Jan 25,2021",
  ),
  DiscussionInfoModel(
    imageSrc: "assets/images/photo1.jpg",
    name: "Lutfhi Chan",
    date: "Jan 25,2021",
  ),
];

List referalData = [
  ReferalInfoModel(
    title: "Ahmed Maadi",
    count: 500,
    svgSrc: "",
    color: primaryColor,
  ),
  ReferalInfoModel(
    title: "Med Amine Bouallegue",
    count: 440,
    svgSrc: "",
    color: primaryColor,
  ),
  ReferalInfoModel(
    title: "Malek Saker",
    count: 234,
    svgSrc: "",
    color: primaryColor,
  ),

  ReferalInfoModel(
    title: "Khmayes Bonguicha",
    count: 105,
    svgSrc: "",
    color: red,
  ),
];

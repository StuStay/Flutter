
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/models/analytic_info_model.dart';
import 'package:responsive_admin_dashboard/models/discussions_info_model.dart';
import 'package:responsive_admin_dashboard/models/referal_info_model.dart';

List<AnalyticInfo> analyticData = [
  AnalyticInfo(
    title: "Total Payments",
    count: 900,
    svgSrc: "",
    color: primaryColor,
  ),
  AnalyticInfo(
    title: "Successful Payments",
    count: 820,
    svgSrc: "",
    color: purple,
  ),
  AnalyticInfo(
    title: "Pending Payments",
    count: 70,
    svgSrc: "",
    color: orange,
  ),
  AnalyticInfo(
    title: "Failed Payments",
    count: 10,
    svgSrc: "",
    color: green,
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

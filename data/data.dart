
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/models/analytic_info_model.dart';
import 'package:responsive_admin_dashboard/models/discussions_info_model.dart';
import 'package:responsive_admin_dashboard/models/referal_info_model.dart';

List<AnalyticInfo> analyticData = [
  AnalyticInfo(
    title: "Total Logements",
    count: 500,
    svgSrc: "",
    color: primaryColor,
  ),
  AnalyticInfo(
    title: "Successful Logements",
    count: 200,
    svgSrc: "",
    color: purple,
  ),
  AnalyticInfo(
    title: "Pending Logements",
    count: 90,
    svgSrc: "",
    color: orange,
  ),
  AnalyticInfo(
    title: "Failed Logements",
    count: 30,
    svgSrc: "",
    color: green,
  ),
];

List referalData = [
  TopReferalInfoModel(
    title: "Ahmed Maadi",
    count: 500,
    svgSrc: "",
    color: primaryColor,
  ),
  TopReferalInfoModel(
    title: "Med Amine Bouallegue",
    count: 440,
    svgSrc: "",
    color: primaryColor,
  ),
  TopReferalInfoModel(
    title: "Malek Saker",
    count: 234,
    svgSrc: "",
    color: primaryColor,
  ),

  TopReferalInfoModel(
    title: "Khmayes Bonguicha",
    count: 105,
    svgSrc: "",
    color: red,
  ),
];



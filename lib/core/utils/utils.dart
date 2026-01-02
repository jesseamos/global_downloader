import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';
import 'package:spotify_downloader/core/icons/social_icons.dart';
import 'package:spotify_downloader/core/icons/transaction_icons.dart';
import 'package:spotify_downloader/core/icons/vectors_icon.dart';
import 'package:spotify_downloader/core/presentation/widgets/state_widgets.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

// Future<T?> showDialogPopup<T>(BuildContext context, Widget widget,
//     {bool barrierDismissible = false, Color? barrierColor}) {
//   return showDialog<T>(
//     context: context,
//     barrierColor: barrierColor ?? AppColors.black.withValues(alpha: 0.2),
//     builder: (_) => widget,
//     barrierDismissible: barrierDismissible,
//   );
// }
String? formValidation(String? value, {String? customMessage}) {
  if (value == null || value.isEmpty) {
    return customMessage ?? 'Kindly enter the required information.';
  }
  return null;
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('MM/dd HH:mm:ss');
  return formatter.format(dateTime);
}

Future<void> _launchUrl(Uri uri) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    print("Could not launch $uri");
  }
}

String capitalizeFirstLetter(String input, {bool replaceUnderscore = false}) {
  if (input.isEmpty) return input;

  String text = replaceUnderscore ? input.replaceAll('_', ' ') : input;

  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

String getUserInitials(String name) {
  List<String> names = name.trim().split(" ");
  if (names.length > 1) {
    return names[0][0].toUpperCase() + names[1][0].toUpperCase();
  }
  return names[0][0].toUpperCase();
}

String? getTimeFromDate(DateTime? date) {
  try {
    return DateFormat('hh:mm a').format(date!);
  } catch (_) {
    return null;
  }
}

String formatNumber(num? value, {int decimalDigits = 2, bool short = false}) {
  if (value == null) return "--";

  NumberFormat formatter;
  if (short) {
    formatter = NumberFormat.compact();
  } else {
    formatter = NumberFormat.currency(decimalDigits: decimalDigits, symbol: "");
  }
  return formatter.format(value);
}

String formatCurrency(
  num? value, {
  int decimalDigits = 2,
  bool short = false,
  String code = "NGN",
}) {
  if (value == null) {
    return "-";
  }

  if (short) {
    return NumberFormat.compactCurrency(
      symbol: getCurrencySymbol(code),
      decimalDigits: decimalDigits,
    ).format(value);
  } else {
    return NumberFormat.currency(
      decimalDigits: decimalDigits,
      symbol: getCurrencySymbol(code),
    ).format(value);
  }
}

String? formatDateShortWithTime(DateTime? dateTime) {
  try {
    final DateFormat formatter = DateFormat("MMM d, yyyy • hh:mm a");
    return formatter.format(dateTime!);
  } catch (_) {
    return null;
  }
}

String formatDateWithSuffix(DateTime date) {
  // Get day number
  int day = date.day;

  // Determine the suffix
  String suffix;
  if (day >= 11 && day <= 13) {
    suffix = "th";
  } else {
    switch (day % 10) {
      case 1:
        suffix = "st";
        break;
      case 2:
        suffix = "nd";
        break;
      case 3:
        suffix = "rd";
        break;
      default:
        suffix = "th";
    }
  }

  // Format month and time
  String month = DateFormat("MMMM").format(date); // e.g. March
  String time = DateFormat("HH:mm:ss").format(date); // e.g. 12:02:23

  return "$month $day$suffix, $time";
}

String? formatDateShort(DateTime? dateTime) {
  try {
    final DateFormat formatter = DateFormat("dd MMM, yyyy");
    return formatter.format(dateTime!);
  } catch (_) {
    return null;
  }
}

String getCurrencySymbol(String currencyName, {bool useFullName = false}) {
  currencyName = (currencyName.trim().contains("-"))
      ? currencyName.split("-").last.toUpperCase()
      : currencyName.toUpperCase();
  String currencySymbol = '';
  String fullName = '';
  switch (currencyName) {
    case 'NGN':
    case 'NGA':
    case 'NG':
      fullName = "naira";
      currencySymbol = "\u20A6";
      break;
    case 'GBP':
      fullName = "pound";
      currencySymbol = NumberFormat().simpleCurrencySymbol("GBP");
      break;
    case 'EUR':
      fullName = "euro";
      currencySymbol = NumberFormat().simpleCurrencySymbol("EUR");
      break;
    case 'KES':
      fullName = "shilling";
      currencySymbol = NumberFormat().simpleCurrencySymbol("KES");
      break;
    case 'GHS':
      fullName = "cedi";
      currencySymbol = NumberFormat().simpleCurrencySymbol("GHS");
      break;
    case 'ZMW':
      fullName = "kwacha";
      currencySymbol = NumberFormat().simpleCurrencySymbol("ZMW");
      break;
    case 'UGX':
      fullName = "shilling";
      currencySymbol = NumberFormat().simpleCurrencySymbol("UGX");
      break;
    case 'RWF':
      fullName = "franc";
      currencySymbol = NumberFormat().simpleCurrencySymbol("RWF");
      break;
    case 'XOF':
      fullName = "franc";
      currencySymbol = NumberFormat().simpleCurrencySymbol("XOF");
      break;
    case 'TZS':
      fullName = "shilling";
      currencySymbol = NumberFormat().simpleCurrencySymbol("TZS");
      break;
    case 'USD':
    case 'US':
      fullName = 'dollar';
      currencySymbol = NumberFormat().simpleCurrencySymbol("USD");
      break;
    default:
      fullName = currencyName;
      currencySymbol = NumberFormat().simpleCurrencySymbol(currencyName);
      break;
  }

  return useFullName ? fullName : currencySymbol;
}

Future<Color?> getDominantColorFromSvg(String assetPath) async {
  final svgString = await rootBundle.loadString(assetPath);
  final xmlDoc = XmlDocument.parse(svgString);

  // Try to find the first "fill" attribute
  final fillAttribute = xmlDoc
      .findAllElements('*')
      .expand((element) => element.attributes)
      .firstWhere(
        (attr) => attr.name.local == 'fill' && attr.value != 'none',
        orElse: () => XmlAttribute(XmlName('fill'), '#FFFFFF'),
      );

  return _parseColor(fillAttribute.value);
}

Color? _parseColor(String hex) {
  try {
    final cleanedHex = hex.replaceAll('#', '');
    if (cleanedHex.length == 6) {
      return Color(int.parse('0xFF$cleanedHex'));
    } else if (cleanedHex.length == 8) {
      return Color(int.parse('0x$cleanedHex'));
    }
  } catch (_) {}
  return null;
}

String? formatDateSlash(DateTime? dateTime) {
  try {
    final DateFormat formatter = DateFormat("dd/MM/yy");
    return formatter.format(dateTime!);
  } catch (_) {
    return null;
  }
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.orange;
    case 'successful':
      return Colors.green;
    case 'failed':
      return Colors.red;
    case 'in_progress':
      return Colors.blueGrey;
    default:
      return Colors.grey;
  }
}

String extractLocalPhoneNumber(String input) {
  // Keep only digits
  String digits = input.replaceAll(RegExp(r'\D'), '');

  // Remove '234' from the beginning if present and replace with '0'
  if (digits.startsWith('234')) {
    digits = '0' + digits.substring(3);
  }

  return digits;
}

String? emailValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email address';
  }
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

Future<bool> requestStoragePermission() async {
  if (Platform.isAndroid) {
    if (await Permission.storage.request().isGranted) {
      return true;
    }

    // For Android 11+
    if (await Permission.manageExternalStorage.isGranted) {
      return true;
    }

    var status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }
  return false;
}

// Future<void> exportUsersToCSV(
//   List<DMAutomationLeadDownloadEntity> leads,
// ) async {
//   // Request storage permission
//   bool granted = await requestStoragePermission();
//   if (!granted) {
//     throw Exception('Storage permission not granted');
//   }

//   // Convert to CSV
//   List<List<String>> csvData = [
//     ['USERNAME', 'FOLLOWERS', 'FOLLOWING'],
//     ...leads.map(
//       (u) => [u.username ?? '', u.followers ?? '', u.following ?? ''],
//     ),
//   ];

//   String csv = const ListToCsvConverter().convert(csvData);

//   // Get path
//   final directory = await getExternalStorageDirectory();
//   final path = directory?.path;

//   if (path == null) {
//     throw Exception("Couldn't get the storage path");
//   }

//   final file = File('$path/users.csv');
//   await file.writeAsString(csv);

//   print('File saved at: ${file.path}');
// }

String formatNumberPrefix(int number) {
  if (number >= 1000000000) {
    return '${(number / 1000000000).toStringAsFixed(1).replaceAll('.0', '')}B';
  } else if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1).replaceAll('.0', '')}M';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1).replaceAll('.0', '')}k';
  } else {
    return number.toString();
  }
}

String formatNumberWithCommas(num number) {
  final formatter = NumberFormat('#,##0');
  return formatter.format(number);
}

// Widget statusBuilder(status, {bool isPaused = false}) {
//   if (isPaused) {
//     return StatusBadge(
//       title: 'Paused',
//       titleColor: ColorsConstant.greyText,
//       bgColor: ColorsConstant.opacityGrey,
//     );
//   }
//   if (status == 'runing' ||
//       status == "active" ||
//       status == 'pending' ||
//       status == 'retrying') {
//     return StatusBadge(title: 'Active');
//   } else if (status == 'paused' || status == 'failed') {
//     return StatusBadge(
//       title: 'Paused',
//       titleColor: ColorsConstant.greyText,
//       bgColor: ColorsConstant.opacityGrey,
//     );
//   } else {
//     return StatusBadge(
//       title: 'Completed',
//       titleColor: ColorsConstant.blue,
//       bgColor: ColorsConstant.opacityBlue,
//     );
//   }
// }

String getShortenedDays(List<String> days) {
  return days.map((day) => day.substring(0, 3)).join(', ');
}

List<String> getFullDayNames(String shortenedDays, {bool everyday = false}) {
  if (everyday) {
    return [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];
  }
  final Map<String, String> dayMap = {
    'Mon': 'monday',
    'Tue': 'tuesday',
    'Wed': 'wednesday',
    'Thu': 'thursday',
    'Fri': 'friday',
    'Sat': 'saturday',
    'Sun': 'sunday',
  };

  return shortenedDays
      .split(',')
      .map((s) => s.trim())
      .map((abbr) => dayMap[abbr] ?? abbr.toLowerCase())
      .toList();
}

String? validatePercentage(String? value, {required String fieldName}) {
  if (value == null || value.isEmpty) {
    return '$fieldName required';
  }
  final intValue = int.tryParse(value);
  if (intValue == null) {
    return 'Please enter a valid number';
  }
  if (intValue < 0 || intValue > 100) {
    return '$fieldName must be between 0 and 100';
  }
  return null;
}

// A helper validation for min/max relationships
String? validateMinMax({
  required TextEditingController minController,
  required TextEditingController maxController,
  required String fieldName,
}) {
  if (minController.text.isNotEmpty && maxController.text.isNotEmpty) {
    final int min = int.tryParse(minController.text) ?? 0;
    final int max = int.tryParse(maxController.text) ?? 0;
    if (max < min) {
      return 'Maximum $fieldName cannot be less than minimum';
    }
  }
  return null;
}

DateTime? parseDate(dynamic value) {
  if (value is String) {
    return DateTime.tryParse(value);
  }
  return null;
}

String formatXAxisLabel(String label) {
  final s = label.trim();
  if (s.isEmpty) return '';

  // Normalize two-digit year: 06/02/25 -> 06/02/2025
  final twoDigitDate = RegExp(r'^(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{2})$');
  var normalized = s;
  final m = twoDigitDate.firstMatch(s);
  if (m != null) {
    normalized = '${m.group(1)}/${m.group(2)}/20${m.group(3)}';
  }

  // Try a quick ISO parse first
  DateTime? dt = DateTime.tryParse(normalized);
  if (dt == null) {
    // Try common date patterns
    final patterns = [
      'dd/MM/yyyy',
      'MM/dd/yyyy',
      'yyyy-MM-dd',
      'yyyy/MM/dd',
      'd-M-yyyy',
      'M/d/yyyy',
    ];
    for (final p in patterns) {
      try {
        dt = DateFormat(p).parse(normalized);
        break;
      } catch (_) {}
    }
  }

  if (dt != null) {
    // Choose the short format you prefer; 'd MMM' => '6 Feb'
    return DateFormat('d MMM').format(dt);
  }

  // Detect times like "1pm", "1:30 PM", "13:00"
  final timeRegex = RegExp(
    r'^\s*(\d{1,2})(?::(\d{2}))?\s*([ap]m)?\s*$',
    caseSensitive: false,
  );
  final timeMatch = timeRegex.firstMatch(s);
  if (timeMatch != null) {
    final hour = timeMatch.group(1)!;
    final min = timeMatch.group(2);
    final ampm = timeMatch.group(3);
    if (ampm != null && ampm.isNotEmpty) {
      return min != null
          ? '$hour:$min${ampm.toLowerCase()}'
          : '$hour${ampm.toLowerCase()}';
    }
    if (min != null) return '$hour:$min';
    return hour;
  }

  // Fallback: truncate long labels
  if (s.length > 6) return s.substring(0, 6) + '..';
  return s;
}

// String getSocialMediaIcon({required String text}) {
//   String lowerText = text.toLowerCase();

//   if (lowerText.contains('facebook')) {
//     return facebookIcon;
//   }
//   if (lowerText.contains('youtube')) {
//     return youtubeIcon;
//   }
//   if (lowerText.contains('twitter') || lowerText.contains('x')) {
//     return twitterIcon;
//   }
//   if (lowerText.contains('instagram')) {
//     return instagramIcon;
//   }
//   if (lowerText.contains('linkedin')) {
//     return linkedInIcon;
//   }
//   if (lowerText.contains('slack')) {
//     return slackIcon;
//   }

//   return linkedInIcon; // fallback if no match
// }

Future<void> copyToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
}

/// Takes a list of integers (each representing seconds),
/// sums them, and returns a formatted duration string.
String totalDurationFormatted(List<int> secondsList) {
  if (secondsList.isEmpty) return "0 sec";

  // Sum all seconds
  int totalSeconds = secondsList.fold(0, (sum, item) => sum + item);

  // Convert into Duration
  Duration duration = Duration(seconds: totalSeconds);

  return _formatDuration(duration);
}

/// Helper function to format duration into "X hrs Y mins Z secs"
String _formatDuration(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  List<String> parts = [];
  if (hours > 0) parts.add("$hours hr${hours > 1 ? 's' : ''}");
  if (minutes > 0) parts.add("$minutes min${minutes > 1 ? 's' : ''}");
  if (seconds > 0 || parts.isEmpty) {
    parts.add("$seconds sec${seconds > 1 ? 's' : ''}");
  }

  return parts.join(" ");
}

class StatusColors {
  final Color textColor;
  final Color bgColor;

  StatusColors({required this.textColor, required this.bgColor});
}

StatusColors getStatusColors(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return StatusColors(
        textColor: ColorsConstant.pendingStatusText,
        bgColor: ColorsConstant.pendingStatusBg,
      );
    case 'completed' || 'successful':
      return StatusColors(
        textColor: ColorsConstant.completedStatusText,
        bgColor: ColorsConstant.completedStatusBg,
      );
    case 'active':
      return StatusColors(
        textColor: ColorsConstant.activeStatusText,
        bgColor: ColorsConstant.activeStatusBg,
      );
    default:
      return StatusColors(
        textColor: Colors.grey,
        bgColor: Colors.grey.shade200,
      );
  }
}

String getSocialIcon(String name) {
  switch (name.toLowerCase()) {
    case 'tiktok':
      return tiktokIcon;
    case 'youtube':
      return youtubeIcon;
    case 'instagram':
      return instagramIcon;
    case 'x':
      return xIcon;
    case 'whatsapp':
      return whatAppIcon;
    default:
      return tiktokIcon;
  }
}

StatusColors getTaskStatusColors({
  required bool hasSubmittedPerformedTask,
  required bool hasApprovedSubmittedPerformedTask,
  required bool isDue,
}) {
  if (isDue) {
    return StatusColors(
      textColor: ColorsConstant.primaryGreyText,
      bgColor: ColorsConstant.primaryBackground,
    );
  }
  if (!hasSubmittedPerformedTask && !hasApprovedSubmittedPerformedTask) {
    return StatusColors(
      textColor: Colors.white,
      bgColor: ColorsConstant.completedStatusText,
    );
  } else if (hasSubmittedPerformedTask && !hasApprovedSubmittedPerformedTask) {
    return StatusColors(
      textColor: Colors.white,
      bgColor: ColorsConstant.warningColor,
    );
  } else {
    return StatusColors(
      textColor: ColorsConstant.primaryGreyText,
      bgColor: ColorsConstant.primaryBackground,
    );
  }
}

String getTaskStatusText({
  required bool hasSubmittedPerformedTask,
  required bool hasApprovedSubmittedPerformedTask,
  required bool isDue,
}) {
  if (isDue) {
    return 'Not Available';
  }
  if (!hasSubmittedPerformedTask && !hasApprovedSubmittedPerformedTask) {
    return 'Mark Complete';
  } else if (hasSubmittedPerformedTask && !hasApprovedSubmittedPerformedTask) {
    return 'Under Review';
  } else {
    return 'Done';
  }
}

bool isDue(String dateString) {
  try {
    final dueDate = DateTime.parse(dateString);
    final now = DateTime.now();
    return dueDate.isBefore(now) ||
        (dueDate.year == now.year &&
            dueDate.month == now.month &&
            dueDate.day == now.day);
  } catch (e) {
    return false;
  }
}

String getTransactionIcon(String name) {
  switch (name.trim().toLowerCase()) {
    case 'wallet funding':
      return walletFundingIcon;
    case 'order_payment':
      return orderPaymentIcon;
    case 'withdrawal':
      return withdrawalVectorIcon;
    case 'referral bonus':
      return referralIcon;
    default:
      return walletFundingIcon;
  }
}

String getSocialIconWithBg(String name) {
  switch (name.toLowerCase()) {
    case 'tiktok':
      return tiktokWithoutBgIcon;
    case 'youtube':
      return youtubeWithoutBgIcon;
    case 'instagram':
      return InstaWithoutBgIcon;
    case 'x':
      return xWithoutBgIcon;
    case 'facebook':
      return faceBookWithoutBgIcon;
    default:
      return tiktokWithoutBgIcon;
  }
}

String getIconForPromotionType(String type) {
  switch (type) {
    case 'Followers':
      return followerIcon;
    case 'Likes':
      return likesIcon;
    case 'Comments':
      return commentsIcon;
    case 'Shares':
      return shareIcon;
    case 'Views':
      return viewsIcon;
    default:
      return viewsIcon;
  }
}

bool isValidUrl(String url) {
  final regex = RegExp(
    r'^(https?:\/\/)?' // http or https
    r'([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}' // domain
    r'(\/\S*)?$', // optional path
  );

  return regex.hasMatch(url);
}

Widget buildRow({required String label, required Widget value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: ColorsConstant.primaryGreyText,
          ),
        ),
        value,
      ],
    ),
  );
}

String getMonthName(int monthNumber) {
  const monthNames = [
    "", // index 0 ignored to align monthNumber with index
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  if (monthNumber < 1 || monthNumber > 12) {
    return "Invalid month";
  }

  return monthNames[monthNumber];
}

Widget getStatusWiget(String status) {
  switch (status.trim().toLowerCase()) {
    case 'completed' || 'successful':
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.check_circle, color: ColorsConstant.darkerGreen, size: 12),
          SizedBox(width: 5),
          Text(
            'completed',
            style: TextStyle(
              color: ColorsConstant.darkerGreen,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      );
    case 'pending':
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(svgPath: pendingVectorIcon),
          SizedBox(width: 5),
          Text(
            'Pending',
            style: TextStyle(
              color: ColorsConstant.warningColor,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      );
    case 'approved':
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(svgPath: approveVectorIcon),
          SizedBox(width: 5),
          Text(
            'Approved',
            style: TextStyle(
              color: ColorsConstant.activeStatusText,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      );
    default:
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.check_circle, color: ColorsConstant.darkerGreen, size: 12),
          SizedBox(width: 5),
          Text(
            'Completed',
            style: TextStyle(
              color: ColorsConstant.darkerGreen,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      );
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:spotify_downloader/core/presentation/widgets/state_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptShareService {
  /// DOWNLOAD RECEIPT
  static Future<void> downloadReceipt({
    required ScreenshotController screenshotController,
    required String reference,
    required BuildContext context,
  }) async {
    try {
      final Uint8List? image = await screenshotController.capture();

      if (image != null) {
        final directory = await getTemporaryDirectory();
        final path = '${directory.path}/receipt_$reference.png';
        final file = File(path);
        await file.writeAsBytes(image);

        await Gal.putImage(path);

        AppToast.show(
          context,
          message: 'Receipt saved to gallery',
          type: ToastType.success,
        );
      }
    } catch (e) {
      AppToast.show(
        context,
        message: 'Error saving receipt: $e',
        type: ToastType.error,
      );
    }
  }

  /// SHARE RECEIPT
  static Future<void> shareReceipt({
    required ScreenshotController screenshotController,
    required String reference,
    required BuildContext context,
  }) async {
    try {
      final Uint8List? image = await screenshotController.capture();

      if (image != null) {
        final directory = await getTemporaryDirectory();
        final path = '${directory.path}/receipt_$reference.png';
        final file = File(path);
        await file.writeAsBytes(image);

        await Share.shareXFiles([XFile(path)], text: 'Transaction Receipt');
      }
    } catch (e) {
      AppToast.show(
        context,
        message: 'Error sharing receipt: $e',
        type: ToastType.error,
      );
    }
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:spotify_downloader/core/errors/exceptions.dart';

ServerException handleError(DioException error) {
  log("Dio Error: ${error.message}", name: "handleError");

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
      return const ServerException("Connection timed out. Please try again.");
    case DioExceptionType.connectionError:
      return const ServerException("Connection Error. Please try again.");
    case DioExceptionType.unknown:
      return ServerException(
        error.error?.toString() ?? "An unknown error occurred.",
      );
    default:
      log("Unhandled DioException type: ${error.type}");
  }

  final statusCode = error.response?.statusCode?.toString() ?? '0';
  log("Status Code: $statusCode", name: "handleError");

  // final errorMessage = error.response?.data?['message'] ?? "An error occurred.";

  switch (statusCode) {
    case '401':
    case '403': // Unauthorized or forbidden
      return ServerException(
        error.response?.data?['message'] ?? "An error occurred.",
      );
    case '400':
    case '404':
      return ServerException(
        error.response?.data['message'] ?? "An error occurred.",
      );
    case '422': // Validation errors
      return ServerException(
        error.response?.data?['message'] ?? "An error occurred.",
      );
    case '500':
      return const ServerException("Server Error. Please try again later.");
    default:
      if (statusCode.startsWith('4')) {
        return ServerException(
          error.response?.data?['message'] ?? "An error occurred.",
        );
      }
      return const ServerException("An unexpected error occurred.");
  }
}

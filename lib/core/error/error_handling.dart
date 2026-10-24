
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';

class ErrorHandling {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      return _handleRemoteError(exception.toString());
    }

    return const Failure(
      failureMessage: 'Unexpected Error',
    );
  }

  static Failure _handleRemoteError(String message) {
    final errorMessage = message.trim();

    if (errorMessage.contains('401') ||
        errorMessage.contains('Unauthorized') ||
        errorMessage.contains('Unauthenticated')) {
      return const Failure(failureMessage: 'Unauthorized');
    }

    if (errorMessage.contains('403') ||
        errorMessage.contains('Forbidden')) {
      return const Failure(failureMessage: 'Forbidden');
    }

    if (errorMessage.contains('404') ||
        errorMessage.contains('Not Found')) {
      return const Failure(failureMessage: '404 Not Found');
    }

    if (errorMessage.contains('422') ||
        errorMessage.contains('Unprocessable Content')) {
      return const Failure(
        failureMessage: 'Unprocessable Content',
      );
    }

    // Default case: return a Failure if no condition matches.
    return const Failure(
      failureMessage: 'Unexpected Error',
    );
  }
}

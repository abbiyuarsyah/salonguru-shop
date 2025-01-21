import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salonguru_shop/core/extensions/error_extension.dart';
import 'package:salonguru_shop/core/extensions/number_formatter.dart';
import 'package:salonguru_shop/core/utils/execptions.dart';

void main() {
  String normalize(String input) {
    return input.replaceAll('\u00A0', ' ').trim();
  }

  test('get the string of network connection error', () {
    final NetworkFailure networkFailure = NetworkFailure();

    final result = networkFailure.message;

    expect(result, tr('network_error'));
  });

  test('get http failure call', () {
    final BadRequestFailure badRequestFailure = BadRequestFailure();

    const responseCode = 400;
    final failure = responseCode.httpErrorToFailure;

    expect(failure, badRequestFailure);
  });

  test('get string euro currency format', () {
    const num value = 2.99;
    const String expected = '2,99 €';

    final String actual = value.toEuroFormat;

    expect(normalize(actual), normalize(expected));
  });
}

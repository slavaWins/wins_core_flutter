//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars


import 'ApiHelperFormly.dart';
import 'FormlyFieldResponse.dart';

class ResponseContractOfFormlyFieldResponse {
  /// Returns a new [ResponseContractOfFormlyFieldResponse] instance.
  ResponseContractOfFormlyFieldResponse({
    this.value,
    this.errorMessage,
    this.keyError,
    this.isSuccess,
  });

  FormlyFieldResponse? value;

  String? errorMessage;

  String? keyError;

  /// Успешный ли ответ
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isSuccess;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResponseContractOfFormlyFieldResponse &&
      other.value == value &&
      other.errorMessage == errorMessage &&
      other.keyError == keyError &&
      other.isSuccess == isSuccess;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
  (value == null ? 0 : value!.hashCode) +
      (errorMessage == null ? 0 : errorMessage!.hashCode) +
      (keyError == null ? 0 : keyError!.hashCode) +
      (isSuccess == null ? 0 : isSuccess!.hashCode);

  @override
  String toString() => 'ResponseContractOfFormlyFieldResponse[value=$value, errorMessage=$errorMessage, keyError=$keyError, isSuccess=$isSuccess]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.value != null) {
      json[r'value'] = this.value;
    } else {
      json[r'value'] = null;
    }
    if (this.errorMessage != null) {
      json[r'errorMessage'] = this.errorMessage;
    } else {
      json[r'errorMessage'] = null;
    }
    if (this.keyError != null) {
      json[r'keyError'] = this.keyError;
    } else {
      json[r'keyError'] = null;
    }
    if (this.isSuccess != null) {
      json[r'isSuccess'] = this.isSuccess;
    } else {
      json[r'isSuccess'] = null;
    }
    return json;
  }

  /// Returns a new [ResponseContractOfFormlyFieldResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResponseContractOfFormlyFieldResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ResponseContractOfFormlyFieldResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ResponseContractOfFormlyFieldResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResponseContractOfFormlyFieldResponse(
        value: FormlyFieldResponse.fromJson(json[r'value']),
        errorMessage: mapValueOfType<String>(json, r'errorMessage'),
        keyError: mapValueOfType<String>(json, r'keyError'),
        isSuccess: mapValueOfType<bool>(json, r'isSuccess'),
      );
    }
    return null;
  }

  static List<ResponseContractOfFormlyFieldResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResponseContractOfFormlyFieldResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResponseContractOfFormlyFieldResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResponseContractOfFormlyFieldResponse> mapFromJson(dynamic json) {
    final map = <String, ResponseContractOfFormlyFieldResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResponseContractOfFormlyFieldResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResponseContractOfFormlyFieldResponse-objects as value to a dart map
  static Map<String, List<ResponseContractOfFormlyFieldResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResponseContractOfFormlyFieldResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ResponseContractOfFormlyFieldResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars


import 'ApiHelperFormly.dart';
import 'FormlyField.dart';

class FormlyFieldResponse {
  /// Returns a new [FormlyFieldResponse] instance.
  FormlyFieldResponse({
    this.values,
    this.btnName,
    this.formlyFields = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Object? values;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? btnName;

  List<FormlyField> formlyFields;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FormlyFieldResponse &&
      other.values == values &&
      other.btnName == btnName ;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
  (values == null ? 0 : values!.hashCode) +
      (btnName == null ? 0 : btnName!.hashCode) +
      (formlyFields.hashCode);

  @override
  String toString() => 'FormlyFieldResponse[values=$values, btnName=$btnName, formlyFields=$formlyFields]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.values != null) {
      json[r'values'] = this.values;
    } else {
      json[r'values'] = null;
    }
    if (this.btnName != null) {
      json[r'btnName'] = this.btnName;
    } else {
      json[r'btnName'] = null;
    }
    json[r'formlyFields'] = this.formlyFields;
    return json;
  }

  /// Returns a new [FormlyFieldResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FormlyFieldResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FormlyFieldResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FormlyFieldResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FormlyFieldResponse(
        values: mapValueOfType<Object>(json, r'values'),
        btnName: mapValueOfType<String>(json, r'btnName'),
        formlyFields: FormlyField.listFromJson(json[r'formlyFields']),
      );
    }
    return null;
  }

  static List<FormlyFieldResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FormlyFieldResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FormlyFieldResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FormlyFieldResponse> mapFromJson(dynamic json) {
    final map = <String, FormlyFieldResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FormlyFieldResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FormlyFieldResponse-objects as value to a dart map
  static Map<String, List<FormlyFieldResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FormlyFieldResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FormlyFieldResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


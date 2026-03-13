//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars


import 'ApiHelperFormly.dart';
import 'OptionFormly.dart';

class FormlyProps {
  /// Returns a new [FormlyProps] instance.
  FormlyProps({
    this.minLength,
    this.maxLength,
    this.label,
    this.endWith,
    this.startWith,
    this.description,
    this.placeholder,
    this.required_,
    this.options = const [],
  });

  int? minLength;

  int? maxLength;

  String? label;
  String? endWith;
  String? startWith;

  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? placeholder;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? required_;

  List<OptionFormly> options;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FormlyProps &&
      other.minLength == minLength &&
      other.maxLength == maxLength &&
      other.label == label &&
      other.description == description &&
      other.placeholder == placeholder &&
      other.required_ == required_;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
  (minLength == null ? 0 : minLength!.hashCode) +
      (maxLength == null ? 0 : maxLength!.hashCode) +
      (label == null ? 0 : label!.hashCode) +
      (description == null ? 0 : description!.hashCode) +
      (placeholder == null ? 0 : placeholder!.hashCode) +
      (required_ == null ? 0 : required_!.hashCode) +
      (options.hashCode);

  @override
  String toString() => 'FormlyProps[minLength=$minLength, maxLength=$maxLength, label=$label, description=$description, placeholder=$placeholder, required_=$required_, options=$options]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.minLength != null) {
      json[r'minLength'] = this.minLength;
    } else {
      json[r'minLength'] = null;
    }
    if (this.maxLength != null) {
      json[r'maxLength'] = this.maxLength;
    } else {
      json[r'maxLength'] = null;
    }
    if (this.label != null) {
      json[r'label'] = this.label;
    } else {
      json[r'label'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.placeholder != null) {
      json[r'placeholder'] = this.placeholder;
    } else {
      json[r'placeholder'] = null;
    }
    if (this.required_ != null) {
      json[r'required'] = this.required_;
    } else {
      json[r'required'] = null;
    }
    json[r'options'] = this.options;
    return json;
  }

  /// Returns a new [FormlyProps] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FormlyProps? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FormlyProps[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FormlyProps[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FormlyProps(
        minLength: mapValueOfType<int>(json, r'minLength'),
        maxLength: mapValueOfType<int>(json, r'maxLength'),
        label: mapValueOfType<String>(json, r'label'),
        startWith: mapValueOfType<String>(json, r'startWith'),
        endWith: mapValueOfType<String>(json, r'endWith'),
        description: mapValueOfType<String>(json, r'description'),
        placeholder: mapValueOfType<String>(json, r'placeholder'),
        required_: mapValueOfType<bool>(json, r'required'),
        options: OptionFormly.listFromJson(json[r'options']),
      );
    }
    return null;
  }

  static List<FormlyProps> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FormlyProps>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FormlyProps.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FormlyProps> mapFromJson(dynamic json) {
    final map = <String, FormlyProps>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FormlyProps.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FormlyProps-objects as value to a dart map
  static Map<String, List<FormlyProps>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FormlyProps>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FormlyProps.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


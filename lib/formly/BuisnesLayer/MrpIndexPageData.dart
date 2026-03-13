//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars


import 'ApiHelperFormly.dart';
import 'MrpTab.dart';

class MrpIndexPageData {
  /// Returns a new [MrpIndexPageData] instance.
  MrpIndexPageData({
    this.pageName,
    this.tabs = const [],
    this.project,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? pageName;

  List<MrpTab> tabs;

  Object? project;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MrpIndexPageData &&
      other.pageName == pageName &&
      other.project == project;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
  (pageName == null ? 0 : pageName!.hashCode) +
      (tabs.hashCode) +
      (project == null ? 0 : project!.hashCode);

  @override
  String toString() => 'MrpIndexPageData[pageName=$pageName, tabs=$tabs, project=$project]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.pageName != null) {
      json[r'pageName'] = this.pageName;
    } else {
      json[r'pageName'] = null;
    }
    json[r'tabs'] = this.tabs;
    if (this.project != null) {
      json[r'project'] = this.project;
    } else {
      json[r'project'] = null;
    }
    return json;
  }

  /// Returns a new [MrpIndexPageData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MrpIndexPageData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MrpIndexPageData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MrpIndexPageData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MrpIndexPageData(
        pageName: mapValueOfType<String>(json, r'pageName'),
        tabs: MrpTab.listFromJson(json[r'tabs']),
        project: mapValueOfType<Object>(json, r'project'),
      );
    }
    return null;
  }

  static List<MrpIndexPageData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MrpIndexPageData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MrpIndexPageData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MrpIndexPageData> mapFromJson(dynamic json) {
    final map = <String, MrpIndexPageData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MrpIndexPageData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MrpIndexPageData-objects as value to a dart map
  static Map<String, List<MrpIndexPageData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MrpIndexPageData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MrpIndexPageData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_setting.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $LayoutSettingLocalAdapter on LocalAdapter<LayoutSetting> {
  static final Map<String, RelationshipMeta> _kLayoutSettingRelationshipMetas =
      {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kLayoutSettingRelationshipMetas;

  @override
  LayoutSetting deserialize(map) {
    map = transformDeserialize(map);
    return _$LayoutSettingFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$LayoutSettingToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _layoutSettingsFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $LayoutSettingHiveLocalAdapter = HiveLocalAdapter<LayoutSetting>
    with $LayoutSettingLocalAdapter;

class $LayoutSettingRemoteAdapter = RemoteAdapter<LayoutSetting>
    with NothingMixin;

final internalLayoutSettingsRemoteAdapterProvider =
    Provider<RemoteAdapter<LayoutSetting>>((ref) => $LayoutSettingRemoteAdapter(
        $LayoutSettingHiveLocalAdapter(ref.read),
        InternalHolder(_layoutSettingsFinders)));

final layoutSettingsRepositoryProvider = Provider<Repository<LayoutSetting>>(
    (ref) => Repository<LayoutSetting>(ref.read));

extension LayoutSettingDataRepositoryX on Repository<LayoutSetting> {}

extension LayoutSettingRelationshipGraphNodeX
    on RelationshipGraphNode<LayoutSetting> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayoutSetting _$LayoutSettingFromJson(Map<String, dynamic> json) =>
    LayoutSetting(
      activityVisibility: $enumDecodeNullable(
              _$ActivityVisibilityEnumMap, json['activityVisibility']) ??
          ActivityVisibility.visible,
      primaryVisibility: $enumDecodeNullable(
              _$PrimaryVisibilityEnumMap, json['primaryVisibility']) ??
          PrimaryVisibility.visible,
      secondVisibility: $enumDecodeNullable(
              _$SecondVisibilityEnumMap, json['secondVisibility']) ??
          SecondVisibility.hidden,
      panelVisibility: $enumDecodeNullable(
              _$PanelVisibilityEnumMap, json['panelVisibility']) ??
          PanelVisibility.hidden,
      primaryPosition: $enumDecodeNullable(
              _$PrimaryPositionEnumMap, json['primaryPosition']) ??
          PrimaryPosition.left,
      panelAlignment: $enumDecodeNullable(
              _$PanelAlignmentEnumMap, json['panelAlignment']) ??
          PanelAlignment.center,
    );

Map<String, dynamic> _$LayoutSettingToJson(LayoutSetting instance) =>
    <String, dynamic>{
      'activityVisibility':
          _$ActivityVisibilityEnumMap[instance.activityVisibility],
      'primaryVisibility':
          _$PrimaryVisibilityEnumMap[instance.primaryVisibility],
      'secondVisibility': _$SecondVisibilityEnumMap[instance.secondVisibility],
      'panelVisibility': _$PanelVisibilityEnumMap[instance.panelVisibility],
      'primaryPosition': _$PrimaryPositionEnumMap[instance.primaryPosition],
      'panelAlignment': _$PanelAlignmentEnumMap[instance.panelAlignment],
    };

const _$ActivityVisibilityEnumMap = {
  ActivityVisibility.visible: 'visible',
  ActivityVisibility.hidden: 'hidden',
};

const _$PrimaryVisibilityEnumMap = {
  PrimaryVisibility.visible: 'visible',
  PrimaryVisibility.hidden: 'hidden',
};

const _$SecondVisibilityEnumMap = {
  SecondVisibility.visible: 'visible',
  SecondVisibility.hidden: 'hidden',
};

const _$PanelVisibilityEnumMap = {
  PanelVisibility.visible: 'visible',
  PanelVisibility.hidden: 'hidden',
};

const _$PrimaryPositionEnumMap = {
  PrimaryPosition.left: 'left',
  PrimaryPosition.right: 'right',
};

const _$PanelAlignmentEnumMap = {
  PanelAlignment.left: 'left',
  PanelAlignment.right: 'right',
  PanelAlignment.center: 'center',
  PanelAlignment.justify: 'justify',
};

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Cell {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cell);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Cell()';
}


}

/// @nodoc
class $CellCopyWith<$Res>  {
$CellCopyWith(Cell _, $Res Function(Cell) __);
}


/// @nodoc


class Cell_Empty extends Cell {
  const Cell_Empty(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cell_Empty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Cell.empty()';
}


}




/// @nodoc


class Cell_Filled extends Cell {
  const Cell_Filled(this.field0): super._();
  

 final  Player field0;

/// Create a copy of Cell
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Cell_FilledCopyWith<Cell_Filled> get copyWith => _$Cell_FilledCopyWithImpl<Cell_Filled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cell_Filled&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Cell.filled(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Cell_FilledCopyWith<$Res> implements $CellCopyWith<$Res> {
  factory $Cell_FilledCopyWith(Cell_Filled value, $Res Function(Cell_Filled) _then) = _$Cell_FilledCopyWithImpl;
@useResult
$Res call({
 Player field0
});




}
/// @nodoc
class _$Cell_FilledCopyWithImpl<$Res>
    implements $Cell_FilledCopyWith<$Res> {
  _$Cell_FilledCopyWithImpl(this._self, this._then);

  final Cell_Filled _self;
  final $Res Function(Cell_Filled) _then;

/// Create a copy of Cell
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Cell_Filled(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as Player,
  ));
}


}

// dart format on

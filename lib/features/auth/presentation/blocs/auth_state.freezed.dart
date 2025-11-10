// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( SuccessfulLogin value)?  successfulLogin,TResult Function( SuccessfulRegister value)?  successfulRegister,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case SuccessfulLogin() when successfulLogin != null:
return successfulLogin(_that);case SuccessfulRegister() when successfulRegister != null:
return successfulRegister(_that);case Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( SuccessfulLogin value)  successfulLogin,required TResult Function( SuccessfulRegister value)  successfulRegister,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case SuccessfulLogin():
return successfulLogin(_that);case SuccessfulRegister():
return successfulRegister(_that);case Error():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( SuccessfulLogin value)?  successfulLogin,TResult? Function( SuccessfulRegister value)?  successfulRegister,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case SuccessfulLogin() when successfulLogin != null:
return successfulLogin(_that);case SuccessfulRegister() when successfulRegister != null:
return successfulRegister(_that);case Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( AuthSession authSession)?  successfulLogin,TResult Function( User user)?  successfulRegister,TResult Function( String failureKey)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case SuccessfulLogin() when successfulLogin != null:
return successfulLogin(_that.authSession);case SuccessfulRegister() when successfulRegister != null:
return successfulRegister(_that.user);case Error() when error != null:
return error(_that.failureKey);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( AuthSession authSession)  successfulLogin,required TResult Function( User user)  successfulRegister,required TResult Function( String failureKey)  error,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Loading():
return loading();case SuccessfulLogin():
return successfulLogin(_that.authSession);case SuccessfulRegister():
return successfulRegister(_that.user);case Error():
return error(_that.failureKey);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( AuthSession authSession)?  successfulLogin,TResult? Function( User user)?  successfulRegister,TResult? Function( String failureKey)?  error,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case SuccessfulLogin() when successfulLogin != null:
return successfulLogin(_that.authSession);case SuccessfulRegister() when successfulRegister != null:
return successfulRegister(_that.user);case Error() when error != null:
return error(_that.failureKey);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements AuthState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class Loading implements AuthState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class SuccessfulLogin implements AuthState {
  const SuccessfulLogin(this.authSession);
  

 final  AuthSession authSession;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessfulLoginCopyWith<SuccessfulLogin> get copyWith => _$SuccessfulLoginCopyWithImpl<SuccessfulLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessfulLogin&&(identical(other.authSession, authSession) || other.authSession == authSession));
}


@override
int get hashCode => Object.hash(runtimeType,authSession);

@override
String toString() {
  return 'AuthState.successfulLogin(authSession: $authSession)';
}


}

/// @nodoc
abstract mixin class $SuccessfulLoginCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $SuccessfulLoginCopyWith(SuccessfulLogin value, $Res Function(SuccessfulLogin) _then) = _$SuccessfulLoginCopyWithImpl;
@useResult
$Res call({
 AuthSession authSession
});




}
/// @nodoc
class _$SuccessfulLoginCopyWithImpl<$Res>
    implements $SuccessfulLoginCopyWith<$Res> {
  _$SuccessfulLoginCopyWithImpl(this._self, this._then);

  final SuccessfulLogin _self;
  final $Res Function(SuccessfulLogin) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? authSession = null,}) {
  return _then(SuccessfulLogin(
null == authSession ? _self.authSession : authSession // ignore: cast_nullable_to_non_nullable
as AuthSession,
  ));
}


}

/// @nodoc


class SuccessfulRegister implements AuthState {
  const SuccessfulRegister(this.user);
  

 final  User user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessfulRegisterCopyWith<SuccessfulRegister> get copyWith => _$SuccessfulRegisterCopyWithImpl<SuccessfulRegister>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessfulRegister&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.successfulRegister(user: $user)';
}


}

/// @nodoc
abstract mixin class $SuccessfulRegisterCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $SuccessfulRegisterCopyWith(SuccessfulRegister value, $Res Function(SuccessfulRegister) _then) = _$SuccessfulRegisterCopyWithImpl;
@useResult
$Res call({
 User user
});




}
/// @nodoc
class _$SuccessfulRegisterCopyWithImpl<$Res>
    implements $SuccessfulRegisterCopyWith<$Res> {
  _$SuccessfulRegisterCopyWithImpl(this._self, this._then);

  final SuccessfulRegister _self;
  final $Res Function(SuccessfulRegister) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(SuccessfulRegister(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}


}

/// @nodoc


class Error implements AuthState {
  const Error(this.failureKey);
  

 final  String failureKey;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.failureKey, failureKey) || other.failureKey == failureKey));
}


@override
int get hashCode => Object.hash(runtimeType,failureKey);

@override
String toString() {
  return 'AuthState.error(failureKey: $failureKey)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String failureKey
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failureKey = null,}) {
  return _then(Error(
null == failureKey ? _self.failureKey : failureKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

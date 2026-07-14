import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/home_entity.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
 
  const factory HomeState.initial() = _Initial;

  const factory HomeState.loading() = _Loading;

  const factory HomeState.success(HomeEntity data) = _Success;

  const factory HomeState.failure(String error) = _Failure;

}

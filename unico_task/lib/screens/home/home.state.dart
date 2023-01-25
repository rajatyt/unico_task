import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:unico_task/models/products.model.dart';

part 'home.state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default(false) bool isLoading,
    @Default("") String username,
    @Default("") String email,
    @Default("") String profilePic,
    ProductModel? products,
  }) = _HomePageState;
}

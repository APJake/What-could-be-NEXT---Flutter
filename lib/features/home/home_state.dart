class HomeState {
  final bool isLoading;
  final String? errorMessage;

  HomeState({this.isLoading = false, this.errorMessage});

  HomeState copyWith({bool? isLoading, String? errorMessage}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

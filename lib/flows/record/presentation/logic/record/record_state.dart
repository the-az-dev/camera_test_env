part of 'record_cubit.dart';

enum RecordStatus {init, loading, success, failure}

class RecordState extends Equatable {
  const RecordState({
    this.status = RecordStatus.init,
    this.cameraController,
    this.cameras = const [],
    this.selectedCamera = 0,
    this.scrollSpeed = 0.0,
    this.scrollTimeMill = 0,
    this.currentScroll = 0.0,
    this.errorMessage,
  });

  final RecordStatus status;
  final CameraController? cameraController;
  final List<CameraDescription> cameras;
  final int selectedCamera;
  final double scrollSpeed;
  final int scrollTimeMill; // duration in milliseconds
  final double currentScroll;
  final String? errorMessage;

  bool get isLoading => status == RecordStatus.loading;

  RecordState copyWith({
      RecordStatus? status,

      CameraController? cameraController,
      List<CameraDescription>? cameras,
      int? selectedCamera,
      String? errorMessage
  }){
    return RecordState(
      status: status ?? this.status,
      cameraController: cameraController ?? this.cameraController,
      cameras: cameras ?? this.cameras,
      selectedCamera: selectedCamera ?? this.selectedCamera,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, cameras, errorMessage];
}
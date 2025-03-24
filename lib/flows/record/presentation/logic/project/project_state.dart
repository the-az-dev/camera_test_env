part of 'project_cubit.dart';

enum ProjectStatus {init, loading, success, failure}

class ProjectState extends Equatable {
  const ProjectState({
    this.status = ProjectStatus.init,
    this.projectName = 'Empty project',
    this.promptContent = '''Lorem ipsum dolor sit amet consectetur. 
    Vehicula lacus cursus amet adipiscing habitasse pharetra. 
    Faucibus in faucibus sollicitudin proin lectus sed posuere quis. 
    Eu commodo a pretium felis gravida. 
    Felis vel egestas tincidunt sem.''',
    this.promptPosition = 0,
    this.fontSize = 0,
    this.startPoint = 0,
    this.countDown = 0,
    this.errorMessage,
  });

  final ProjectStatus status;
  final String projectName;
  final String promptContent;
  final int promptPosition;
  final int fontSize;
  final int startPoint; /// NOTE: Need to check if is it comfortable
  final int countDown;
  final String? errorMessage;

  bool get isLoading => status == ProjectStatus.loading;

  ProjectState copyWith({
    ProjectStatus? status,
    String? projectName,
    String? promptContent,
    int? promptPosition,
    int? fontSize,
    int? startPoint,
    int? countDown,
    String? errorMessage
  }){
    return ProjectState(
      status: status ?? this.status,
      projectName: projectName ?? this.projectName,
      promptContent: promptContent ?? this.promptContent,
      promptPosition: promptPosition ?? this.promptPosition,
      fontSize: fontSize ?? this.fontSize,
      startPoint: startPoint ?? this.startPoint,
      countDown: countDown ?? this.countDown,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [
    status,
    projectName,
    promptContent,
    promptPosition,
    fontSize,
    startPoint,
    countDown,
    errorMessage,
  ];
}
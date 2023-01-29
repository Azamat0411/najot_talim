abstract class DownloadStates {}

class StateLoadPage extends DownloadStates {
  final int currentPage;
  StateLoadPage({required this.currentPage});
}

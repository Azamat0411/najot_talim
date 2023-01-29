abstract class HomeEvents {}

class EventInitial extends HomeEvents {}

class EventBottomClicked extends HomeEvents {
  final int currentPage;

  EventBottomClicked({required this.currentPage});
}

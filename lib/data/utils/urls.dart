class Urls{
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static String registration = "$_baseUrl/registration";
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTasks = '$_baseUrl/listTaskByStatus/New';
  static String inProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static String cancelTasks = '$_baseUrl/listTaskByStatus/Cancelled';
  static String completeTasks = '$_baseUrl/listTaskByStatus/Completed';
}
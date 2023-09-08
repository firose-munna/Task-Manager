class Urls{
  static const String _baseUrl = "This is base URL";
  static String registration = "$_baseUrl/registration";
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTasks = '$_baseUrl/listTaskByStatus/New';
  static String inProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static String cancelTasks = '$_baseUrl/listTaskByStatus/Canceled';
  static String completeTasks = '$_baseUrl/listTaskByStatus/Completed';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTask(String id, String status) => '$_baseUrl/updateTaskStatus/$id/$status';
  static String updateProfile = '$_baseUrl/profileUpdate';
  static String sendOtpToEmail(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String otpVerify(String email, String otp) => '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static String resetPassword = '$_baseUrl/RecoverResetPass';
}

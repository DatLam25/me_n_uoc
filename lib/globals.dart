library globals;
CurrentUser currentUser = CurrentUser(false, "", false);
class CurrentUser
{
  bool isLoggedIn;
  String username;
  bool isAdmin;

  CurrentUser(this.isLoggedIn, this.username, this.isAdmin);
}
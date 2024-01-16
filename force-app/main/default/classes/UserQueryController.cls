public with Sharing  class UserQueryController {
@AuraEnabled(cacheable=true)
   public static List<User> getInactiveUsers() {
     return [SELECT Id, Name, Profile.Name, UserRole.Name FROM User WHERE IsActive = false];
    }
}
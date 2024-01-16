public class PropertyCreationController {
	  @AuraEnabled(cacheable=true)
    public static user getUserInfo() {
        String userId = UserInfo.getUserId(); // current user
        return [SELECT ID, FirstName, LastName, Name, Title, Profile.Name,  Email , Inventory_Access__c From User WHERE ID =: userId LIMIT 1];
       
    }
}
@isTest
public class PropertyCreationControllerTestClass {
    
    @isTest
    public static void getUserInfo(){
        
            Profile pf= [Select Id from profile where Name='System Administrator']; 
    
    String orgId=UserInfo.getOrganizationId(); 
    String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
    Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
    String uniqueName=orgId+dateString+RandomId; 
    User uu=new User(firstname = 'Benedict',  
                     lastName = 'Texeira', 
                     email = 'Harish@gmail.com', 
                     Username = 'Texeira@sfdc.dev', 
                     EmailEncodingKey = 'ISO-8859-1', 
                     Alias = uniqueName.substring(18, 23), 
                     TimeZoneSidKey = 'America/Los_Angeles', 
                     LocaleSidKey = 'en_US', 
                     LanguageLocaleKey = 'en_US', 
                     gsir_company__c= 'Gulf Sotheby\'s',
                     ProfileId = pf.Id
                    );
    insert uu;

    
    
    List<PermissionSet> PST = [SELECT Id from PermissionSet WHERE IsCustom = True AND LicenseId = Null];
    List<PermissionSetAssignment> PSA = New List<PermissionSetAssignment>();
    for(PermissionSet ps: pst){
        PSA.add(new PermissionSetAssignment(
            AssigneeId = uu.Id,
            PermissionSetId = ps.Id));
        
    }
    insert PSA;
        
        PropertyCreationController.getUserInfo();
    }

}
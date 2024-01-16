@isTest
public class Test_BatchEmail {
    
    @TestSetup
    static void SetupMethod(){
        
        
        Profile pf= [Select Id from profile where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId = Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName = orgId+dateString+RandomId; 
        User uu = new User(firstname = 'Benedict',  
                           lastName = 'Texeira', 
                           email = 'vijay@gmail.com', 
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
        
        
        Emailtemplate emailtemplateObj = new Emailtemplate ();
        emailtemplateObj.Subject = 'test value'; 
        emailtemplateObj.Body = 'Test Value'; 
        emailtemplateObj.Name = 'test value';
        emailtemplateObj.DeveloperName = 'Test_value';
        emailtemplateObj.TemplateType = 'text';
        emailtemplateObj.FolderId = UserInfo.getUserId();
        insert emailtemplateObj;
        
    }
    
    @isTest
    public static void test1(){
        
        User user1 = [SELECT Id,Email FROM User WHERE UserName = 'Texeira@sfdc.dev'];
        
        date expdate = system.today() +1;
        
        CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project1';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name = 'Test property1';
        prop.CD_Project__c = proj.id;
        prop.CD_isblocked__c = true;
        prop.CD_Unit_Number__c = 'Test Unit Number';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        
        CD_Approval_Request__c aprReq = new CD_Approval_Request__c();
        aprReq.CD_Expiry_Date__c = expdate;
        aprReq.CD_Blocking_Comments__c = 'test comment1';
        aprReq.CD_Status__c = 'Pending';
        aprReq.Property__c = prop.Id;
        aprReq.CD_Approver_Name__c = user1.Id;
        aprReq.CD_Agent_Name__c = user1.Id;
        
        insert aprReq;
        
        
        Test.startTest();
        BatchEmail  ApReq   = new BatchEmail();
        Database.executeBatch(ApReq);
        Test.stopTest();
        
    }
}
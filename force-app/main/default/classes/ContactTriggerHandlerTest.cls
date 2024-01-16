@isTest
public class ContactTriggerHandlerTest {
    @isTest
    Public static void createcontact_when_trigger_is_active()
    {
        //Create Custom Setting 
        Trigger_Setting__c cs=new Trigger_Setting__c();
        cs.Is_Contact_Trigger_Inactive__c=false;
        cs.SetupOwnerId = UserInfo.getOrganizationId();
        insert cs;
        
        //Create new Contact Record
        Contact con=new Contact();
        con.firstName='Test';
        con.LastName='ABC';
        Con.Phone='12356';
        con.Mobile_country_code__c='+93';
        con.ContactType__c='Buyer';
        insert con;
        
        //Create new Contact and Update Mobile Country Code
        Contact t1=new Contact();
        t1.Id=con.Id;
        t1.Mobile_country_code__c='+221';
        update t1;
      
    }  
    
    @isTest
    Public static void createcontact_when_trigger_is_inactive()
    {
        //Create Custom Setting 
        Trigger_Setting__c cs=new Trigger_Setting__c();
        cs.Is_Contact_Trigger_Inactive__c=true;
        cs.SetupOwnerId = UserInfo.getOrganizationId();
        insert cs;
        
        //Create new Contact Record
        Contact con=new Contact();
        con.firstName='Test';
        con.LastName='ABC';
        Con.Phone='12356';
        con.Mobile_country_code__c='+93';
        con.ContactType__c='Buyer';
        insert con;
        
        //Create new Contact and Update Mobile Country Code
        Contact t1=new Contact();
        t1.Id=con.Id;
        t1.Mobile_country_code__c='+221';
        update t1;
      
    }    
}
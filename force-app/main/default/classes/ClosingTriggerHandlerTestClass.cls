@isTest
public class ClosingTriggerHandlerTestClass {
    
    @testSetup static void setupmethod() {
        Profile pf= [Select Id from profile where Name='System Administrator']; 
        
        String orgId=UserInfo.getOrganizationId(); 
        String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName=orgId+dateString+RandomId; 
        User uu=new User(firstname = 'Benedict',  
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
        
         Profile pf2= [Select Id from profile where Name='System Administrator']; 
        
        String orgId2=UserInfo.getOrganizationId(); 
        String dateString2=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId2=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName2=orgId2+dateString+RandomId2; 
        User uuu=new User(firstname = 'Benedict',  
                         lastName = 'Texeira', 
                         email = 'vijay@gmail.com', 
                         Username = 'Texetestira@sfdc.dev', 
                         EmailEncodingKey = 'ISO-8859-1', 
                         Alias = uniqueName2.substring(18, 23), 
                         TimeZoneSidKey = 'America/Los_Angeles', 
                         LocaleSidKey = 'en_US', 
                         LanguageLocaleKey = 'en_US', 
                         gsir_company__c= 'Gulf Sotheby\'s',
                         ProfileId = pf2.Id
                        ); 
        
        
        insert uuu;
        
       
        
       
        
        List<PermissionSet> PST = [SELECT Id from PermissionSet WHERE IsCustom = True AND LicenseId = Null];
        List<PermissionSetAssignment> PSA = New List<PermissionSetAssignment>();
        for(PermissionSet ps: pst){
            PSA.add(new PermissionSetAssignment(
                AssigneeId = uu.Id,
                PermissionSetId = ps.Id));
           
        }
        insert PSA;
       
        
    }
    
    @isTest
    public static void test_closingUpdate(){
        
        user u1 =[select id from user WHERE UserName='Texeira@sfdc.dev' limit 1];
       
        contact con = new contact();
        con.LastName = 'Test Contact';
        insert con;
        
        pba__Request__c inquiry = new pba__Request__c();
        inquiry.pba__Contact__c = con.Id;
        inquiry.InquiryType__c ='Seller';
        insert inquiry;
        
        list<pba__Closing__c> closeLists = new list<pba__Closing__c>();
        pba__Closing__c  closeList = new pba__Closing__c();
        closeList.Winning_Inquiry__c =inquiry.id;
        closeList.Listing_Type__c ='sale';
        closeList.TargetClosingDate__c = system.today() + 30;
        closeList.gsir_fourth_broker__c = u1.id;
        closeList.gsir_second_broker__c = u1.id;
        closeList.gsir_third_broker__c = u1.id;
        closeList.gsir_closing_broker__c = u1.id;
        closeList.External_Party_Commission__c= 20;
        closeList.gsir_second_broker_split_amount__c=15;
        closeList.gsir_third_broker_split_amount__c=10;
        closeList.gsir_fourth_broker_split_amount__c=5;
        closeList.External_Party_Name__c = 'Sales Broker';
        closeLists.add(closeList);
        
        insert closeLists;
        closingTriggerHandler clsup = new closingTriggerHandler();
        clsup.closingUpdate(closeLists);
        

    }
    
   
    
    @istest
    public static void test_onClosingUpdate()
    {
        user u1 =[select id from user WHERE UserName='Texeira@sfdc.dev' limit 1];
        // Texetestira@sfdc.dev
         user u2 =[select id from user WHERE UserName='Texetestira@sfdc.dev' limit 1];
        contact con = new contact();
        con.LastName = 'Test Contact';
        insert con;
        
        pba__Request__c inquiry = new pba__Request__c();
        inquiry.pba__Contact__c = con.Id;
        inquiry.InquiryType__c ='Seller';
        insert inquiry;
        list<pba__Closing__c> closeLists = new list<pba__Closing__c>();
        pba__Closing__c  closeList = new pba__Closing__c();
        closeList.Winning_Inquiry__c =inquiry.id;
        closeList.Listing_Type__c ='sale';
        closeList.TargetClosingDate__c = system.today() + 30;
        closeList.External_Party_Commission__c= 20;
        closeList.gsir_fourth_broker__c = u1.Id;
        closeList.gsir_second_broker__c = u1.id;
        closeList.gsir_third_broker__c = u1.id;
        closeList.gsir_closing_broker__c = u1.id;
        closeList.gsir_second_broker_split_amount__c=15;
        closeList.gsir_third_broker_split_amount__c=10;
        closeList.gsir_fourth_broker_split_amount__c=5;
        closeList.External_Party_Name__c = 'Sales Broker';
        closeLists.add(closeList);
        insert closeLists;
  
        pba__Closing__c updateClosing =[select id,gsir_third_broker_split_amount__c from pba__Closing__c where id=:closeLists[0].Id];
        
        updateClosing.gsir_third_broker_split_amount__c = 30;
        updateClosing.gsir_fourth_broker__c =u2.Id;
         updateClosing.gsir_second_broker__c = u2.id;
        updateClosing.gsir_third_broker__c = u2.id;
        updateClosing.gsir_closing_broker__c = u2.id;
        update updateClosing;
        system.debug('getting updated id'+updateClosing.id);
        system.debug('show user id of new'+updateClosing.gsir_fourth_broker__c);
        map<id,pba__Closing__c> newMap = new map<id,pba__Closing__c>();
        newmap.put(updateClosing.id,updateClosing);
        map<id,pba__Closing__c> oldMap = new map<id,pba__Closing__c>();
        oldMap.put(closeList.id,closeList);
         pba__Closing__Share closShare = new pba__Closing__Share ();
             closShare.ParentId = closeList.Id;
         closShare.UserOrGroupId = closeList.gsir_fourth_broker__c;
          closShare.RowCause = 'manual';
          closShare.AccessLevel= 'Read';
           insert closShare; 
         pba__Closing__Share closShare2 = new pba__Closing__Share ();
             closShare2.ParentId = closeList.Id;
         closShare2.UserOrGroupId = updateClosing.gsir_fourth_broker__c;
          closShare2.RowCause = 'manual';
          closShare2.AccessLevel= 'Read';
           insert closShare2; 
         set<id> closingIdSet = new set<id>();
        Set<Id> newUserIdSet = new Set<Id>();
        Set<Id> oldClsIdset =  new set<id>();
        Set<id> oldUserIdSet = new set<Id>();
         List<pba__Closing__share> insertCloseShareList = new List<pba__Closing__share>();
        insertCloseShareList.add(closShare2);
        List<pba__Closing__share> deleteCloseShareList = new List<pba__Closing__share>();
        deleteCloseShareList.add(closShare);

        
        system.debug('gettingg closeshare id'+closShare.id);
        closingTriggerHandler clsup = new closingTriggerHandler();
        clsup.onClosingUpdate(closeLists,newMap,oldMap); 
        
        
    }  
    
}
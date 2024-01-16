@IsTest
public class InquiryApprovalProcessRejectTest{
    @isTest
    public static void test_processApproval(){
        Test.startTest();
        
        User user1 = [SELECT Id FROM User WHERE Alias='ASale'];
        system.debug('user1 '+user1);
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        
        User umgr = new User(Alias = 'mstandt',gsir_company__c='UK',Email='manafer@testorg.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='manafer@testorg.com');
        insert umgr ;
        
        User u = new User(Alias = 'standt',gsir_company__c='UK', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com', managerid=umgr.id );
        
        
        // Create a test pba__Request__c record
        CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        System.debug('line 9' + proj);
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name ='Test property';
        prop.Status__c ='Available';
        prop.CD_Area__c ='Test';
        prop.CD_Project__c=proj.id;
        prop.CD_isblocked__c= true;
        prop.RecordTypeId = Schema.SObjectType.cd_Property__c.getRecordTypeInfosByName().get('Property').getRecordTypeId();
        insert prop;
        System.debug('line 19' + prop);
        
        pba__Request__c I = new  pba__Request__c();
        I.RecordTypeId = Schema.SObjectType.pba__Request__c.getRecordTypeInfosByName().get('Exclusive Project').getRecordTypeId();
        I.Unit__c = prop.Id;
        I.Pending_Request_to_Available_ExpiredDate__c = date.today();
        I.Approver__c=umgr.id;
        
        insert I;
        System.debug('pba request' + I.Id);
        System.debug('line 28' + I.RecordTypeId);     
        
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Rejecting Request.');
        req.setObjectId(I.Id);
     
        //Step 3:  Submit on behalf of a specific submitter
        req.setSubmitterId(u.id); 
        
        //Step 4:  Submit the record to specific process and skip the criteria evaluation
        req.setProcessDefinitionNameOrId('Red_List_Inquiry_Approval_Process');
        req.setSkipEntryCriteria(true);
        
        //req.getNextApproverIds()
        System.debug('line 39' + req);
        
        //Step 5:  Submit the approval request for the bid
        Approval.ProcessResult result = Approval.process(req);
        System.debug('line 42' + result);
        
        ProcessInstance processInstance = [SELECT Id, Status, TargetObjectId FROM ProcessInstance WHERE TargetObjectId = :I.Id];
        System.debug('processInstance in test class =' + processInstance.Status);
        
        ProcessInstanceWorkitem piwi= [SELECT Id,ProcessInstanceId FROM ProcessInstanceWorkitem WHERE ProcessInstanceId = :processInstance.Id];
        System.debug('ProcessInstanceWorkitem in test class =' + piwi.Id);
        //Id approvalRequestId = result.getInstanceId();
        
        list<string> recId = new list<string>();
        List<String> recIdList = new List<String>{I.Id};
            system.debug('recIdList '+recIdList);
        InquiryApprovalProcessReject.processApproval(recIdList);
        System.debug('line 45' + recIdList);
        Test.stopTest();
        
    }
}
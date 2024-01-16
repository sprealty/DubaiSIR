@istest
public class test_customApprovalPageCntrlr {
    
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
	@istest
    public static void test_getSubmittedRecords()
    {
        
        CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name ='Test property';
        prop.CD_Project__c=proj.id;
        prop.CD_isblocked__c= true;
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        
        
        User user1 = [SELECT Id FROM User WHERE UserName='Texeira@sfdc.dev' limit 1];

        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
      req.setComments('Submitting request for approval via form');
      req.setObjectId(prop.Id);
        system.debug('display prop id' +prop.id);
    
     
      //Step 3:  Submit on behalf of a specific submitter
      req.setSubmitterId(UserInfo.getUserId()); 
   
      //Step 4:  Submit the record to specific process and skip the criteria evaluation
      req.setProcessDefinitionNameOrId('CD_Block_Approval');
      req.setSkipEntryCriteria(true);

      //Step 5:  Submit the approval request for the bid
      Approval.ProcessResult result = Approval.process(req);
		
        string processType ='Approve';
        string approverComments = 'Approved';
        
      

      //  Integer intvar = MultiRecordsApprovalController.gettotalcount();
     // List<customApprovalPageCntrlr.SubmittedRecordsWrapper> prorec = new List<customApprovalPageCntrlr.SubmittedRecordsWrapper>();
       // 	customApprovalPageCntrlr.getSubmittedRecords();
        customApprovalPageCntrlr.processApproval(prop.id,processType,approverComments);
       
    }
    
    @istest
     
    public static void test_sumbittedRec()
    {
        CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name ='Test property';
        prop.CD_Project__c=proj.id;
        prop.CD_isblocked__c= true;
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
         CD_Approval_Request__c aprReq = new CD_Approval_Request__c();
        	aprReq.CD_Expiry_Date__c = system.today() +3;
        	aprReq.CD_Blocking_Comments__c ='test comment';
        aprReq.CD_Status__c ='Declined';
        aprReq.CD_Approval_Rejection_Action__c = true;
        	aprReq.Property__c= prop.Id;
        insert aprReq;
        
        
        User user1 = [SELECT Id FROM User WHERE UserName='Texeira@sfdc.dev' limit 1];

        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
      req.setComments('Submitting request for approval via form');
      req.setObjectId(aprReq.Id);
       //system.debug('display prop id' +prop.id);
    
     
      //Step 3:  Submit on behalf of a specific submitter
      req.setSubmitterId(UserInfo.getUserId()); 
   
      //Step 4:  Submit the record to specific process and skip the criteria evaluation
      req.setProcessDefinitionNameOrId('Test_class_Approval');
      req.setSkipEntryCriteria(true);

      //Step 5:  Submit the approval request for the bid
      Approval.ProcessResult result = Approval.process(req);
		
        string processType ='Approve';
        string approverComments = 'Approved';
        List<customApprovalPageCntrlr.SubmittedRecordsWrapper> prorec = new List<customApprovalPageCntrlr.SubmittedRecordsWrapper>();
        customApprovalPageCntrlr.getSubmittedRecords();
         
    }
    
    
    @istest
    
    public static void test_createApprovalRequestRec()
    {
         CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name ='Test property';
        prop.CD_Project__c=proj.id;
        prop.CD_isblocked__c= true;
        prop.CD_Unit_Number__c ='Test property';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
         User user1 = [SELECT Id FROM User WHERE UserName='Texeira@sfdc.dev' limit 1];
         CD_Approval_Request__c aprReq = new CD_Approval_Request__c();
        	aprReq.CD_Expiry_Date__c = system.today() +3;
        	aprReq.CD_Blocking_Comments__c ='test comment';
        	aprReq.CD_Status__c ='Pending';
        	aprReq.Property__c= prop.Id;
        aprReq.CD_Agent_Name__c =user1.id;
       // aprReq.CD_Property_Name__c=
        insert aprReq;
        string appcom ='Test approver comment';
        date expdate = system.today() +5;
        string status ='Approved';
        date finaDate = system.Today()+1;
        customApprovalPageCntrlr.createApprovalRequestRec(prop.id,appcom,expDate);
        customApprovalPageCntrlr.fetchApprovalRequest(prop.id);
        customApprovalPageCntrlr.getAgentSumbittedApprvRec();
        customApprovalPageCntrlr.updateApprovalReq(prop.id,appcom,status,finaDate);
        
    }
}
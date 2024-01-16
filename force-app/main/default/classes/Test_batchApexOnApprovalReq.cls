@isTest
public class Test_batchApexOnApprovalReq {
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
        }
    
        @isTest
        public static void Test1(){
            
            
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
        	aprReq.CD_Expiry_Date__c = system.today();
        	aprReq.CD_Blocking_Comments__c ='test comment';
        	aprReq.CD_Status__c ='Pending';
        	aprReq.Property__c= prop.Id;
        insert aprReq;
        string appcom ='Test approver comment';
        date expdate = system.today() +5;
        string status ='Approved';
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
		
        string processType ='Reject';
        string approverComments = 'Rejected';
            Test.startTest();
            
            batchApexOnApprovalReq ApReq = new batchApexOnApprovalReq();
            Database.executeBatch(ApReq);
            
            Test.stopTest();
        } 
    
}
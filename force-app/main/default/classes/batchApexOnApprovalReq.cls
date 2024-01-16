public class batchApexOnApprovalReq implements database.Batchable<Sobject> {
	
      public database.QueryLocator start(database.BatchableContext bc){
        
    	date curDate = system.today();
        system.debug('get today date'+curDate);
         // string strQuery = 'select id,CD_Approval_Comment__c, CD_Expiry_Date__c,CD_Status__c, CD_Defer_Comments__c,  Property__c from CD_Approval_Request__c where CD_Expiry_Date__c =' +curDate;
        return database.getQueryLocator([select id,CD_Approval_Comment__c, CD_Expiry_Date__c,CD_Status__c, CD_Defer_Comments__c,  Property__c from CD_Approval_Request__c 
        where CD_Expiry_Date__c =: curDate]);
    
    }
     public void execute(database.BatchableContext bc, List<CD_Approval_Request__c> scope)
     {
         set<id> propIds = new set<id>();
         list<CD_Approval_Request__c>  aprReqIds = new list<CD_Approval_Request__c>();
         system.debug('inside execution outer');

         for(CD_Approval_Request__c aprReq : scope )
         {
             propIds.add(aprReq.Property__c);
             aprReqIds.add(aprReq);
         }
         // String message =''; 
         system.debug('inside for loop of execute outer');

         string processType = 'Reject';
        String comments = processType == 'Approve' ? 'Approved' : 'Rejected';
        string appCom = 'Expiry Date met';
        list <ProcessInstanceWorkitem> storeWorkItem = [Select Id FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId =: propIds];
         
         for(ProcessInstanceWorkitem piwi : storeWorkItem )
         {
             	Approval.ProcessWorkitemRequest objWorkItemRequest = new Approval.ProcessWorkitemRequest();
        
       	    objWorkItemRequest.setComments(appCom);
            objWorkItemRequest.setAction(processType);//approve or reject
            objWorkItemRequest.setWorkitemId(piwi.Id);
             
             Approval.ProcessResult processResult = Approval.Process(objWorkItemRequest,False);
         }
         
         for(CD_Approval_Request__c aprReq :aprReqIds)
         {
             aprReq.CD_Approval_Comment__c ='Declined due to request expiry';
             aprReq.CD_Status__c='Declined';
             aprReq.CD_Approval_Rejection_Action__c = true;
             aprReq.CD_Approval_Rejection_Date__c = system.today();
         }
         
         update aprReqIds;
         system.debug('execute outer');
     }
    public void finish(database.BatchableContext bc){
        system.debug('>>>>>>Finish');
    }
}
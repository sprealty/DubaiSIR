public class customApprovalPageCntrlr {
	/*	 @AuraEnabled(cacheable=true)    

    public static CD_Property__c getPropRecord(Id pIWorkItemId , string pageType ){

        CD_Property__c propRecord;

      	Id propId;

        system.debug('pIWorkItemId >> ' + pIWorkItemId);

     	 if (pageType == 'Request') {

          propId = [SELECT Id , ProcessInstance.TargetObjectId  from ProcessInstanceWorkitem WHERE Id =: pIWorkItemId ].ProcessInstance.TargetObjectId;

        } else  {

           propId = [SELECT Id , ProcessInstance.TargetObjectId  from ProcessInstanceStep WHERE Id =: pIWorkItemId ].ProcessInstance.TargetObjectId;
			system.debug('dddd' +propId);
        } 

        propRecord = [SELECT Id from CD_Property__c where Id=: propId];
        
        system.debug('showing propid'+propRecord.Id);

        return propRecord;

    } */
    
 /*  @AuraEnabled(cacheable=true)
    
    public static list<CD_Property__c> getPendingApprovalProperties()
    {
        Set <id> propIds = new Set<Id>();
     /*   list<CD_Property__c> aprvList =[select Id,Name,Status__c,CD_City__c,CD_isblocked__c, CD_Block_Status__c from CD_Property__c where Status__c ='ON HOLD'];
        for(CD_Property__c prop: aprvList)
        {
            propIds.add(prop.Id);
  	    }  */
        
      /*  list<ProcessInstance> prosInst =[SELECT Id,TargetObjectId,TargetObject.Name,CreatedDate,
                                 (SELECT ID FROM WorkItems WHERE OriginalActorId = : UserInfo.getUserId()),
                                 (SELECT OriginalActor.Name,Comments FROM Steps WHERE StepStatus = 'Started') FROM ProcessInstance]; */
   				/*	list<ProcessInstanceWorkitem>	prosInst =[SELECT Id ,ProcessInstance.TargetObjectId,ProcessInstance.TargetObject.Name,ProcessInstance.CreatedDate from ProcessInstanceWorkitem];
        for(ProcessInstanceWorkitem ps : prosInst)
        {
            propIds.add(ps.ProcessInstance.TargetObjectId);
            
        }
        
	list<CD_Property__c> aprvList =[select Id,Name,Status__c,CD_City__c,Type__c,City_Dubizzle__c,CD_isblocked__c, CD_Block_Status__c from CD_Property__c where id=: propIds];  
        if(aprvList.size() > 0)
        {
            return aprvList;
        }
        
        else{
            return new list<CD_Property__c>();
        }
} */
    public class submittedRecordsWrapper{
         @AuraEnabled public Id workItemId;
        @AuraEnabled public String recordId;
        @AuraEnabled public String relatedTo;
        @AuraEnabled public String recordName;
        @AuraEnabled public String submittedBy;
        @AuraEnabled public String submittercomment;
        @AuraEnabled public Date submittedDate;
        @AuraEnabled public String comments;
    }
    @AuraEnabled(cacheable =true)
    public static List<CD_Approval_Request__c> getSubmittedRecords()
    {
        List<SubmittedRecordsWrapper> lstSubmissionWrapper = new List<SubmittedRecordsWrapper>();
        //Process instance stores the info of records submitted for approval,
        // Process instance work item are the records an approver sees while approving/rejecting, Process instance step stores approved/rejected record including approva;/rejection comments
        for(ProcessInstance ps : [SELECT Id,TargetObjectId,TargetObject.Name,CreatedDate,
                                 (SELECT ID FROM WorkItems WHERE OriginalActorId = : UserInfo.getUserId()),
                                 (SELECT OriginalActor.Name,Comments FROM Steps WHERE StepStatus = 'Started') FROM ProcessInstance order by CreatedDate desc]){
            if(!ps.WorkItems.isEmpty()){
                SubmittedRecordsWrapper objSubmittedRecordsWrapper = new SubmittedRecordsWrapper();
                objSubmittedRecordsWrapper.workItemId = ps.WorkItems[0].Id;
                objSubmittedRecordsWrapper.recordId = ps.TargetObjectId;
                objSubmittedRecordsWrapper.recordName = ps.TargetObject.Name;
                objSubmittedRecordsWrapper.comments = '';
               // objSubmittedRecordsWrapper.relatedTo = getObjectName(ps.TargetObjectId);//get the object name using the record id
                objSubmittedRecordsWrapper.submittedDate = Date.newInstance(ps.CreatedDate.year(),ps.CreatedDate.month(),ps.CreatedDate.day());
                if(!ps.steps.isEmpty()){
                    objSubmittedRecordsWrapper.submittedBy = ps.steps[0].OriginalActor.Name;
                    if(ps.steps[0].Comments == '' || ps.steps[0].Comments == null)
                    objSubmittedRecordsWrapper.submittercomment = 'No comments from submitter';
                    else
                    objSubmittedRecordsWrapper.submittercomment = ps.steps[0].Comments;
                    lstSubmissionWrapper.add(objSubmittedRecordsWrapper);
                }
                 }
                 }
        
                Set <id> propIds = new Set<Id>();
                for(SubmittedRecordsWrapper swrap : lstSubmissionWrapper)
                {
                    propIds.add(swrap.recordId);
                }
                
             //   list<CD_Property__c> aprvList =[select Id,Name,Status__c,CD_City__c,Type__c,City_Dubizzle__c,CD_isblocked__c, CD_Block_Status__c from CD_Property__c where id=: propIds];  
                list<CD_Approval_Request__c>  aprvList = [select id,Name,CD_Blocking_Comments__c,CD_Status__c,CreatedDate,CD_Defer_Comments__c,CD_Approval_Comment__c,CD_Approver_Name__c,CD_Expiry_Date__c,CD_Agent_Name__c,CD_AgentName_txt__c,CD_Property_Name__c,Property__c,Property__r.Name,Property__r.CD_Unit_Number__c from CD_Approval_Request__c where Property__c =: propIds and CD_Status__c ='Pending'and CD_Approval_Rejection_Action__c = false];
        if(aprvList.size() > 0)
        {
            return aprvList;
        }
        
        else{
            return new list<CD_Approval_Request__c>();
        }   
    }
    @AuraEnabled
    Public static string processApproval(String recId,String processType, string approverComments)
    {
        cd_Property__c  prop = [select Id,CD_Approval_Comments__c, Name,Status__c from cd_Property__c where id=: recId];
        prop.CD_Approval_Comments__c = approverComments;
        update prop;
        ProcessInstanceWorkitem storeWorkItem = [Select Id FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId =: recId];
        
        system.debug('display workitem id' +storeWorkItem.Id);
        
      //  return storeWorkItem.Id;
        
        //Approval or Rejection Steps //
         
        String message =''; 
        String comments = processType == 'Approve' ? 'Approved' : 'Rejected';
        string appCom = approverComments;
        
      	Approval.ProcessWorkitemRequest objWorkItemRequest = new Approval.ProcessWorkitemRequest();
        
       	    objWorkItemRequest.setComments(appCom);
            objWorkItemRequest.setAction(processType);//approve or reject
            objWorkItemRequest.setWorkitemId(storeWorkItem.Id);
        
        Approval.ProcessResult processResult = Approval.Process(objWorkItemRequest,False);
        
        if(processResult.isSuccess())
        {
            message = 'Request is '+comments+' successfully';
        }
        else{
            
            message += processResult.getErrors();
        }
        
        return message;
    }
    @AuraEnabled
    public static CD_Approval_Request__c createApprovalRequestRec(string propId,string approverComments,date expiryDate)
    {
        CD_Approval_Request__c aprReq =[select id,Name,CD_Blocking_Comments__c,CD_Status__c,CD_Defer_Comments__c,CD_Approval_Comment__c,CD_Approver_Name__c,CD_Expiry_Date__c,CD_AgentName_txt__c,CD_Property_Name__c from CD_Approval_Request__c where Property__c =: propId order by createddate desc limit 1];
    	aprReq.CD_Defer_Comments__c = approverComments;
        aprReq.CD_Approval_Comment__c =approverComments;
        aprReq.CD_Approver_Name__c=userInfo.getUserId();
        aprReq.CD_Expiry_Date__c = expiryDate;
        update aprReq;
        system.debug('getDate'+aprReq.CD_Expiry_Date__c);
        
         cd_Property__c  prop = [select Id, Name, Status__c, CD_Approval_Comments__c, Expiry_Date__c from cd_Property__c where id=: propId];
         prop.CD_Approval_Comments__c = approverComments;
        prop.Expiry_Date__c = expiryDate;
        system.debug('display data' +aprReq);
 CD_Approval_Request__c aprReq2 =[select id,Name,CD_Blocking_Comments__c,CD_Status__c,CD_Defer_Comments__c,CD_Approval_Comment__c,CD_Approver_Name__c,CD_Expiry_Date__c,CD_AgentName_txt__c,CD_Agent_Email__c,CD_Property_Name__c from CD_Approval_Request__c where id =: aprReq.Id];
         string strdate = string.valueof(aprReq2.CD_Expiry_Date__c);      
        EmailTemplate et = [SELECT Id, Name, Subject, Body FROM EmailTemplate WHERE name = 'Approval With ExpDate Template'];
        // Messaging.SingleEmailMessage email =  new  Messaging.SingleEmailMessage();
       		 string htmlBody = et.Body;
            htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_AgentName_txt__c}',aprReq2.CD_AgentName_txt__c);
            htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_Property_Name__c}',aprReq2.CD_Property_Name__c);
        if(aprReq2.CD_Approval_Comment__c == '' || aprReq2.CD_Approval_Comment__c == null)
        {
              htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_Approval_Comment__c}','  ');
        }
        else
        {
              htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_Approval_Comment__c}', aprReq2.CD_Approval_Comment__c);
        }
          //  htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_Approval_Comment__c}', aprReq2.CD_Approval_Comment__c);
        	htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_Expiry_Date__c}',strdate);
       		 Messaging.SingleEmailMessage email =  new  Messaging.SingleEmailMessage();
         list<String> ToAddress = new list<String>();
        //email.setToAddresses( new List<String> {'harishraja411@gmail.com'});
            ToAddress.add(aprReq2.CD_Agent_Email__c);
            email.setToAddresses(ToAddress);
            email.setTemplateId(et.Id);
            system.debug('set template id' + et.id);
            email.setSubject(et.Subject);
            system.debug('set subject '+et.Subject);
            email.setPlainTextBody(htmlBody);
            system.debug('set platin text body '+htmlBody);
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {email});
        
        return aprReq;
    }
     @AuraEnabled(cacheable = true)
    public static CD_Approval_Request__c fetchApprovalRequest(string propId)
    {
      	return [select id,Name,CD_Blocking_Comments__c,CD_Status__c,CD_Defer_Comments__c,CD_Expiry_Date__c,CD_Approval_Comment__c,CD_Approver_Name__c,CD_AgentName_txt__c from CD_Approval_Request__c where Property__c =: propId order by createddate desc limit 1];
    	
    }
    
    @AuraEnabled
    public static cd_Property__c updateApprovalReq(string propId,string approverComments,string status,date finalDate)
    {
        CD_Approval_Request__c aprReq =[select id,Name,CD_Blocking_Comments__c,CD_Status__c,CD_Approval_Rejection_Date__c,CD_Defer_Comments__c,CD_Approval_Comment__c,CD_Approver_Name__c,CD_Expiry_Date__c,CD_Agent_Name__c from CD_Approval_Request__c where Property__c =: propId order by createddate desc limit 1];
    	//aprReq.CD_Defer_Comments__c = approverComments;
       	// aprReq.CD_Expiry_Date__c = null;
       	 aprReq.CD_Approval_Comment__c =approverComments;
         aprReq.CD_Status__c = status;
        aprReq.CD_Approval_Rejection_Date__c= finalDate;
        aprReq.CD_Approval_Rejection_Action__c = true;
        update aprReq;
        cd_Property__c  prop = [select Id,CD_Approval_Comments__c, Name,Status__c from cd_Property__c where id=: propId];
        prop.CD_Approval_Comments__c = approverComments;
        update prop;
        system.debug('display data' +aprReq);
        return prop;
    }
    @AuraEnabled(Cacheable = true)
    public static list<CD_Approval_Request__c> getAgentSumbittedApprvRec()
    {
  		 list<CD_Approval_Request__c>  aprvList = [select id,Name,CD_Blocking_Comments__c,CD_Status__c,CD_Block_Date__c,CD_Defer_Comments__c,CD_Approval_Comment__c,CD_Approver_Name__c,CD_Expiry_Date__c,CD_Agent_Name__c,CD_AgentName_txt__c,CreatedDate,Client_Name__c,CD_Property_Name__c,Property__c,Property__r.Name,Property__r.CD_Unit_Number__c from CD_Approval_Request__c where CD_Agent_Name__c=:UserInfo.getUserId() and CD_Status__c ='Pending' and CD_Approval_Rejection_Action__c=false];
    	
        if(aprvList.size() > 0)
        {
            return aprvList;
        }
        else
        {
            return new list<CD_Approval_Request__c>();
        }
             
    }
    }
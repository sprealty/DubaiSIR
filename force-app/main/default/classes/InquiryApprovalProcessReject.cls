public class InquiryApprovalProcessReject {
    @InvocableMethod
    Public static list<string> processApproval(list<string> recId)
    {
        system.debug('for How Many'+recId);
        Set<Id> InquiryIds = (new Map<Id, pba__Request__c>([SELECT Id FROM pba__Request__c WHERE Id IN :recId ])).keySet();
        system.debug('InquiryIds '+InquiryIds);
        
        Set<Id> pIds = (new Map<Id, ProcessInstance>([SELECT Id,Status,TargetObjectId FROM ProcessInstance where Status='Pending' and TargetObjectId in :InquiryIds])).keySet();
        system.debug('pIds '+pIds.Size());
        
        Set<Id> pInstanceWorkitems = (new Map<Id, ProcessInstanceWorkitem>([SELECT Id,ProcessInstanceId FROM ProcessInstanceWorkitem WHERE ProcessInstanceId in :pIds])).keySet();
        system.debug('pInstanceWorkitems '+pInstanceWorkitems.Size());
        
        List<Approval.ProcessWorkitemRequest> allReq = new List<Approval.ProcessWorkitemRequest>(); 
        system.debug('allReq '+allReq.Size());
        
        for (Id pInstanceWorkitemsId:pInstanceWorkitems){
            system.debug(pInstanceWorkitemsId);
            Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
            req2.setComments('Rejecting Request.');
            req2.setAction('Reject'); //to approve use 'Approve'
            req2.setWorkitemId(pInstanceWorkitemsId);
            req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            allReq.add(req2);
        }
        Approval.ProcessResult[] result2 =  Approval.process(allReq);
        return recId;
    }
}
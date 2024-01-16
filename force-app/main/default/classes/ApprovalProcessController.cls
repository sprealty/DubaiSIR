public with sharing class ApprovalProcessController {
    @AuraEnabled
    public static void submitForApproval(Id recordId) {
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setObjectId(recordId);
        Approval.ProcessResult result = Approval.process(req);
    }
}
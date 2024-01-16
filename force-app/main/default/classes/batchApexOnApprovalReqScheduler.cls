public class batchApexOnApprovalReqScheduler implements schedulable{
    
    public void execute(SchedulableContext sc){
        batchApexOnApprovalReq batAprReq = new batchApexOnApprovalReq();
        database.executeBatch(batAprReq);
        //System.scheduleBatch(batchable, jobName, minutesFromNow);
    }
}
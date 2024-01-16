@isTest
public class test_batchApexOnApprovalReqScheduler {
    
    
    public static testMethod void Testsetup() {
        
        Test.StartTest();
        
        batchApexOnApprovalReqScheduler bat = new batchApexOnApprovalReqScheduler();
        String Sch = '0 0 2 * * ?';
        System.schedule('Schedule Apex', Sch, bat);
        Test.StopTest();
    }
    
}
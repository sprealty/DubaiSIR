@isTest
public class Test_batchEmailScheduler {
    
    public static testMethod void Testsetup() {
        
        Test.StartTest();
        
        batchEmailScheduler be = new batchEmailScheduler();
        String Sch = '0 0 2 * * ?';
        System.schedule('Test Status Check', Sch, be);
        
        Test.StopTest();
    }

}
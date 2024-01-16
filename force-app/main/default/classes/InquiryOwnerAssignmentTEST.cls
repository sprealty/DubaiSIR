@isTest
public class InquiryOwnerAssignmentTEST {
    @IsTest(SeeAllData = True)     
    //scheduler
    static void test0(){
        Test.startTest();
        //pba__Listing__c ls =  [select id from pba__Listing__c limit 1][0];
        //insert new pba__Request__c(pba_uaefields__Community_Propertyfinder__c = 'Academic City',Assign_Owner_using_Assignment_Rules__c = true);
        //insert new pba__Request__c(Listing__c = ls.id,pba_uaefields__Community_Propertyfinder__c = 'Academic City',Assign_Owner_using_Assignment_Rules__c = true);
        InquiriesReAssignmentJobScheduler schJob = new InquiriesReAssignmentJobScheduler();
        String cronExpr = '0 0 0 15 3 ? 2022';
       // String jobId = System.schedule('myJobTestJobName', cronExpr, schJob);
        schJob.execute(null);
        Test.stopTest();
    }
    
    //__TEST1__ case: general inquiry 
    @IsTest(SeeAllData = True)
    static void test1(){
        Test.startTest();
        pba__Request__c inquiry;
        for(pba__Request__c pr : [select id from pba__Request__c where B2B_Buyers_Full_Name__c = '__TEST1__']){
             inquiry = pr;   
        }
        if(inquiry != null){
            List<InquiryOwnerAssignment.Request> reqs = new List<InquiryOwnerAssignment.Request>();
            InquiryOwnerAssignment.Request req = new InquiryOwnerAssignment.Request();
            req.InquiryId = inquiry.id;
            reqs.add(req);
            InquiryOwnerAssignment.execute(reqs);
        }
        Test.stopTest();
    }
    
    //batch class
    @IsTest(SeeAllData = True)
    static void testBatch(){
        Test.startTest();
        InquiriesReAssignmentJob batchObj = new InquiriesReAssignmentJob();
        database.executeBatch(batchObj,1);
        Test.stopTest();
    }
    
    ////__TEST2__ case: list inquiry
    @IsTest(SeeAllData = True)
    static void test2(){
        Test.startTest();
        pba__Request__c inquiry;
        List<InquiryOwnerAssignment.Request> reqs = new List<InquiryOwnerAssignment.Request>();
        for(pba__Request__c pr : [select id from pba__Request__c where B2B_Buyers_Full_Name__c = '__TEST2__']){
            InquiryOwnerAssignment.Request req = new InquiryOwnerAssignment.Request();
            req.InquiryId = pr.id;
            reqs.add(req);
            InquiryOwnerAssignment.execute(reqs);
        }
        Test.stopTest();
    }
    
    ////__TEST3__ case: owner id + web2prospect
    @IsTest(SeeAllData = True)
    static void test3(){
        Test.startTest();
        InquiryOwnerAssignment.dummyMethod();
        pba__Request__c inquiry;
        for(pba__Request__c pr : [select id from pba__Request__c where B2B_Buyers_Full_Name__c = '__TEST3__']){
             inquiry = pr;   
        }
        if(inquiry != null){
            List<InquiryOwnerAssignment.Request> reqs = new List<InquiryOwnerAssignment.Request>();
            InquiryOwnerAssignment.Request req = new InquiryOwnerAssignment.Request();
            req.InquiryId = inquiry.id;
            reqs.add(req);
            reqs.add(req);
            InquiryOwnerAssignment.execute(reqs);
        }
        Test.stopTest();
    }
}
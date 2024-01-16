@isTest
private class ClosingCommisionTestClass {
    @isTest static void TestInsertClosingShareOnClosingCommission() {
        pba__Closing__c obj = new pba__Closing__c();
        obj.TargetClosingDate__c = system.today() + 4;
        insert obj;
        List<User> userList = [Select Id from user where Profile.Name = 'DP_AGENT' And IsActive= True limit 2];
        // Test data setup
        test.startTest();
        Closing_Commission__c ccom = new Closing_Commission__c();
        ccom.Lux_Agent__c = userList[0].Id;
        ccom.Closing__c = obj.Id;
        ccom.Commission_Amount__c = 110;
        ccom.Agent_Type__c = 'Resale Broker';
      //  ccom.User_Division__c ='Resale';
        insert ccom;
        ccom.OwnerId = userList[1].Id;
        update ccom;
        delete ccom;
        test.stopTest();
    }
}
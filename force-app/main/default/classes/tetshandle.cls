@istest
public class tetshandle {
@istest
    static void testHandleAfterUpdate(){
         Profile testProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User']; 
        User testUser = new User(
            ProfileId = testProfile.Id,
            Username = 'di@example.com',
            Email = 'testuser@example.com',
            Alias = 'tuser',
            CommunityNickname = 'testuser',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Test',
            FirstName = 'User',
            TimeZoneSidKey = 'America/Los_Angeles',
            gsir_company__c='Saudi Arabia',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;

        CD_Project__c project = new CD_Project__c();
        project.Name = 'new project';
        project.Job_Completion__c = 80;
        project.Community__c = 'gretaer';
        project.Sub_Community__c = 'greate os';
        project.Project_Admin__c = testUser.id;
        project.Project_Approver__c = testUser.id;
        insert project;

        CD_Property__c oldUnit = new CD_Property__c();
        oldUnit.Name = 'test Unit';
        oldUnit.Status__c = 'Pipeline';
        oldUnit.CD_Project__c = project.id;
        insert oldUnit;

        CD_Property__c newUnit = new CD_Property__c();
        newUnit.Name = 'new Unit';
        newUnit.Status__c = 'OnHold';
        newUnit.CD_Project__c = project.id;
        newUnit.Split_Agent_Name__c = testUser.id;
        insert newUnit;
        
         Test.startTest();
        UnitTriggerHandler.handleAfterUpdate(new List<CD_Property__c>{newUnit}, new Map<Id, CD_Property__c>{oldUnit.Id => oldUnit});
        Test.stopTest();
        System.assertEquals('Pipeline', [SELECT Status__c FROM CD_Property__c WHERE Id = :oldUnit.Id].Status__c);
    }
     @isTest
    static void testSendEmailAlerts(){
         Profile testProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User']; 
        User testUser = new User(
            ProfileId = testProfile.Id,
            Username = 'di@example.com',
            Email = 'testuser@example.com',
            Alias = 'tuser',
            CommunityNickname = 'testuser',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Test',
            FirstName = 'User',
            TimeZoneSidKey = 'America/Los_Angeles',
            gsir_company__c='Saudi Arabia',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;

        CD_Project__c project = new CD_Project__c();
        project.Name = 'new project';
        project.Job_Completion__c = 80;
        project.Community__c = 'gretaer';
        project.Sub_Community__c = 'greate os';
        project.Project_Admin__c = testUser.id;
        project.Project_Approver__c = testUser.id;
        insert project;

        CD_Property__c testUnit = new CD_Property__c();
        testUnit.Name = 'test Unit';
        testUnit.Status__c = 'Pipeline';
        testUnit.CD_Project__c = project.id;
        insert testUnit;
        
          Test.startTest();
        UnitTriggerHandler.sendEmailAlerts(new List<CD_Property__c>{testUnit});
        Test.stopTest();
    }
}
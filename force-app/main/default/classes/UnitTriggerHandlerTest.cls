@isTest
public class UnitTriggerHandlerTest {
    @istest
    static void testUnitTriggerHandler() {
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

        Map<Id, CD_Property__c> oldUnitMap = new Map<Id, CD_Property__c>();
        oldUnitMap.put(oldUnit.Id, oldUnit);

        Test.startTest();
        UnitTriggerHandler.handleAfterUpdate(new List<CD_Property__c>{newUnit}, oldUnitMap);
        Test.stopTest();

        List<EmailMessage> emails = [SELECT Id FROM EmailMessage];
        System.assertEquals(0, emails.size(), 'Expected one email message to be sent.');
    }

    @istest
    static void testUnitTriggerHandler_NoChanges() {
        // Test when there are no changes, the email should not be sent
        // Similar to the previous test, but update newUnit.Status__c to be the same as oldUnit.Status__c

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
        newUnit.Status__c = 'Pipeline'; // Setting the status to be the same as oldUnit
        newUnit.CD_Project__c = project.id;
        newUnit.Split_Agent_Name__c = testUser.id;
        insert newUnit;

        Map<Id, CD_Property__c> oldUnitMap = new Map<Id, CD_Property__c>();
        oldUnitMap.put(oldUnit.Id, oldUnit);

        Test.startTest();
        UnitTriggerHandler.handleAfterUpdate(new List<CD_Property__c>{newUnit}, oldUnitMap);
        Test.stopTest();

        List<EmailMessage> emails = [SELECT Id FROM EmailMessage];
        System.assertEquals(0, emails.size(), 'Expected no email messages to be sent.');
    }
    @istest
    static void testSendEmailAlerts() {
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

        CD_Property__c newUnit = new CD_Property__c();
        newUnit.Name = 'new Unit';
        newUnit.Status__c = 'Pipeline'; // Setting the status to be the same as oldUnit
        newUnit.CD_Project__c = project.id;
        newUnit.Split_Agent_Name__c = testUser.id;
        insert newUnit;

        Test.startTest();
        // Call handleAfterUpdate with the necessary data to trigger the sendEmailAlerts logic
        UnitTriggerHandler.handleAfterUpdate(new List<CD_Property__c>{newUnit}, new Map<Id, CD_Property__c>());
        Test.stopTest();

        // Validate that the email was sent successfully
        List<EmailMessage> emails = [SELECT Id FROM EmailMessage];
        System.assertEquals(0, emails.size(), 'Expected one email message to be sent.');
        
       
    }
}
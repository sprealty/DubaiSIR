@isTest
public class CCRTriggerTest {
     @IsTest(SeeAllData = True)
    static void testCCRTrigger() {
        pba__Request__c pr = [select id from pba__Request__c limit 1];  
        Conveyance__c conv = new Conveyance__c();
          conv.Inquiry__c = pr.Id;
        conv.Contract_Value__c = 100;
        conv.Is_10_deposit__c = 'Yes';
            conv.OC_Deposit__c = 'manager’s cheque';
        conv.Deal_Type__c = 'cash to Finance';
            conv.Conveyancing_Fee_Paid_by__c = 'Seller';
        conv.Buyer_Agency_Fee__c = 100;
      conv.Seller_Agency_Fee__c = 100;
        conv.Other_OC_Notes__c = 'test';
       //   Conveyancing_Fee_Paid_by__c,
       //    Buyer_Agency_Fee__c, Seller_Agency_Fee__c
        insert conv;

        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

        User u = new User(
            Alias = 'standt',
            gsir_company__c = 'UK',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'standarduser121@testorg.com'
        );
        insert u;
        User u1 = new User(
            Alias = 'newze',
            gsir_company__c = 'UK',
            Email = 'Newzee@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing1',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'newze122@testorg.com'
        );
        insert u1;

        Conveyance_Contact_Role__c ccr = new Conveyance_Contact_Role__c();
        ccr.Role__c = 'seller';
        ccr.Conveyance__c = conv.Id;
        ccr.Lux_Agent__c = u.id;
        insert ccr;
        ccr.Lux_Agent__c = u1.id;
        update ccr;
        delete ccr;

        Test.startTest();
        if (ccr.Lux_Agent__c != null) {
            // Check if a Conveyance__Share record already exists
            List<Conveyance__Share> existingShares = [SELECT Id FROM Conveyance__Share WHERE ParentId = :ccr.Conveyance__c AND UserOrGroupId = :u.Id];
            if (existingShares.isEmpty()) {
                Conveyance__Share conveyanceShare = new Conveyance__Share();
                conveyanceShare.ParentId = ccr.Conveyance__c;
                conveyanceShare.UserOrGroupId = u.Id;
                conveyanceShare.AccessLevel = 'Read';
                insert conveyanceShare;
                ccr.Lux_Agent__c = null;
        		update conveyanceShare;
                delete conveyanceShare;
            }
        }
        
        Test.stopTest();

        List<Conveyance__Share> conveyanceShares = [SELECT Id, ParentId, UserOrGroupId FROM Conveyance__Share WHERE ParentId = :ccr.Conveyance__c];
        System.assert(conveyanceShares.size() >= 1, 'Expected at least one Conveyance__Share record.');

        Conveyance__Share conveyanceShare = conveyanceShares[0];
    }
     
        
}
@isTest
private class ConveyanceChecklistTest {
    
    @isTest
    static void testFetchRecordData() {
        
        // Create test data
       Account acc = new Account();
        acc.Name='test account';
        acc.os_Upload_Agency_License__c='yes';
        acc.os_Upload_BRN__c='yes';
        acc.os_Upload_ORN__c='yes';
        insert acc;
        
        
        Contact testContact = new Contact();
        testContact.FirstName = 'Test'; 
        testContact.LastName = 'Contact'; 
        testContact.Contact_Type__c = 'Client';
        insert testContact;
        
        os_Listing__c listing = new os_Listing__c();
        
        listing.os_Brokers_Listing_ID__c = 'GS--38705';
        listing.os_System_Allowed_for_Portals__c	 = false;
        listing.os_Status__c = 'Off-Market';
        
        listing.os_Property_Owner__c = testContact.Id;
        listing.os_Listing_Price_pb__c = 120;
        listing.os_Marketing_Exposure__c	 = 'luxhabitat.ae';
        listing.os_gsir_Mandate__c = 'Non Exclusive';
        listing.os_uaefields_Property_Sub_Type__c	 = 'Test Listing';
        listing.os_gsir_Listing_Category__c = 'Test Listing';
        listing.os_Bedrooms_pb__c = 1;
        listing.os_uaefields_RERA_Permit_Number__c	 = 'Test Listing';
        listing.os_uaefields_Completion_Status__c	 = 'Completed';
        listing.os_uaefields_Community_Propertyfinder__c	 = 'Test Listing';
        listing.os_uaefields_Property_Propertyfinder__c	 = 'Test Listing';
        listing.os_TotalArea_pb__c = 100;
        listing.os_uaefields_City_Propertyfinder__c = 'Test Listing';
        listing.os_Description_pb__c = 'Test Listing';
        listing.os_Brokers_Listing_ID__c	 = 'some value'; // set a non-blank value for the field
        listing.os_System_Allowed_for_Portals__c = false;
        listing.os_uaefields_Sub_CommunityPropertyfinder__c = 'Test Listing';
        listing.os_Postal_Code_pb__c = '440023';
        listing.os_State_pb__c ='Maharashtra';
        listing.os_uaefields_Private_Amenities__c	 = 'Study';
        
        insert listing;
        
        
        os_Request__c request = new os_Request__c();
        request.os_Status__c = 'Offering';
        // Set the Red_Listed_Status__c value to "Expired"
        request.os_Listing__c = listing.Id;
        
        // request.Red_Listed_Status__c = 'Expired';
        
        
        os_Project__c testProject = new os_Project__c(); 
        testProject.Name = 'Test Project';
        insert testProject;
        
        // Create a test Unit record with Status__c = "Available"
        OS_Property__c testUnit = new OS_Property__c();
        testUnit.Name = 'Test Unit';
        testUnit.os_Status__c	 = 'Available';
        testUnit.os_Project__c = testProject.Id;
        testUnit.os_Area__c = 'abc';
        insert testUnit;
        
        request.os_Unit__c	 = testUnit.Id;
        request.os_Project__c = testProject.Id;
        // Insert the test record
        insert request;
        System.debug('testRequest Id: ' + request.Id);
        
        Profile testProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User']; 
        User testUser = new User(
            ProfileId = testProfile.Id,
            LastName = 'TestLastName',
            FirstName = 'TestFirstName',
            Email = 'testuser@example.com',
            Username = 'testuser@example.com' + System.currentTimeMillis(),
            Alias = 'TUser',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles'
        );
        insert testUser;
        os_Conveyance__c	contract = new os_Conveyance__c();
        contract.Contract_Value__c=1200;
        contract.os_Title_Deed_No__c='test Title';
        String dateString = '15/02/2024';
        List<String> dateParts = dateString.split('/');
        Integer day = Integer.valueOf(dateParts[0]);
        Integer month = Integer.valueOf(dateParts[1]);
        Integer year = Integer.valueOf(dateParts[2]);
        contract.os_Target_closing_date__c=Date.newInstance(year, month, day);
        contract.os_Transaction_Type__c	='Offplan Primary';
        contract.Developer_Name__c='test Name';
        contract.os_Property_Mortgaged__c='yes';
        contract.os_Finance_Conditional__c='Yes';
        contract.os_Is_10_deposit__c='Yes';
        contract.os_OC_Deposit__c='personal cheque';
        contract.os_Special_Commercial_Terms__c='Test Commercial term';
        contract.os_Buyer_Represented_By__c=testUser.id;
        contract.os_Buyer_Agency_Fee__c=1200;
        contract.os_Seller_Represented_By__c=testUser.id;
        contract.os_Seller_Agency_Fee__c=1300;
        contract.os_POA_Required__c='Local';
        contract.os_Deal_Type__c='Finance to Cash';
         contract.os_Inquiry__c = request.Id;

        insert contract;
        
        os_AML__c testAML = new os_AML__c();
        testAML.os_Upload_KYC_Signed__c = 'Yes';
        testAML.os_Inquiry__c = request.Id;
        testAML.os_AML_Type__c = 'Individual';
        testAML.Role__c = 'Buyer';
        testAML.os_Status__c='KYC Pending';
        testAML.os_Contact__c = testContact.Id;
        insert testAML;
        
        // Retrieve the field set named "Checklist_Account_Fields" for the Account object
        Schema.DescribeSObjectResult accountDescribe = Account.sObjectType.getDescribe();
        Schema.FieldSet accountFieldSet = accountDescribe.FieldSets.getMap().get('Checklist_Account_Fields');
        
        // Call the fetchRecordData method of the ConveyanceChecklist class
        Test.startTest();
        ConveyanceChecklist.RequestWrapper result = ConveyanceChecklist.fetchRecordData(request.Id);
        Test.stopTest();
        
        List<Map<String, Object>> amlList = result.amlList;
        System.assertEquals(1, amlList.size());
        
        System.assertNotEquals(null, result);
        Map<String, Object> amlFields = amlList[0];
        System.assertEquals('Test Contact', amlFields.get('Name'));
        
    }

     @isTest
    static void testFetchRecordData_AdditionalCase() {
        Contact testContact = new Contact();
        testContact.FirstName = 'Test'; 
        testContact.LastName = 'Contact'; 
        testContact.Contact_Type__c = 'Client';
        insert testContact;
        
        os_Listing__c listing = new os_Listing__c();
        listing.os_Brokers_Listing_ID__c = 'GS--38705';
        listing.os_System_Allowed_for_Portals__c	 = false;
        listing.os_Status__c = 'Off-Market';
        listing.os_Property_Owner__c = testContact.Id;
        listing.os_Listing_Price_pb__c = 120;
        listing.os_Marketing_Exposure__c	 = 'luxhabitat.ae';
        listing.os_gsir_Mandate__c = 'Non Exclusive';
        listing.os_uaefields_Property_Sub_Type__c	 = 'Test Listing';
        listing.os_gsir_Listing_Category__c = 'Test Listing';
        listing.os_Bedrooms_pb__c = 1;
        listing.os_uaefields_RERA_Permit_Number__c	 = 'Test Listing';
        listing.os_uaefields_Completion_Status__c	 = 'Completed';
        listing.os_uaefields_Community_Propertyfinder__c	 = 'Test Listing';
        listing.os_uaefields_Property_Propertyfinder__c	 = 'Test Listing';
        listing.os_TotalArea_pb__c = 100;
        listing.os_uaefields_City_Propertyfinder__c = 'Test Listing';
        listing.os_Description_pb__c = 'Test Listing';
        listing.os_Brokers_Listing_ID__c	 = 'some value'; // set a non-blank value for the field
        listing.os_System_Allowed_for_Portals__c = false;
        listing.os_uaefields_Sub_CommunityPropertyfinder__c = 'Test Listing';
        listing.os_Postal_Code_pb__c = '440023';
        listing.os_State_pb__c ='Maharashtra';
        listing.os_uaefields_Private_Amenities__c	 = 'Study';
        
        insert listing;
        os_Project__c testProject = new os_Project__c(); 
        testProject.Name = 'Test Project';
        insert testProject;
        
        // Create a test Unit record with Status__c = "Available"
        OS_Property__c testUnit = new OS_Property__c();
        testUnit.Name = 'Test Unit';
        testUnit.os_Status__c	 = 'Available';
        testUnit.os_Project__c = testProject.Id;
        testUnit.os_Area__c = 'abc';
        insert testUnit;
                
         Test.startTest();
         os_Request__c additionalRequest = new os_Request__c(
            os_Status__c = 'Offering',
            os_Listing__c = listing.Id,
            os_Project__c = testProject.Id,
            os_Unit__c = testUnit.Id
        );
        insert additionalRequest;
        ConveyanceChecklist.RequestWrapper additionalResult = ConveyanceChecklist.fetchRecordData(additionalRequest.Id);
        Test.stopTest();
    }
    @isTest
    static void testFetchRecordData_NullAMLList() {
        os_Listing__c listing = new os_Listing__c();
        listing.os_Brokers_Listing_ID__c = 'GS--38705';
        listing.os_System_Allowed_for_Portals__c	 = false;
        listing.os_Status__c = 'Off-Market';
        //listing.os_Property_Owner__c = testContact.Id;
        listing.os_Listing_Price_pb__c = 120;
        listing.os_Marketing_Exposure__c	 = 'luxhabitat.ae';
        listing.os_gsir_Mandate__c = 'Non Exclusive';
        listing.os_uaefields_Property_Sub_Type__c	 = 'Test Listing';
        listing.os_gsir_Listing_Category__c = 'Test Listing';
        listing.os_Bedrooms_pb__c = 1;
        listing.os_uaefields_RERA_Permit_Number__c	 = 'Test Listing';
        listing.os_uaefields_Completion_Status__c	 = 'Completed';
        listing.os_uaefields_Community_Propertyfinder__c	 = 'Test Listing';
        listing.os_uaefields_Property_Propertyfinder__c	 = 'Test Listing';
        listing.os_TotalArea_pb__c = 100;
        listing.os_uaefields_City_Propertyfinder__c = 'Test Listing';
        listing.os_Description_pb__c = 'Test Listing';
        listing.os_Brokers_Listing_ID__c	 = 'some value'; 
        listing.os_System_Allowed_for_Portals__c = false;
        listing.os_uaefields_Sub_CommunityPropertyfinder__c = 'Test Listing';
        listing.os_Postal_Code_pb__c = '440023';
        listing.os_State_pb__c ='Maharashtra';
        listing.os_uaefields_Private_Amenities__c	 = 'Study';
        
        insert listing;
        Test.startTest();
        os_Request__c requestWithoutAML = new os_Request__c(
            os_Status__c = 'Offering',
            os_Listing__c = listing.Id);
        insert requestWithoutAML;

        ConveyanceChecklist.RequestWrapper result = ConveyanceChecklist.fetchRecordData(requestWithoutAML.Id);
        Test.stopTest();
    }
    @isTest
    static void testFetchAccountFieldSet() {
        Schema.DescribeSObjectResult accountDescribe = Account.SObjectType.getDescribe();
        Schema.FieldSet accountFieldSet = accountDescribe.FieldSets.getMap().get('Checklist_Account_Fields');
         System.assertNotEquals(null, accountFieldSet);
    }
    
}
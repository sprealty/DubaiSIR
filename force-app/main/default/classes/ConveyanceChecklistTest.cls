@isTest
private class ConveyanceChecklistTest {
   
    @isTest
    static void testFetchRecordData() {
        
        // Create test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        Contact testContact = new Contact();
        testContact.FirstName = 'Test'; 
        testContact.LastName = 'Contact'; 
        testContact.ContactType__c = 'Client';
        insert testContact;
        
        pba__Listing__c listing = new pba__Listing__c();
  
        listing.pba__Broker_s_Listing_ID__c = 'GS--38705';
        	listing.pba__SystemAllowedForPortals__c = false;
        listing.pba__Status__c = 'Off-Market';
        
            listing.PropertyOwnerContact__c = testContact.Id;
            listing.pba__ListingPrice_pb__c = 120;
            listing.Marketing_Exposure__c = 'luxhabitat.ae';
            listing.gsir_mandate__c = 'Non Exclusive';
            listing.pba_uaefields__Property_Sub_Type__c = 'Test Listing';
            listing.gsir_listing_category__c = 'Test Listing';
            listing.pba__Bedrooms_pb__c = 1;
        listing.pba_uaefields__RERA_Permit_Number__c = 'Test Listing';
        listing.pba_uaefields__Completion_Status__c = 'Completed';
        listing.pba_uaefields__Community_Propertyfinder__c = 'Test Listing';
        listing.pba_uaefields__Property_Propertyfinder__c = 'Test Listing';
        listing.pba__TotalArea_pb__c = 100;
        listing.pba_uaefields__City_Propertyfinder__c = 'Test Listing';
        listing.pba__Description_pb__c = 'Test Listing';
        listing.pba_uaefields__Broker_s_Listing_ID__c = 'some value'; // set a non-blank value for the field
		listing.pba__SystemAllowedForPortals__c = false;
        listing.pba_uaefields__Sub_Community_Propertyfinder__c = 'Test Listing';
        listing.pba__PostalCode_pb__c = '440023';
        listing.pba__State_pb__c ='Maharashtra';
		listing.pba_uaefields__Private_Amenities__c = 'Study';

        insert listing;

        
        pba__Request__c request = new pba__Request__c();
        request.pba__Status__c = 'Offering';
        // Set the Red_Listed_Status__c value to "Expired"
        request.Listing__c = listing.Id;
        
       // request.Red_Listed_Status__c = 'Expired';
        
        
        CD_Project__c testProject = new CD_Project__c(); 
        testProject.Name = 'Test Project';
        insert testProject;
        
        // Create a test Unit record with Status__c = "Available"
        CD_Property__c testUnit = new CD_Property__c();
        testUnit.Name = 'Test Unit';
        testUnit.Status__c = 'Available';
		testUnit.CD_Project__c = testProject.Id;
		testUnit.CD_Area__c = 'abc';
        insert testUnit;
        
        request.Unit__c = testUnit.Id;
        request.Project__c = testProject.Id;
        // Insert the test record
        insert request;
        System.debug('testRequest Id: ' + request.Id);
       
        
        
        AML__c testAML = new AML__c();
        testAML.Upload_KYC_Signed__c = 'Yes';
        testAML.Inquiry__c = request.Id;
        testAML.AML_Type__c = 'Individual';
        testAML.Role__c = 'Buyer';
        testAML.Contact__c = testContact.Id;
        insert testAML;
        
        
        
        // Call the fetchRecordData method of the ConveyanceChecklist class
        Test.startTest();
        ConveyanceChecklist.RequestWrapper result = ConveyanceChecklist.fetchRecordData(request.Id);
        Test.stopTest();

        List<Map<String, Object>> amlList = result.amlList;
        System.assertEquals(1, amlList.size());
        Map<String, Object> amlFields = amlList[0];
        System.assertEquals('Test Contact', amlFields.get('Name'));
      
    }
}
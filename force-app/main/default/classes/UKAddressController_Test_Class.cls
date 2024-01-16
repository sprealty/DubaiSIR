@isTest
public class UKAddressController_Test_Class {
    @isTest
    static void testConstructor() {
        pba__Listing__c listing = new pba__Listing__c(
            // Initialize relevant fields here
        );
        insert listing;

        Test.setCurrentPageReference(new PageReference('/apex/yourPageName?id=' + listing.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(listing);

        UKAddressController controller = new UKAddressController(sc);

        // Add your assertions here to check if the controller values are set correctly
        System.assertEquals(listing.Id, controller.currentRecordId);
        // Add more assertions for other controller properties
    }

    @isTest
    static void testUpdateAddress() {
        // Create and insert a test listing
        pba__Listing__c testListing = new pba__Listing__c();
        testListing.pba__Status__c = 'Draft';
        insert testListing;

        Test.setCurrentPageReference(new PageReference('/apex/yourPageName?id=' + testListing.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(testListing);

        UKAddressController controller = new UKAddressController(sc);

        // Set controller properties
        controller.BuildingName = 'Test Building';
        controller.StreetSubcommunity = 'Test Street';
        controller.PostalCode ='100 123';
        controller.showSpinner = true;
        // Set other properties as needed

        Test.startTest();
        controller.updateAddress();
        controller.startSpinner();
        controller.stopSpinner();
        Test.stopTest();

        
    }
}
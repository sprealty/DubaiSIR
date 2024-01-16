@isTest
private class TestConcateListingAddress {
    @isTest
    static void testTriggerLogic() {
        
        
        //DeatcivateUKAddress__c activeTriggerStatus = new DeatcivateUKAddress__c(Name__c = 'UKAddressUpdate', Active__c = true);
        //DeatcivateUKAddress__c inactiveTriggerStatus = new DeatcivateUKAddress__c(Name__c = 'UKAddressUpdate', Active__c = false);
        //insert activeTriggerStatus;
            
        // Create test records
        pba__Listing__c listing1 = new pba__Listing__c(
            Name = 'Test Listing 1',
            pba__Street_pb__c = 'Test Street 1',
            Street_2__c = 'Test Street 2',
            Village__c = 'Test Village',
            Area_Town_City__c = 'Test City',
            County__c = 'Test County',
            UKPostal_Code__c = '12345 ABC',
            pba__Country_pb__c = 'Test Country',
            Sharing_Rule__c ='United Kingdom SIR'
        );
        insert listing1;

        // Modify test record to trigger the update
        listing1.pba__Street_pb__c = 'Updated Street 1';
        update listing1;

        
    }
}
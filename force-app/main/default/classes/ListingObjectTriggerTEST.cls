@isTest
public class ListingObjectTriggerTEST {
	
    @IsTest
    static void test1(){
        pba__Listing__c listing = new pba__Listing__c(
            pba_uaefields__Private_Amenities__c='Study; Central A/C & Heating',
            gsir_form_a_expiry__c=System.Today().addDays(100),
            pba__ListingType__c = 'Sale'
        );
        insert listing;
        listing.pba_uaefields__Private_Amenities__c = 'Study';
        update listing;
    }
}
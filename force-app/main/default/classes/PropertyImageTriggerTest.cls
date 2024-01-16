@isTest
public class PropertyImageTriggerTest{

    @testSetup
    static void testSetup(){
        pba__Property__c property = new pba__Property__c(Name='test property');
        insert property;
        
        pba__Listing__c listing = new pba__Listing__c(pba__Property__c=property.Id,pba__Status__c='Published',
                                                      Contact_Verified__c=true,Documents_Verified__c=true,
                                                      Initial_Listed_Date__c=System.Today(),Listing_Verified_by_CC__c=true,
                                                      gsir_form_a_expiry__c = System.NOW().addDays(1),pba__SystemAllowedForPortals__c=true,
                                                      pba__Bedrooms_pb__c =2,pba__Description_pb__c='test description',
                                                     pba__ListingPrice_pb__c = 1000,pba_uaefields__RERA_Permit_Number__c = '987',
                                                     pba_uaefields__Community_Propertyfinder__c = 'Test',pba_uaefields__Sub_Community_Propertyfinder__c = 'Test',
                                                     pba_uaefields__Property_Propertyfinder__c = 'Test',pba_uaefields__City_Propertyfinder__c = 'Test',
                                                     pba_uaefields__Property_Sub_Type__c='Test',pba_uaefields__Price_Unit__c = 'AED',
                                                     pba__TotalArea_pb__c=1234);
        insert listing;
    }
    @isTest
    public static void testMethod1(){
        pba__Property__c property = [select id from pba__Property__c limit 1];
        insert new pba__PropertyMedia__c(pba__Property__c=property.id);
    }

}
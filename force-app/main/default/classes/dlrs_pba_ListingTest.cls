/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_pba_ListingTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_pba_ListingTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new pba__Listing__c());
    }
}
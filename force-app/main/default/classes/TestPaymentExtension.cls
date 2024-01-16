@isTest(SeeAllData=true)
private class TestPaymentExtension {
   public static testmethod void  TestPaymentExtension() {
        try{  
           CD_Project__c proj = new CD_Project__c();
            proj.Account_Name__c ='test';
            insert proj;
            system.debug('proj'+proj);
            
           CD_Property__c unit = new CD_Property__c();
            unit.Name = 'test';
            unit.CD_Area__c = 'test';
            unit.CD_Project__c = proj.Id;
            insert unit;
            system.debug('unit'+unit);
            
            Payment__c Pay =new Payment__c();
            pay.Amount__c = 100;
          //pay.Payment_Date__c = 02/22/2023;
            pay.Payment_Type__c = 'Others';
            pay.Status__c = 'Received';
            pay.Unit__c = unit.Id;
            insert Pay;
            system.debug('Pay'+Pay);
            
             Apexpages.StandardController sc  = new Apexpages.StandardController(Pay);
             PaymentExtension ext = new PaymentExtension(sc);
             // System.assertEquals('firstlast@acme.com', leads[0].email);
            
           }catch(ListException e){
            System.debug('List exception fired');         
        }
}
}
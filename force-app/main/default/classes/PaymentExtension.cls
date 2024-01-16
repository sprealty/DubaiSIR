public with sharing class PaymentExtension{
    
    public Payment__c CurrentPayment{ // getting or setting Payment
        get;
        set;
    }
    
    
    
    public  PaymentExtension(ApexPages.StandardController controller){
        CurrentPayment =     // gets current Payment record
            (Payment__c)controller.getRecord();
            
      
    }

}
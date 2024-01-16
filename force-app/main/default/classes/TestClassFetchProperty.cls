@isTest
public class TestClassFetchProperty {

static testMethod void test_fetchProperty(){
    
    CD_Project__c proj = new CD_Project__c();
    proj.Name = 'DMCC uptown';
    insert proj;
    
    CD_Property__c p = new CD_Property__c();
    //p.Unit_Number__c ='123';
    p.CD_Sales_Price__c = 122322;
    p.Status__c ='Available';
    p.Name = 'U1';
    p.CD_Project__c = proj.Id;
    p.CD_Unit_Price_USD__c = 12344;
    insert p;
    
    list<CD_Property__c> pro = new list<CD_Property__c>();
    pro = FetchProperty.fetchproperty();
    
     
}
}
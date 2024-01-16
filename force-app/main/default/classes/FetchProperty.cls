@RestResource(urlMapping='/getUnitDataFeed')
global with sharing class FetchProperty {
    @HttpGet
    global static list<CD_Property__c> fetchproperty(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        List<CD_Property__c> prop =[Select Id , Name , Status__c , CD_Unit_Number__c , CD_Project__r.Name , CD_Sales_Price__c ,CD_Unit_Price_USD__c, CD_Bedrooms__c from CD_Property__c WHERE CD_Project__r.Name ='DMCC uptown'  ];
        return prop ;
    }
}
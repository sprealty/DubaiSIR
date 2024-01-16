public class ContactTriggerHandler {
    Public static void UpdateCountry(List<Contact> conList ,Map<Id,Contact> conUpdate)
    {
      	List<Country_Code__mdt> CountryCodeLst = New List<Country_Code__mdt>([SELECT Id, Label, DeveloperName,Country_Code__c FROM Country_Code__mdt]);
       Map<String,String> ApiToLabelMap = new Map<String,String>();         
        For(Country_Code__mdt sp : CountryCodeLst)
	   { 
		  ApiToLabelMap.put(sp.Country_Code__c,sp.Label);
           System.debug('Label value of picklist>>'+ ApiToLabelMap);
	   }      
        List<Contact> countryCodeList = new List<Contact>();
        for(Contact conrecord:conList)
        {
            if((conrecord.Mobile_country_code__c!= Null) && 
 			((conUpdate == Null) || (conUpdate!=null && conrecord.Mobile_country_code__c!=conUpdate.get(conrecord.Id).Mobile_country_code__c)))
            {
                //Check Metadata Country Code is equal as Contact Country code.
                if(ApiToLabelMap.containsKey(conrecord.Mobile_country_code__c))
                {
                    //Update metadata Country Code into contact Mobile Country Code.
                    conrecord.Mobile_Country__c=ApiToLabelMap.get(conrecord.Mobile_country_code__c);
                    countryCodeList.add(conrecord); 
                }
                
            }       
            system.debug('Create or Update Contact with Country name');  
        }
    }
}
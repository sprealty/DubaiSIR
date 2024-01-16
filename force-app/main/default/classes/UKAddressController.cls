public class UKAddressController{
	public String currentRecordId {get;set;}
	public List<pba__Listing__c> listingListCon {get;set;}
	public Boolean showSpinner { get; set; }
    public String SubBuilding {get;set;}
    public String BuildingName {get;set;}
    public String BuildingNumber {get;set;}
    public String StreetSubcommunity {get;set;}
    public String DistrictCommunity {get;set;}
    public String CityCommunity {get;set;}
 public String ProvienceState {get;set;}
    public String PostalCode {get;set;}
    public String country {get;set;}
    public String PropertyfinderRegion{get;set;}
   
  
    ApexPages.StandardController controller;
    public UKAddressController(ApexPages.StandardController controller) {
        
        this.controller = controller;
        showSpinner = false;
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        listingListCon = [SELECT id, pba_uaefields__Propertyfinder_Region__c , Address__c FROM pba__Listing__c WHERE id =:currentRecordId ];
        
        for(pba__Listing__c listListing: listingListCon){
            //streetAddress = listListing.gsir_unit_number__c + ','+listListing.pba__Street_pb__c+','+ listListing.pba__City_pb__c ;
        PropertyfinderRegion = listListing.Address__c;
        }
        System.debug('currentRecordId' +currentRecordId);
    }
    
    public void updateAddress()
    {
        
        System.debug('SubBuilding' +SubBuilding);
        System.debug('BuildingName' +BuildingName);
        System.debug('BuildingNumber' +BuildingNumber);
        System.debug('StreetSubcommunity' +StreetSubcommunity);
        System.debug('DistrictCommunity' +DistrictCommunity);
        System.debug('CityCommunity' +CityCommunity);
        System.debug('ProvienceState' +ProvienceState);
        System.debug('PostalCode' +PostalCode);
        System.debug('country' +country);
        
        
        String PropertyPropertyfinder = '';
        if (!String.isBlank(SubBuilding)) {
    	PropertyPropertyfinder += SubBuilding;
		}

		if (!String.isBlank(BuildingName)) {
    		if (!String.isBlank(PropertyPropertyfinder)) {
        	PropertyPropertyfinder += ', ';
    	}
    	PropertyPropertyfinder += BuildingName;
		}
        
        String SubCommunityPropertyFinder = '';
        if (!String.isBlank(StreetSubcommunity)) {
    	SubCommunityPropertyFinder += StreetSubcommunity;
		}

		if (!String.isBlank(DistrictCommunity)) {
    		if (!String.isBlank(SubCommunityPropertyFinder)) {
        	SubCommunityPropertyFinder += ', ';
    	}
    	SubCommunityPropertyFinder += DistrictCommunity;
		}
        
        String Community = '';
        if (!String.isBlank(CityCommunity)) {
    	Community += CityCommunity;
		}

		if (!String.isBlank(ProvienceState)) {
    		if (!String.isBlank(ProvienceState)) {
        	Community += ', ';
    	}
    	Community += ProvienceState;
		}
        String varPostalcode = PostalCode;
		List<String> code = varPostalcode.split(' ');
        String firstcode ='';
        if (!code.isEmpty())
        {
         firstcode = code[0];   
        }
        
		
        
		List<pba__Listing__c> listingList = [SELECT id FROM pba__Listing__c WHERE id =:currentRecordId ];
		List<pba__Listing__c> listingListUpdate = new List<pba__Listing__c>();  
        
		for(pba__Listing__c l: listingList){
            
            //Uk Fields
            l.House_Building_Name__c = PropertyPropertyfinder;
            l.pba__Street_pb__c = StreetSubcommunity;
            l.Village__c = DistrictCommunity;
            
            if ( CityCommunity == 'London')
            {
                l.Area_Town_City__c = '';
                l.County__c =CityCommunity;
            }
            else
            {
                l.Area_Town_City__c = CityCommunity;
            	l.County__c =ProvienceState; 
            }
            
            l.UKPostal_Code__c = PostalCode;
            l.pba__Country_pb__c = country; 
            l.Street_2__c ='';
           
            
    		listingListUpdate.add(l);
		}
        try
        {
            update listingListUpdate;
            
        }
        catch(Exception E)
        {
            System.debug('Exception' + E);
        }
		
        
    }
    
     public void startSpinner() {
        showSpinner = true;
    }

    public void stopSpinner() {
        showSpinner = false;
    }

    
}
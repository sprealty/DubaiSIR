public class ManagePropertyCntrlr {
    
    
    @AuraEnabled(cacheable=true)
    public static string getProperty(Integer pageSize, Integer pageNumber,string sortedBy,string sortDirection){
        String jsonDT = '';
        Integer offset = (pageNumber - 1) * pageSize; 
        Integer totalRecords = [SELECT COUNT() FROM cd_Property__c];
        Integer recordEnd = pageSize * pageNumber;  
        string usrID = UserInfo.getUserId();
        propertyWrapper prop =  new propertyWrapper();  
        prop.pageSize = pageSize;
        prop.pageNumber = pageNumber;
        prop.recordStart = offset + 1;
        prop.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        prop.totalRecords = totalRecords;
        if(string.isNotBlank(sortedBy)){
            prop.properties = Database.query('select Id,CurrencyIsoCode,CD_Agent_Name_User__c,Sold_Agent__c, Name,Status__c,Sales_Price__c,CD_Project__c,Project_Name__c,City_Dubizzle__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c,Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c,CD_isblocked__c, CD_Block_Status__c,CD_Block_Comments__c,CD_Purchase_date__c,CD_Block_Date__c, CD_Agent_Name__c,CD_Mode_of_Payment__c,CD_Payment_Percentage__c,CD_VAT_5__c, CD_Convenyacing_fees__c,CD_Additional_fees__c,CD_Other_fees__c,CD_Net_selling_price__c,CD_Discount__c,CD_Final_net_price__c,CD_Book_Date__c,CD_View__c,CD_Tower__c,Floor_Type__c from cd_Property__c Order By '+sortedBy+' '+sortDirection+' limit '+pageSize+' OFFSET '+offset);
        }else{
            prop.properties = [select Id,CurrencyIsoCode,Sold_Agent__c,CD_Agent_Name_User__c, Name,Status__c,CD_Project__c,Project_Name__c,City_Dubizzle__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, 
                           Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c, 
                           CD_isblocked__c, CD_Block_Status__c,CD_Block_Comments__c,Sales_Price__c,CD_Purchase_date__c,CD_Block_Date__c, CD_Agent_Name__c,CD_Mode_of_Payment__c,CD_Payment_Percentage__c,CD_VAT_5__c, CD_Convenyacing_fees__c,CD_Additional_fees__c,CD_Other_fees__c,CD_Net_selling_price__c,CD_Discount__c,CD_Final_net_price__c,CD_Book_Date__c,CD_View__c,CD_Tower__c,Floor_Type__c
                           from cd_Property__c limit:pageSize OFFSET :offset];
        }
        
        jsonDT = JSON.serialize(prop);
        return jsonDT;
        /*list<cd_Property__c> probList = [select Id, Name,Status__c,CD_Project__c,Project_Name__c,City_Dubizzle__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, 
Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c, 
CD_isblocked__c, CD_Block_Status__c,CD_Block_Comments__c,CD_Purchase_date__c,CD_Block_Date__c, CD_Agent_Name__c,CD_Mode_of_Payment__c,CD_Payment_Percentage__c,CD_VAT_5__c, CD_Convenyacing_fees__c,CD_Additional_fees__c,CD_Other_fees__c,CD_Net_selling_price__c,CD_Discount__c,CD_Final_net_price__c,
(select id,Name,pba__Status__c, InquiryType__c from Inquiries1__r) 
from cd_Property__c];

return probList;*/
    }
    public class propertyWrapper {
        public Integer pageSize {get;set;}
        public Integer pageNumber {get;set;}
        public Integer totalRecords {get;set;}
        public Integer recordStart {get;set;}
        public Integer recordEnd {get;set;}
        public List<cd_Property__c> properties {get;set;}
    }
    @AuraEnabled(cacheable=true)
    public static string getAgentProperty(Integer pageSize, Integer pageNumber,string sortedBy,string sortDirection){
        String jsonDT = '';
        Integer offset = (pageNumber - 1) * pageSize; 
        Integer totalRecords = [SELECT COUNT() FROM cd_Property__c where Status__c IN ('Available','Red Listed','Sold')];
        Integer recordEnd = pageSize * pageNumber; 
        string usrID = UserInfo.getUserId();
        propertyWrapper prop =  new propertyWrapper();  
        prop.pageSize = pageSize;
        prop.pageNumber = pageNumber;
        prop.recordStart = offset + 1;
        prop.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        prop.totalRecords = totalRecords;
        if(string.isNotBlank(sortedBy)){
           prop.properties = Database.query('select Id,CurrencyIsoCode,Sold_Agent__c,Sales_Price__c, CD_Agent_Name_User__c,Name,Status__c,CD_Project__c,Project_Name__c,City_Dubizzle__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c,Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c,CD_isblocked__c, CD_Block_Status__c,CD_Block_Comments__c,CD_Purchase_date__c,CD_Block_Date__c, CD_Agent_Name__c,CD_Mode_of_Payment__c,CD_Payment_Percentage__c,CD_VAT_5__c, CD_Convenyacing_fees__c,CD_Additional_fees__c,CD_Other_fees__c,CD_Net_selling_price__c,CD_Discount__c,CD_Final_net_price__c,CD_Book_Date__c,CD_View__c,CD_Tower__c,Floor_Type__c from cd_Property__c where Status__c IN (\'Available\',\'Red Listed\',\'Sold\') Order By '+sortedBy+' '+sortDirection+' limit '+pageSize+' OFFSET '+offset);
        }else{
            prop.properties = [select Id,CurrencyIsoCode,Sold_Agent__c, CD_Agent_Name_User__c,Name,Status__c,CD_Project__c,Project_Name__c,City_Dubizzle__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, 
                           Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c, 
                           CD_isblocked__c, CD_Block_Status__c,CD_Block_Comments__c,CD_Purchase_date__c,Sales_Price__c,CD_Block_Date__c, CD_Agent_Name__c,CD_Mode_of_Payment__c,CD_Payment_Percentage__c,CD_VAT_5__c, CD_Convenyacing_fees__c,CD_Additional_fees__c,CD_Other_fees__c,CD_Net_selling_price__c,CD_Discount__c,CD_Final_net_price__c,CD_Book_Date__c,CD_View__c,CD_Tower__c,Floor_Type__c
                           from cd_Property__c where Status__c IN ('Available','Red Listed','Sold') limit:pageSize OFFSET :offset];
        }
        
        jsonDT = JSON.serialize(prop);
        return jsonDT;
    }
    @AuraEnabled(cacheable=true)
    public static list<CD_Project__c> getProject(){
        list<CD_Project__c> prjList = [select id, Name from CD_Project__c];
        return prjList;
    } 
    @AuraEnabled
    public static CD_Project__c selectedProject(string projectname)
    {
        CD_Project__c proj =[select id, Name,(select Id,Sold_Agent__c, Name,Status__c,City_Dubizzle__c,Project_Name__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c,CD_Tower__c,Floor_Type__c from Properties__r) from CD_Project__c where Name =: projectname ];
        return proj;
    }
    
    
    @AuraEnabled
    public static list<CD_Project__c> getProjectSelected(string getProjectName){
        string soqlQuery = 'select id, Name from CD_Project__c';
        if(getProjectName != Null){
            soqlQuery += ' where Name = \'' +getProjectName+'\'';
        }
        return Database.query(SoqlQuery);
    }
    
    /*  @AuraEnabled
public static void saveInquiry(string propid,CD_Inquiry__c insertInquiry){
insertInquiry.CD_Property__c=propid;
insert insertInquiry;

}*/
    /* @AuraEnabled(cacheable=true)

public static list<cd_Property__c> getPropertyWithParams(string prodParaId){

list<cd_Property__c> probParaList = [select Id, Name, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c,(select id,Name,pba__Status__c, InquiryType__c from Inquiries1__r)  from cd_Property__c];

return probParaList;
}*/
    @AuraEnabled
    public static string dynamicalResult(Integer pageSize, Integer pageNumber,string getStatus,string getBedNos,string projName,string view,string floorType, string unitSeries, string propSearchTower,string sortedBy,string sortDirection)
    {
        String condition = '';
        String jsonDT = '';
        Integer offset = (pageNumber - 1) * pageSize;
        Integer recordEnd = pageSize * pageNumber;    
        
        string filterQuery = 'SELECT COUNT() FROM cd_Property__c ';
        Id profileId = UserInfo.getProfileId();
        id curreentUserId = UserInfo.getUserId();
        //User ur = [Select id , Agent_Access__c , Super_User_Access__c From User WHERE id =:curreentUserId];
        User ur = [Select id , Inventory_Access__c From User WHERE id =:curreentUserId];
        String profileName =[Select Id, Name from Profile where Id=:profileId].Name;
        system.debug('Profile Name'+profileName);
        
        if(profileName == 'PB Administrator' || profileName == 'PB Listing Manager' || profileName == 'Superuser' || ur.Inventory_Access__c == 'Manager' )
        {
            
            
            //  Integer totalRecords = [SELECT COUNT() FROM cd_Property__c];
            
            String SoqlQuery =	'select Id,CurrencyIsoCode,Sold_Agent__c, CD_Agent_Name_User__c,Sales_Price__c,Name, CD_Floor__c,CD_Final_net_price__c,CD_Project__r.Name,Project_Name__c,CD_Sales_Price__c,CD_Unit_Number__c,CD_Bedrooms__c, CD_Image__c,City_Dubizzle__c,Status__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_isblocked__c, CD_Block_Status__c,CD_Book_Date__c,CD_View__c,CD_Tower__c,Floor_Type__c from cd_Property__c ';
            
            if(getBedNos != null && getStatus == null && projName == null)
            {
                filterQuery += 'where CD_Bedrooms__c = \'' +getBedNos+'\'';
                SoqlQuery += 'where CD_Bedrooms__c = \'' +getBedNos+'\'';
            }		
            // limit:pageSize OFFSET :offset
            else if(getBedNos == null && getStatus != null && projName == null)
            {
                SoqlQuery += 'where Status__c = \'' +getStatus +'\'';
                filterQuery += 'where Status__c = \'' +getStatus +'\'';
                
            }
            
            else if (getBedNos != null && getStatus != null && projName == null)
            {
                SoqlQuery += ' where CD_Bedrooms__c = \'' +getBedNos+'\''+' and Status__c =\'' +getStatus +'\'';
                filterQuery += ' where CD_Bedrooms__c = \'' +getBedNos+'\''+' and Status__c =\'' +getStatus +'\'';
            }	
            else if (getBedNos != null && getStatus == null && projName != null)
            {
                SoqlQuery += ' where CD_Bedrooms__c = \'' +getBedNos+'\''+' and CD_Project__r.Name =\'' +projName +'\'';
                filterQuery += ' where CD_Bedrooms__c = \'' +getBedNos+'\''+' and CD_Project__r.Name =\'' +projName +'\'';
            }
            else if(getBedNos == null && getStatus != null && projName != null)
            {
                SoqlQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\'';
                filterQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\'';
                
            }
            else if(getBedNos == null && getStatus == null && projName != null)
            {
                SoqlQuery += 'where CD_Project__r.Name = \'' +projName +'\'';
                filterQuery += ' where CD_Project__r.Name = \'' +projName +'\'';
                
            }
            else if(getBedNos != null && getStatus != null && projName != null)
            {
                SoqlQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\''+' and CD_Bedrooms__c =\'' +getBedNos +'\'';
                filterQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\''+' and CD_Bedrooms__c =\'' +getBedNos +'\'';
                
            }
            System.debug('SoqlQuery'+SoqlQuery);
            System.debug('filterQuery'+filterQuery);
            
            if(getBedNos == null && getStatus == null && projName == null)
            {
                condition = (String.isNotBlank(view)
                                    ? ' CD_View__c Like \''+'%'+ view + '%'+'\''
                                    : '');
                condition += (String.isNotBlank(floorType)
                                    ? (String.isNotBlank(condition) ? +' AND ' : '') + ' Floor_Type__c = \''+ floorType + '\''
                                    : '');
                condition += (String.isNotBlank(unitSeries)
                                    ? (String.isNotBlank(condition) ? +' AND ' : '') + ' Unit_Series__c = \''+ unitSeries + '\''
                                    : '');
                condition += (String.isNotBlank(propSearchTower)
                                    ? (String.isNotBlank(condition) ? +' AND ' : '') + ' CD_Tower__c like  \''+ '%'+propSearchTower+'%' + '\''
                                    : '');
                
                
                if (String.isNotBlank(condition)) {
                    filterQuery += ' WHERE ';
                    filterQuery += condition;
                    SoqlQuery += ' WHERE ';
                    if(String.isNotBlank(sortedby)){
                        condition += ' Order By '+sortedby+' '+sortDirection;
                    }
                    condition += ' limit ' +pageSize +' OFFSET ' +offset;
                    SoqlQuery += condition;
                    
                }
                
            }
            else
            {
                condition = (String.isNotBlank(view)
                                    ? ' AND CD_View__c Like \''+'%'+ view + '%'+'\''
                                    : '');
                condition += (String.isNotBlank(floorType)
                                    ? ' AND Floor_Type__c = \''+ floorType + '\''
                                    : '');
                condition += (String.isNotBlank(unitSeries)
                                    ?' AND Unit_Series__c = \''+ unitSeries + '\''
                                    : '');
                condition += (String.isNotBlank(propSearchTower)
                                    ?' AND CD_Tower__c like  \''+ '%'+propSearchTower+'%' + '\''
                                    : '');
                
                if (String.isNotBlank(condition)) {
                    filterQuery += condition;
                    if(String.isNotBlank(sortedby)){
                        condition += ' Order By '+sortedby+' '+sortDirection;
                    }
                    condition += ' limit ' +pageSize +' OFFSET ' +offset;
                    SoqlQuery += condition;
                    
                }
                else
                {
                    if(String.isNotBlank(sortedby)){
                        SoqlQuery += ' Order By '+sortedby+' '+sortDirection;
                    }
                    SoqlQuery += ' limit ' +pageSize +' OFFSET ' +offset;
                }
            }	
            system.debug('View: '+view+ 'PN'+ projName +' condition: '+condition);
            system.debug(soqlQuery);
            Integer totalRecords = Database.countQuery(filterQuery); 
            propertyWrapper prop =  new propertyWrapper();  
            prop.pageSize = pageSize;
            prop.pageNumber = pageNumber;
            prop.recordStart = offset + 1;
            prop.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
            prop.totalRecords = totalRecords;
            prop.properties= Database.query(SoqlQuery);
            
            jsonDT = JSON.serialize(prop);
            
        }
        if(profileName == 'PB Agent' || profileName == 'DP_AGENT' || profileName == 'Development Projects'|| ur.Inventory_Access__c == 'Agent')
        {
            String SoqlQuery =	'select Id,CurrencyIsoCode,CD_Agent_Name_User__c,Sold_Agent__c, Name, CD_Floor__c,CD_Final_net_price__c,CD_Project__r.Name,Project_Name__c,CD_Sales_Price__c,CD_Unit_Number__c,CD_Bedrooms__c, CD_Image__c,City_Dubizzle__c,Status__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_isblocked__c, CD_Block_Status__c,CD_Book_Date__c,Sales_Price__c,CD_View__c,CD_Tower__c,Floor_Type__c from cd_Property__c ';
            
            if(getBedNos != null && getStatus == null && projName == null)
            {
                filterQuery += 'where Status__c IN (\'Available\',\'Red Listed\',\'Sold\') and CD_Bedrooms__c = \'' +getBedNos+'\'';
                SoqlQuery += 'where Status__c IN (\'Available\',\'Red Listed\',\'Sold\') and CD_Bedrooms__c = \'' +getBedNos+'\'' ;
            }		
            // limit:pageSize OFFSET :offset
            else if(getBedNos == null && getStatus != null && projName == null)
            {
                SoqlQuery += 'where Status__c = \'' +getStatus +'\'';
                filterQuery += 'where Status__c = \'' +getStatus +'\'';
                
            }
            
            else if (getBedNos != null && getStatus != null && projName == null)
            {
                SoqlQuery += ' where CD_Bedrooms__c = \'' +getBedNos+'\''+' and Status__c =\'' +getStatus +'\'';
                filterQuery += ' where CD_Bedrooms__c = \'' +getBedNos+'\''+' and Status__c =\'' +getStatus +'\'';
            }	
            else if (getBedNos != null && getStatus == null && projName != null)
            {
                SoqlQuery += ' where Status__c IN (\'Available\',\'Red Listed\',\'Sold\') and CD_Bedrooms__c = \'' +getBedNos+'\''+' and CD_Project__r.Name =\'' +projName +'\'';
                filterQuery += ' where Status__c IN (\'Available\',\'Red Listed\',\'Sold\') and CD_Bedrooms__c = \'' +getBedNos+'\''+' and CD_Project__r.Name =\'' +projName +'\'';
            }
            else if(getBedNos == null && getStatus != null && projName != null)
            {
                SoqlQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\'';
                filterQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\'';
                
            }
            else if(getBedNos == null && getStatus == null && projName != null)
            {
                SoqlQuery += 'where Status__c IN (\'Available\',\'Red Listed\',\'Sold\') and CD_Project__r.Name = \'' +projName +'\'';
                filterQuery += ' where Status__c IN (\'Available\',\'Red Listed\',\'Sold\') and CD_Project__r.Name = \'' +projName +'\'';
                
            }
            else if(getBedNos != null && getStatus != null && projName != null)
            {
                SoqlQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\''+' and CD_Bedrooms__c =\'' +getBedNos +'\'';
                filterQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\''+' and CD_Bedrooms__c =\'' +getBedNos +'\'';
                
            }
            System.debug('SoqlQuery'+SoqlQuery);
            System.debug('filterQuery'+filterQuery);
            
            if(getBedNos == null && getStatus == null && projName == null)
            {
                condition = (String.isNotBlank(view)
                                    ? ' CD_View__c Like \''+'%'+ view + '%'+'\''
                                    : '');
                condition += (String.isNotBlank(floorType)
                                    ? (String.isNotBlank(condition) ? +' AND ' : '') + ' Floor_Type__c = \''+ floorType + '\''
                                    : '');
                condition += (String.isNotBlank(unitSeries)
                                    ? (String.isNotBlank(condition) ? +' AND ' : '') + ' Unit_Series__c = \''+ unitSeries + '\''
                                    : '');
                condition += (String.isNotBlank(propSearchTower)
                                    ? (String.isNotBlank(condition) ? +' AND ' : '') + ' CD_Tower__c like  \''+ '%'+propSearchTower+'%' + '\''
                                    : '');
                if (String.isNotBlank(condition)) {
                    filterQuery += ' WHERE ';
                    filterQuery += condition;
                    SoqlQuery += ' WHERE ';
                    if(String.isNotBlank(sortedby)){
                        condition += ' Order By '+sortedby+' '+sortDirection;
                    }
                    condition += ' limit ' +pageSize +' OFFSET ' +offset;
                    SoqlQuery += condition;
                    
                }
                
            }
            else
            {
                condition = (String.isNotBlank(view)
                                    ? ' AND CD_View__c Like \''+'%'+ view + '%'+'\''
                                    : '');
                condition += (String.isNotBlank(floorType)
                                    ? ' AND Floor_Type__c = \''+ floorType + '\''
                                    : '');
                condition += (String.isNotBlank(unitSeries)
                                    ? ' AND Unit_Series__c = \''+ unitSeries + '\''
                                    : '');
                condition += (String.isNotBlank(propSearchTower)
                                    ?' AND CD_Tower__c like  \''+ '%'+propSearchTower+'%' + '\''
                                    : '');
                
                if (String.isNotBlank(condition)) {
                    filterQuery += condition;
                    if(String.isNotBlank(sortedby)){
                        condition += ' Order By '+sortedby+' '+sortDirection;
                    }
                    condition += ' limit ' +pageSize +' OFFSET ' +offset;
                    SoqlQuery += condition;
                    
                }
                else
                {
                    if(String.isNotBlank(sortedby)){
                        SoqlQuery += ' Order By '+sortedby+' '+sortDirection;
                    }
                    SoqlQuery += ' limit ' +pageSize +' OFFSET ' +offset;
                }

            }
            system.debug('View: '+view+ 'PN'+ projName +' condition: '+condition);
            system.debug('String.valueOf(unitSeries)'+String.valueOf(unitSeries)+' unti'+unitSeries);
            system.debug(soqlQuery);
            Integer totalRecords = Database.countQuery(filterQuery); 
            propertyWrapper prop =  new propertyWrapper();  
            prop.pageSize = pageSize;
            prop.pageNumber = pageNumber;
            prop.recordStart = offset + 1;
            prop.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
            prop.totalRecords = totalRecords;
            prop.properties= Database.query(SoqlQuery);
            
            jsonDT = JSON.serialize(prop);
            
        }
        
        return jsonDT;
    }
    
    /*@AuraEnabled
public static list<pba__Request__c> getEnquiries(String propid){

list<pba__Request__c> probList = [select Id,Name,pba__Status__c,InquiryType__c,User_Generated_Inquiry__c,pba__Contact__r.Name from pba__Request__c where Inquired_Property__c=:propid ORDER BY createdDate Desc limit 5];

if(probList.size()> 0)
{
return probList;
}
else
{
return new list<pba__Request__c>();
} 
}*/
    
    /*  @AuraEnabled
Public static void updatePropertyId(string proId){

list<pba__Request__c> inquiryList = [select id, Inquired_Property__c from pba__Request__c ORDER BY createdDate Desc limit 1];

for(pba__Request__c inqList :inquiryList){
inqList.Inquired_Property__c=proId;

}
update inquiryList;

} */
    @AuraEnabled
    public static CD_Approval_Request__c updateProperty(string probId, cd_Property__c propsList){
        //list<cd_Property__c> propsList = [select id, Name, CD_isblocked__c, CD_Block_Status__c,CD_Block_Comments__c from cd_Property__c where id =:probId];
        //list<cd_Property__c> propsList2 = new list<cd_Property__c>();
        String agentId = UserInfo.getUserId();
        propsList.CD_isblocked__c= true;
        propsList.CD_Agent_Name_User__c= UserInfo.getUserId();
        // system.debug(propsList.CD_Agent_Name_User__c);
        propsList.id=probId;
        // propsList.CD_Block_Date__c = System.today();
        system.debug(propsList);
        system.debug('data'+propsList);
        system.debug('ffffff'+ propsList.CD_Block_Date__c);
        update propsList;
        //  propsList.CD_Agent_Name_User__c = UserInfo.getUserId();
        User ur = [SELECT Id, Name FROM User WHERE Name = 'Tareq Darwish'];
        
        CD_Approval_Request__c createnewApprovalReq = new CD_Approval_Request__c();
        createnewApprovalReq.Property__c = probId;
        createnewApprovalReq.CD_Approver_Name__c = ur.Id;
        createnewApprovalReq.CD_Block_Date__c = propsList.CD_Block_Date__c;
        createnewApprovalReq.CD_Status__c = 'Pending';
        createnewApprovalReq.CD_Agent_Name__c = agentId;
        createnewApprovalReq.CD_Blocking_Comments__c = propsList.CD_Block_Comments__c;
        // createnewApprovalReq.CD_Expiry_Date__c=propsList.CD_Block_Date_;
        insert createnewApprovalReq;
        return createnewApprovalReq;
        
    }
    
    
        @AuraEnabled
    public static list<cd_Property__c> searchResults( string propSearchName,string sortedBy,string sortDirection ,string projName )
    {
        System.debug('propSearchName: '+propSearchName);
        System.debug('+++++++++++++projName: '+projName);
        System.debug('+++++++++++++projName: '+String.isBlank(projName));
        list<cd_Property__c> probList = new list<cd_Property__c>();
        if (String.isNotBlank(propSearchName) && String.isBlank(projName))
           {
               System.debug('Inside propSearchName');
               String SoqlVar = '%'+propSearchName+'%';
               
               if(string.isNotBlank(sortedBy)){
                   probList = Database.query('select Id, CD_Agent_Name_User__c,CD_Book_Date__c,Sales_Price__c, Name,Status__c,CD_View__c,City_Dubizzle__c,Project_Name__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Final_net_price__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c,CD_Tower__c,Floor_Type__c from cd_Property__c where Name like \'%'+propSearchName+'%\' Order By '+sortedBy+' '+sortDirection);
               }else{
                   probList = [select Id, CD_Book_Date__c,CD_Agent_Name_User__c,Sales_Price__c, Name,Status__c,CD_View__c,City_Dubizzle__c,Project_Name__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Final_net_price__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c,CD_Tower__c,Floor_Type__c from cd_Property__c where Name like :SoqlVar];
               }
           }
        if (String.isNotBlank(propSearchName) && String.isNotBlank(projName))
           {
               System.debug('Inside propSearchName and projName is not null');
               String SoqlVar = '%'+propSearchName+'%';
               String SoqlVar2 = projName;
               if(string.isNotBlank(sortedBy)){
                   probList = Database.query('select Id, CD_Agent_Name_User__c,Sales_Price__c,CD_Book_Date__c, Name,Status__c,CD_View__c,City_Dubizzle__c,Project_Name__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Final_net_price__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c,CD_Tower__c,Floor_Type__c from cd_Property__c where CD_Project__r.Name = \'' + SoqlVar2 + '\'AND Name like \'%'+propSearchName+'%\' Order By '+sortedBy+' '+sortDirection);
               }else{
                   probList = [select Id, CD_Book_Date__c,CD_Agent_Name_User__c, Sales_Price__c,Name,Status__c,CD_View__c,City_Dubizzle__c,Project_Name__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Final_net_price__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c,CD_Tower__c,Floor_Type__c from cd_Property__c where Name like :SoqlVar AND CD_Project__r.Name =:SoqlVar2 ]; 
               }
           }
        
           
        System.debug('probList: '+probList);
        return probList;
    }
    @AuraEnabled
    public static void setObjectToRecentItems(Id recordId) {
        if (!String.isBlank(recordId)) {
            Schema.SObjectType sObjectType = recordId.getSobjectType();
            String queryString = String.format('SELECT Id, Name FROM {0} WHERE Id =: recordId FOR VIEW', new List<Object>{sObjectType});
            Database.query(queryString);
        }
    }
    
}
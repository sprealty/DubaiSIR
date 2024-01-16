public class managePropertyCls {
    
    @AuraEnabled(cacheable=true)
    public static list<cd_Property__c> getProperty(){
        
        list<cd_Property__c> probList = [select Id, Name,Status__c,CD_Project__c,Project_Name__c,City_Dubizzle__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, 
                                         Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c, 
                                         CD_isblocked__c, CD_Block_Status__c,CD_Block_Comments__c,CD_Purchase_date__c,CD_Block_Date__c, CD_Agent_Name__c,CD_Mode_of_Payment__c,CD_Payment_Percentage__c,CD_VAT_5__c, CD_Convenyacing_fees__c,CD_Additional_fees__c,CD_Other_fees__c,CD_Net_selling_price__c,CD_Discount__c,CD_Final_net_price__c,
                                         CD_Book_Date__c,CD_View__c
                                         from cd_Property__c  ] ;
        
        return probList;
    }
    
    @AuraEnabled(cacheable=true)
    public static list<CD_Project__c> getProject(){
        list<CD_Project__c> prjList = [select id, Name from CD_Project__c];
        return prjList;
    } 
    @AuraEnabled
    public static CD_Project__c selectedProject(string projectname)
    {
        CD_Project__c proj =[select id, Name,(select Id, Name,Status__c,City_Dubizzle__c,Project_Name__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c,CD_Book_Date__c,CD_View__c from Properties__r) from CD_Project__c where Name =: projectname ];
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
    public static list<cd_Property__c> dynamicalResult(string getStatus,string getBedNos,string projName)
    {
        String SoqlQuery =	'select Id, Name, CD_Floor__c,CD_Final_net_price__c,CD_View__c,CD_Project__r.Name,Project_Name__c,CD_Sales_Price__c,CD_Unit_Number__c,CD_Bedrooms__c, CD_Image__c,City_Dubizzle__c,Status__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_isblocked__c, CD_Block_Status__c,CD_Book_Date__c from cd_Property__c ';
        
        if(getBedNos != null && getStatus == null && projName == null)
        {
            
            SoqlQuery += 'where CD_Bedrooms__c = \'' +getBedNos+'\'';
        }		
        
        else if(getBedNos == null && getStatus != null && projName == null)
        {
            SoqlQuery += 'where Status__c = \'' +getStatus +'\'';
            
        }
        
        else if (getBedNos != null && getStatus != null && projName == null)
        {
            SoqlQuery += ' where CD_Bedrooms__c = \'' +getBedNos+'\''+' and Status__c =\'' +getStatus +'\'';
        }	
        else if (getBedNos != null && getStatus == null && projName != null)
        {
            SoqlQuery += ' where CD_Bedrooms__c = \'' +getBedNos+'\''+' CD_Project__r.Name =\'' +projName +'\'';
        }
        else if(getBedNos == null && getStatus != null && projName != null)
        {
            SoqlQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\'';
            
        }
        else if(getBedNos == null && getStatus == null && projName != null)
        {
            SoqlQuery += 'where CD_Project__r.Name = \'' +projName +'\'';
            
        }
        else if(getBedNos != null && getStatus != null && projName != null)
        {
            SoqlQuery += ' where CD_Project__r.Name = \'' +projName+'\''+' and Status__c =\'' +getStatus +'\''+' and CD_Bedrooms__c =\'' +getBedNos +'\'';
            
        }
        
        system.debug(soqlQuery);
        return Database.query(SoqlQuery);
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
    public static String updateProperty(string probId, cd_Property__c propsList){
        system.debug('In  updateProperty'+probId);
        //list<cd_Property__c> propsList = [select id, Name, CD_isblocked__c, CD_Block_Status__c,CD_Block_Comments__c from cd_Property__c where id =:probId];
        //list<cd_Property__c> propsList2 = new list<cd_Property__c>();
        /*       String agentId = UserInfo.getUserId();
string loggedUserName = UserInfo.getName();
system.debug('checking from lwc  '+loggedUserName);
Approver_Details__mdt aprmd =[select id,Approver_Data__c from Approver_Details__mdt limit 1];
system.debug('approver Name  '+aprmd.Approver_Data__c);
string mdtApproverName = aprmd.Approver_Data__c;
//checking from lwc inside if tareq
if(loggedUserName == mdtApproverName)
{
system.debug('checking from lwc inside if tareq ');
propsList.CD_Agent_Name_User__c= UserInfo.getUserId();
// system.debug(propsList.CD_Agent_Name_User__c);
propsList.id=probId;
propsList.Status__c = 'Booked';
//  propsList.CD_Block_Date__c = System.today();
system.debug('data'+propsList);
system.debug('ffffff'+ propsList.CD_Block_Date__c);
update propsList;
return propsList.Status__c;
}
else
{
system.debug('checking from lwc inside if agents '+loggedUserName);
propsList.CD_isblocked__c= true;
propsList.CD_Agent_Name_User__c= UserInfo.getUserId();
// system.debug(propsList.CD_Agent_Name_User__c);
propsList.id=probId;
//  propsList.CD_Block_Date__c = System.today();
system.debug('data'+propsList);
system.debug('ffffff'+ propsList.CD_Block_Date__c);
update propsList;
//  propsList.CD_Agent_Name_User__c = UserInfo.getUserId();
User ur = [SELECT Id, Name FROM User WHERE Name =: mdtApproverName];

CD_Approval_Request__c createnewApprovalReq = new CD_Approval_Request__c();
createnewApprovalReq.Property__c = probId;
createnewApprovalReq.CD_Approver_Name__c = ur.Id;
createnewApprovalReq.CD_Block_Date__c = propsList.CD_Block_Date__c;
createnewApprovalReq.CD_Status__c = 'Pending';
createnewApprovalReq.CD_Agent_Name__c = agentId;
createnewApprovalReq.CD_Blocking_Comments__c = propsList.CD_Block_Comments__c;
// createnewApprovalReq.CD_Expiry_Date__c=propsList.CD_Block_Date_;
insert createnewApprovalReq;
return createnewApprovalReq.CD_Status__c ;
}

*/
        
        String agentId = UserInfo.getUserId();
        string loggedUserName = UserInfo.getName();
        cd_Property__c pr = [SELECT ID ,CD_Project__c FROM cd_Property__c WHERE id =:probId LIMIT 1];
        System.debug('pr.CD_Project__c'+pr.CD_Project__c);
        CD_Project__c proj = [SELECT Id ,Project_Approver__c FROM CD_Project__c WHERE id =:pr.CD_Project__c LIMIT 1 ];
        System.debug('proj.Project_Approver__c'+proj.Project_Approver__c);
        if(proj.Project_Approver__c == null)
        {
            System.debug('Please add aproval in Project before submit for approval');
            return 'Please add aproval in Project before submit for approval';
        }
        else
        {
            	User ur = [SELECT Id, Name FROM User WHERE Id =: proj.Project_Approver__c];
        if(agentId == proj.Project_Approver__c)
        {
            system.debug('checking from lwc inside if tareq ');
            propsList.CD_Agent_Name_User__c= UserInfo.getUserId();
            // system.debug(propsList.CD_Agent_Name_User__c);
            propsList.id=probId;
            propsList.Status__c = 'Red Listed';
            //  propsList.CD_Block_Date__c = System.today();
            system.debug('data'+propsList);
            system.debug('ffffff'+ propsList.CD_Block_Date__c);
            update propsList;
            return propsList.Status__c; 
        }
        else{
            system.debug('In Else ');
            propsList.CD_isblocked__c= true;
            propsList.CD_Agent_Name_User__c= UserInfo.getUserId();
            // system.debug(propsList.CD_Agent_Name_User__c);
            propsList.id=probId;
            //  propsList.CD_Block_Date__c = System.today();
            system.debug('data'+propsList);
            system.debug('ffffff'+ propsList.CD_Block_Date__c);
            update propsList;
            
            CD_Approval_Request__c createnewApprovalReq = new CD_Approval_Request__c();
            createnewApprovalReq.Property__c = probId;
            createnewApprovalReq.CD_Approver_Name__c = proj.Project_Approver__c;
            createnewApprovalReq.CD_Block_Date__c = propsList.CD_Block_Date__c;
            createnewApprovalReq.CD_Status__c = 'Pending';
            createnewApprovalReq.CD_Agent_Name__c = agentId;
            createnewApprovalReq.CD_Blocking_Comments__c = propsList.CD_Block_Comments__c;
            // createnewApprovalReq.CD_Expiry_Date__c=propsList.CD_Block_Date_;
            insert createnewApprovalReq;
            System.debug('createnewApprovalReq id'+createnewApprovalReq.Id);
            System.debug('createnewApprovalReq id'+createnewApprovalReq.Property__c);
            System.debug('createnewApprovalReq id'+createnewApprovalReq.CD_Block_Date__c);
            System.debug('createnewApprovalReq id'+createnewApprovalReq.CD_Approver_Name__c);
            System.debug('createnewApprovalReq id'+createnewApprovalReq.CD_Status__c);
            System.debug('createnewApprovalReq id'+createnewApprovalReq.CD_Agent_Name__c);
            System.debug('createnewApprovalReq id'+createnewApprovalReq.CD_Blocking_Comments__c);
            return createnewApprovalReq.CD_Status__c ; 
        }
        }
        
        
    }
    
    @AuraEnabled
    public static list<cd_Property__c> searchResults(string propSearchName)
    {
        String SoqlVar = '%'+propSearchName+'%';
        
        list<cd_Property__c> probList = [select Id, CD_Book_Date__c, Name,Status__c,CD_View__c,City_Dubizzle__c,Project_Name__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Final_net_price__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c from cd_Property__c where Name like :SoqlVar];
        
        return probList;
        
    }
    /*@AuraEnabled
public static void insertProject(string projectName){
CD_Project__c project = new CD_Project__c();
project.Name=projectName;
insert project;
system.debug(project);

}*/
    @AuraEnabled
    public static void setObjectToRecentItems(Id recordId) {
        if (!String.isBlank(recordId)) {
            Schema.SObjectType sObjectType = recordId.getSobjectType();
            String queryString = String.format('SELECT Id, Name FROM {0} WHERE Id =: recordId FOR VIEW', new List<Object>{sObjectType});
            Database.query(queryString);
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static list<cd_Property__c> getProperty2(){
        
        list<cd_Property__c> probList2 = [select Id, Name,Status__c,CD_Project__c,Project_Name__c,City_Dubizzle__c,CD_Project__r.Name,CD_Unit_Number__c,CD_Bedrooms__c, CD_Floor__c, CD_Image__c,CD_City__c,CD_Country__c, 
                                          Type__c,CD_uaefields_Developer__c,CD_Completion_Status__c,CD_Total_Area__c,CD_uaefields_Furnished__c,CD_Sales_Price__c, 
                                          CD_isblocked__c, CD_Block_Status__c,CD_Block_Comments__c,CD_Purchase_date__c,CD_Block_Date__c, CD_Agent_Name__c,CD_Mode_of_Payment__c,CD_Payment_Percentage__c,CD_VAT_5__c, CD_Convenyacing_fees__c,CD_Additional_fees__c,CD_Other_fees__c,CD_Net_selling_price__c,CD_Discount__c,CD_Final_net_price__c,
                                          CD_Book_Date__c,CD_View__c, CD_uaefield_Property_Sub_Type__c,CD_Title__c,CD_Area__c,CD_Tower__c,CD_Balcony_Area__c,CD_Price_Sq_ft_AED__c,CD_Internal_Area__c
                                          from cd_Property__c limit 1 ] ;
        
        return probList2;
    }
     @AuraEnabled
    public static String submitForApproval(String recordId) {
        try {
            // Create a new approval request
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitting record for approval');
            req.setObjectId(recordId);

            // Submit the request
            Approval.ProcessResult result = Approval.process(req);

            // Process the result
            if (result.isSuccess()) {
                return 'Success';
            } else {
                return 'Error: ' + result.getErrors()[0].getMessage();
            }
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
    
    @AuraEnabled
    public static string saveProperty2(id recid,cd_Property__c listprop){
        listprop.id=recid; 
        
        update listprop;
        string status = 'success';
        return status;              
        
        
    }
    
}
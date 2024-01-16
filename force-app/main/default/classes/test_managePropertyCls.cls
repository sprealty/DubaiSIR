@istest
public class test_managePropertyCls {
	
     @testSetup static void setupmethod() {
         
        Profile pf= [Select Id from profile where Name='System Administrator']; 
        
        String orgId=UserInfo.getOrganizationId(); 
        String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName=orgId+dateString+RandomId; 
        User uu=new User(firstname = 'Benedict',  
                         lastName = 'Texeira', 
                         email = 'vijay@gmail.com', 
                         Username = 'Texeira@sfdc.dev', 
                         EmailEncodingKey = 'ISO-8859-1', 
                         Alias = uniqueName.substring(18, 23), 
                         TimeZoneSidKey = 'America/Los_Angeles', 
                         LocaleSidKey = 'en_US', 
                         LanguageLocaleKey = 'en_US', 
                         gsir_company__c= 'Gulf Sotheby\'s',
                         ProfileId = pf.Id
                        ); 
        
        
        insert uu;
         
     }
    
    @istest
    public static void test_getProperty()
    {
        CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name ='Test property';
        prop.CD_Project__c=proj.id;
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        
        cd_Property__c testProp =[select id,name from cd_Property__c limit 1];
        
        managePropertyCls.getProperty();
         //system.assertEquals('Test property',testProp.Name);
    }
    @istest 
    public static void test_selectedProject()
    {
        CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        string varProj = 'Test Project';
         managePropertyCls.selectedProject(varProj);
      // managePropertyCls.getProjectSelected(varProj);
     		 managePropertyCls.getProject();
    }
    
    @istest
    public static void test_getProjectSelected()
    {
        CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        string varProj = 'Test';
        managePropertyCls.getProjectSelected(varProj);
    }
    
    @istest
    public static void test_dynamicalResult()
    {
         CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name ='Test property';
        prop.CD_Project__c=proj.id;
        prop.Type__c ='Condo';
     	prop.Status__c ='Available';
        prop.City_Dubizzle__c ='Dubai';
        prop.CD_Bedrooms__c = '2BR';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        
        string getType = 'condo';
        string getCity ='Dubai';
        string getStatus ='Available';
        String noOfBed = '2BR';
        string projName ='Wasl';
    
        string empstat =null;
        string empbed = null;
        string empproj = null;
        
        managePropertyCls.dynamicalResult(getStatus,noOfBed,projName);
         managePropertyCls.dynamicalResult(getStatus,empbed,projName);
        managePropertyCls.dynamicalResult(empstat,empbed,projName);
         managePropertyCls.dynamicalResult(empstat,noOfBed,empproj);
        
        
    }
    @istest
    public static void test_updateProperty()
    {
         User user1 = [SELECT Id FROM User WHERE UserName='Texeira@sfdc.dev' limit 1];
         CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        proj.Project_Approver__c = user1.Id;
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name ='Test property';
        prop.CD_Project__c=proj.id;
        prop.CD_Agent_Name_User__c=user1.id;
        prop.CD_Block_Comments__c ='Test comments';
        prop.CD_Block_Date__c = system.today();
        prop.CD_Units__c= 5;
        prop.CD_Payment_Percentage__c = 20;
        prop.CD_Mode_of_Payment__c ='Bank Transfer';
        prop.CD_Purchase_date__c =system.today();
        prop.CD_Agent_Representing_Client__c = 'Test agent';
        prop.CD_Brokerage_Representing_Client__c ='test brokerage';
        prop.CD_Second_Agent__c =user1.id;
        
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        
        
         CD_Approval_Request__c aprReq = new CD_Approval_Request__c();
        	aprReq.CD_Expiry_Date__c = system.today() +3;
        	aprReq.CD_Blocking_Comments__c ='test comment';
        	aprReq.CD_Status__c ='Pending';
        	aprReq.Property__c= prop.Id;
        aprReq.CD_Agent_Name__c =prop.CD_Agent_Name_User__c;
        insert aprReq;
	//	string propId = prop.id;
        cd_Property__c testProp =[select id,name,CD_Agent_Representing_Client__c,CD_Agent_Name_User__c,CD_Purchase_date__c ,CD_Payment_Percentage__c,CD_Mode_of_Payment__c,CD_Block_Comments__c,CD_Block_Date__c,CD_Units__c from cd_Property__c limit 1];
         managePropertyCls.updateProperty(prop.id,testProp);
       // managePropertyCls.updateProperty(propId,testProp);
        
    }
    @istest
     public static void test_searchResults()
         {
				   CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name ='Test property';
        prop.CD_Project__c=proj.id;
        prop.Type__c ='Condo';
     	prop.Status__c ='Available';
        prop.City_Dubizzle__c ='Dubai';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
             
             string searchVar = 'condo';
              managePropertyCls.searchResults(searchVar);
                
         }
    @istest
    public static void test_setObjectToRecentItems()
    {
        
         CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name ='Test property';
        prop.CD_Project__c=proj.id;
        prop.Type__c ='Condo';
     	prop.Status__c ='Available';
        prop.City_Dubizzle__c ='Dubai';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
         managePropertyCls.setObjectToRecentItems(prop.id);
        
    }
}
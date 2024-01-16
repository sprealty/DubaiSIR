@istest
public class Test_ManagePropertyCntrlr {
    
    
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
        Profile pf1= [Select Id from profile where Name='PB Agent']; 
        
        String orgId1=UserInfo.getOrganizationId(); 
        String dateString1=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId1=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName1=orgId+dateString+RandomId; 
        User uuu=new User(firstname = 'Benedict',  
                          lastName = 'Texeirerra', 
                          email = 'vijay@gmail.com', 
                          Username = 'Texeira@sfdryyc.dev', 
                          EmailEncodingKey = 'ISO-8859-1', 
                          Alias = uniqueName.substring(18, 23), 
                          TimeZoneSidKey = 'America/Los_Angeles', 
                          LocaleSidKey = 'en_US', 
                          LanguageLocaleKey = 'en_US', 
                          gsir_company__c= 'Gulf Sotheby\'s',
                          ProfileId = pf1.Id
                         ); 
        
        
        insert uuu;
        
        Profile pf2= [Select Id from profile where Name= 'Development Projects']; 
        
        String orgId2=UserInfo.getOrganizationId(); 
        String dateString2=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId2=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName2=orgId2+dateString2+RandomId2; 
        User uuuu=new User(firstname = 'Ben',  
                          lastName = 'Tex', 
                          email = 'vijaya@gmail.com', 
                          Username = 'Tex@sfdryyc.dev', 
                          EmailEncodingKey = 'ISO-8859-1', 
                          Alias = uniqueName.substring(18, 23), 
                          TimeZoneSidKey = 'America/Los_Angeles', 
                          LocaleSidKey = 'en_US', 
                          LanguageLocaleKey = 'en_US', 
                          gsir_company__c= 'Gulf Sotheby\'s',
                          ProfileId = pf2.Id
                         ); 
        
        
        insert uuuu;
        
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
        ManagePropertyCntrlr.updateProperty(prop.id,testProp);
        // managePropertyCls.updateProperty(propId,testProp);
        
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
        integer pagesize = 10;
        integer pagenumber = 1;
        
        ManagePropertyCntrlr.getProperty(pagesize,pagenumber,'CD_View__c','ASC');
        ManagePropertyCntrlr.getProperty(pagesize,pagenumber,NULL,NULL);
        ManagePropertyCntrlr.getAgentProperty(pagesize,pagenumber,'CD_View__c','ASC');
        ManagePropertyCntrlr.getAgentProperty(pagesize,pagenumber,NULL,NULL);
        
        //system.assertEquals('Test property',testProp.Name);
    }
    
    @istest
    public static void test_getAgentProperty()
    {
        user u1 =[select id from user where Username = 'Texeira@sfdryyc.dev'];
        system.runAs(u1)
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
        integer pagesize = 10;
        integer pagenumber = 1;
        
        ManagePropertyCntrlr.getProperty(pagesize,pagenumber,'CD_View__c','ASC');
        ManagePropertyCntrlr.getProperty(pagesize,pagenumber,NULL,NULL);
        ManagePropertyCntrlr.getAgentProperty(pagesize,pagenumber,'CD_View__c','ASC');
        ManagePropertyCntrlr.getAgentProperty(pagesize,pagenumber,NULL,NULL);
        
        //system.assertEquals('Test property',testProp.Name);
        }
    }
    @istest 
    public static void test_selectedProject()
    {
        CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        string varProj = 'Test Project';
        ManagePropertyCntrlr.selectedProject(varProj);
        // managePropertyCls.getProjectSelected(varProj);
        ManagePropertyCntrlr.getProject(); 
    }
    
    @istest
    public static void test_getProjectSelected()
    {
        CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project';
        insert proj;
        string varProj = 'Test';
        ManagePropertyCntrlr.getProjectSelected(varProj);
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
        prop.CD_View__c = 'Park';
        prop.Floor_Type__c = 'High Floor';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        
        string getType = 'condo';
        string getCity ='Dubai';
        string getStatus ='Available';
        String noOfBed = '2BR';
        string projName ='Wasl';
        string propView = 'Park';
        string propFloorType = 'High Floor';
        string propTower = 'Tower';
        
        
        string empstat =null;
        string empbed = null;
        string empproj = null;
        string empView = null;
        string empFloor = null;
        string empUnitS = null;
        string empTower = null;
        
        integer pagesize = 10;
        integer pagenumber = 1;
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,noOfBed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,noOfBed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,empbed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        // ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,projName,empView,empFloor,empUnitS,empTower);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,noOfBed,empproj,empView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,empbed,empproj,empView,empFloor,empUnitS,empTower,NULL,NULL);
            
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,empView,empFloor,empUnitS,empTower,NULL,NULL);
        
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,noOfBed,empproj,propView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,propView,empFloor,empUnitS,empTower,'CD_View__c','ASC');
        
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,empView,propFloorType,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,empView,propFloorType,'01',empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,noOfBed,empproj,empView,propFloorType,empUnitS,propTower,NULL,NULL);
        
    }
    @istest
    public static void test_dynamicalAgentResult()
    {
        user u1 =[select id from user where Username = 'Texeira@sfdryyc.dev'];
        system.runAs(u1)
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
            prop.CD_View__c = 'Park';
            prop.Floor_Type__c = 'High Floor';
            prop.CD_Tower__c = 'Tower';
            
            list<cd_Property__c> propList = new list <cd_Property__c>();
            propList.add(prop);
            insert propList;
            
            string getType = 'condo';
            string getCity ='Dubai';
            string getStatus ='Available';
            String noOfBed = '2BR';
            string projName ='Wasl';
            string propView = 'Park';
            string propFloorType = 'High Floor';
            string propTower = 'Tower';
            
            
            string empstat =null;
            string empbed = null;
            string empproj = null;
            string empView = null;
            string empFloor = null;
            string empUnitS = null;
            string empTower = null;
            
            integer pagesize = 10;
            integer pagenumber = 1;
            ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,noOfBed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,empbed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        // ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,projName,empView,empFloor,empUnitS,empTower);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,noOfBed,empproj,empView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,empbed,empproj,empView,empFloor,empUnitS,empTower,NULL,NULL);
         ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,noOfBed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
           
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,empView,empFloor,empUnitS,empTower,NULL,NULL);
        
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,noOfBed,empproj,propView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,propView,empFloor,empUnitS,empTower,'CD_View__c','ASC');
        
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,empView,propFloorType,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,empView,propFloorType,'01',empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,noOfBed,empproj,empView,propFloorType,empUnitS,propTower,NULL,NULL);
        
        }   
        
    }
    
    @istest
    public static void test_dynamicalAgentResult2()
    {
        user u1 =[select id from user where Username = 'Tex@sfdryyc.dev'];
        system.runAs(u1)
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
            prop.CD_View__c = 'Park';
            prop.Floor_Type__c = 'High Floor';
            prop.CD_Tower__c = 'Tower';
            
            list<cd_Property__c> propList = new list <cd_Property__c>();
            propList.add(prop);
            insert propList;
            
            string getType = 'condo';
            string getCity ='Dubai';
            string getStatus ='Available';
            String noOfBed = '2BR';
            string projName ='Wasl';
            string propView = 'Park';
            string propFloorType = 'High Floor';
            string propTower = 'Tower';
            
            
            string empstat =null;
            string empbed = null;
            string empproj = null;
            string empView = null;
            string empFloor = null;
            string empUnitS = null;
            string empTower = null;
            
            integer pagesize = 10;
            integer pagenumber = 1;
            ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,noOfBed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,empbed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        // ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,projName,empView,empFloor,empUnitS,empTower);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,noOfBed,empproj,empView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,empbed,empproj,empView,empFloor,empUnitS,empTower,NULL,NULL);
         ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,noOfBed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,projName,empView,empFloor,empUnitS,empTower,NULL,NULL);
           
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,empView,empFloor,empUnitS,empTower,NULL,NULL);
        
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,getStatus,noOfBed,empproj,propView,empFloor,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,propView,empFloor,empUnitS,empTower,'CD_View__c','ASC');
        
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,empView,propFloorType,empUnitS,empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,empbed,empproj,empView,propFloorType,'01',empTower,NULL,NULL);
        ManagePropertyCntrlr.dynamicalResult(pagesize,pagenumber,empstat,noOfBed,empproj,empView,propFloorType,empUnitS,propTower,NULL,NULL);
        
        }   
        
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
        prop.CD_Tower__c = 'West';
        
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        
        string searchVar = 'condo';
        string searchTower = 'West';
        string searchUS = '01';
        string projName = proj.Name;
        ManagePropertyCntrlr.searchResults(searchVar,NULL,NUll,projName);
        
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
        ManagePropertyCntrlr.setObjectToRecentItems(prop.id);
        
    }
}
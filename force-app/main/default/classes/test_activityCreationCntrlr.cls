@istest
public class test_activityCreationCntrlr {
	
     @TestSetup
    static void SetupMethod(){
        
        
        Profile pf= [Select Id from profile where Name='System Administrator']; 
        
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId = Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName = orgId+dateString+RandomId; 
        User uu = new User(firstname = 'Benedict',  
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
    public static void test_createActivities()
    {
        
         User user1 = [SELECT Id,Email FROM User WHERE UserName = 'Texeira@sfdc.dev'];
        
        date expdate = system.today() +1;
        
         CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project1';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name = 'Test property1';
        prop.CD_Project__c = proj.id;
        prop.CD_isblocked__c = true;
        prop.CD_Unit_Number__c = 'Test Unit Number';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        id recotdtypeIdVal=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Payment').getRecordTypeId();
        CD_Approval_Request__c aprReq = new CD_Approval_Request__c();
        aprReq.CD_Expiry_Date__c = expdate;
        aprReq.CD_Blocking_Comments__c = 'test comment1';
        aprReq.CD_Status__c = 'Pending';
        aprReq.Property__c = prop.Id;
        aprReq.CD_Approver_Name__c = user1.Id;
        aprReq.CD_Agent_Name__c = user1.Id;
        
        insert aprReq;
        
        CD_Activity__c testAct = new CD_Activity__c();
        testAct.Name = 'Test activity';
        testAct.CD_Payment__c ='test payment';
        testAct.CD_Receipt_Issued__c ='Yes';
       //  testAct.CD_Property__c =  prop.Id;
        //    testAct.RecordTypeId = recotdtypeIdVal;
        list<CD_Activity__c> actList = new list<CD_Activity__c>();
        actList.add(testAct);
        
         id recotdtypeIdVal2=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Document').getRecordTypeId();
         CD_Activity__c testAct2 = new CD_Activity__c();
        testAct2.Name = 'Test activity';
       // testAct.CD_Payment__c ='test payment';
       // testAct.CD_Receipt_Issued__c ='Yes';
        // testAct2.CD_Property__c =  prop.Id;
         //   testAct2.RecordTypeId = recotdtypeIdVal2;
        list<CD_Activity__c> actList2 = new list<CD_Activity__c>();
        actList2.add(testAct2);
     //   string base64 ='[{0,testbase64value},{1,testValue}]';
       // string filname = '[{0,Test file.pdf},{1,testvalue2}]';
       string base64 ='{"0":"testBase64"}';
        string filname = '{"0":"MicrosoftTeams-image.png"}';
        // insert testAct;
       // activityCreationCntrlr.getActivities(prop.id);
        activityCreationCntrlr.createActivities(actList,prop.id);
         activityCreationCntrlr.createDocumentActivities(actList2,prop.id);
        
    }
    @istest
    public static void test_createDocswithFIles()
    {
          User user1 = [SELECT Id,Email FROM User WHERE UserName = 'Texeira@sfdc.dev'];
        
        date expdate = system.today() +1;
         CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project1';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name = 'Test property1';
        prop.CD_Project__c = proj.id;
        prop.CD_isblocked__c = true;
        prop.CD_Unit_Number__c = 'Test Unit Number';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        id recotdtypeIdVal=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Payment').getRecordTypeId();
        CD_Approval_Request__c aprReq = new CD_Approval_Request__c();
        aprReq.CD_Expiry_Date__c = expdate;
        aprReq.CD_Blocking_Comments__c = 'test comment1';
        aprReq.CD_Status__c = 'Pending';
        aprReq.Property__c = prop.Id;
        aprReq.CD_Approver_Name__c = user1.Id;
        aprReq.CD_Agent_Name__c = user1.Id;
        
        insert aprReq;
        
        CD_Activity__c testAct = new CD_Activity__c();
        testAct.Name = 'Test activity';
        testAct.CD_Payment__c ='test payment';
        testAct.CD_Receipt_Issued__c ='Yes';
       //  testAct.CD_Property__c =  prop.Id;
        //    testAct.RecordTypeId = recotdtypeIdVal;
        list<CD_Activity__c> actList = new list<CD_Activity__c>();
        actList.add(testAct);
        
         id recotdtypeIdVal2=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Document').getRecordTypeId();
         CD_Activity__c testAct2 = new CD_Activity__c();
        testAct2.Name = 'Test activity';
        testAct.CD_Payment__c ='test payment';
        testAct.CD_Receipt_Issued__c ='Yes';
         testAct2.CD_Property__c =  prop.Id;
        testAct2.CD_Index_No__c =0;
            testAct2.RecordTypeId = recotdtypeIdVal2;
        list<CD_Activity__c> actList2 = new list<CD_Activity__c>();
        actList2.add(testAct2);
         ContentVersion content=new ContentVersion(); 
        content.Title='Header_Picture1'; 
        content.PathOnClient='/' + content.Title + '.jpg'; 
        Blob bodyBlob=Blob.valueOf('Unit Test ContentVersion Body'); 
        content.VersionData=bodyBlob; 
        content.origin = 'H';
        insert content;
      /*  ContentDocumentLink contentlink=new ContentDocumentLink();
        //contentlink.LinkedEntityId= testAct2.id;
        contentlink.contentdocumentid=[select contentdocumentid from contentversion where id =: content.id].contentdocumentid;
        contentlink.ShareType = 'I';
        contentlink.Visibility = 'AllUsers';
      contentlink.LinkedEntityId = [select id from CD_Activity__c limit 1].Id;
          insert contentlink; */
      // string base64 ='{"0":"\''+content.id +'\'"}'; 
        string base64 = '{"0": "0681q000005vbldAAA"}';
           //  \'' +getProjectName+'\''
        string filname = '{"0":"MicrosoftTeams-image.png"}';
		activityCreationCntrlr.createActivitiesWithFiles(actList2,prop.id,base64);
    }
    
    @istest
    public static void test_getActiities()
    {
         User user1 = [SELECT Id,Email FROM User WHERE UserName = 'Texeira@sfdc.dev'];
        
        date expdate = system.today() +1;
        
         CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project1';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name = 'Test property1';
        prop.CD_Project__c = proj.id;
        prop.CD_isblocked__c = true;
        prop.CD_Unit_Number__c = 'Test Unit Number';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        id recotdtypeIdVal=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Payment').getRecordTypeId();
        CD_Approval_Request__c aprReq = new CD_Approval_Request__c();
        aprReq.CD_Expiry_Date__c = expdate;
        aprReq.CD_Blocking_Comments__c = 'test comment1';
        aprReq.CD_Status__c = 'Pending';
        aprReq.Property__c = prop.Id;
        aprReq.CD_Approver_Name__c = user1.Id;
        aprReq.CD_Agent_Name__c = user1.Id;
        
        insert aprReq;
        
        CD_Activity__c testAct = new CD_Activity__c();
        testAct.Name = 'Test activity';
        testAct.CD_Payment__c ='test payment';
        testAct.CD_Receipt_Issued__c ='Yes';
         testAct.CD_Property__c =  prop.Id;
            testAct.RecordTypeId = recotdtypeIdVal;
        list<CD_Activity__c> actList = new list<CD_Activity__c>();
        actList.add(testAct);
        insert actList;
        
         id recotdtypeIdVal2=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Document').getRecordTypeId();
         CD_Activity__c testAct2 = new CD_Activity__c();
        testAct2.Name = 'Test activity';
       // testAct.CD_Payment__c ='test payment';
       // testAct.CD_Receipt_Issued__c ='Yes';
         testAct2.CD_Property__c =  prop.Id;
            testAct2.RecordTypeId = recotdtypeIdVal2;
        list<CD_Activity__c> actList2 = new list<CD_Activity__c>();
        actList2.add(testAct2);
         insert actList2;
         activityCreationCntrlr.getActivities(prop.id);
    }
    @isTest
    public static void test_getDocActivities()
    {
        User user1 = [SELECT Id,Email FROM User WHERE UserName = 'Texeira@sfdc.dev'];
        
        date expdate = system.today() +1;
        
         CD_Project__c proj = new CD_Project__c();
        proj.Name = 'Test Project1';
        insert proj;
        
        cd_Property__c prop = new cd_Property__c();
        prop.Name = 'Test property1';
        prop.CD_Project__c = proj.id;
        prop.CD_isblocked__c = true;
        prop.CD_Unit_Number__c = 'Test Unit Number';
        list<cd_Property__c> propList = new list <cd_Property__c>();
        propList.add(prop);
        insert propList;
        id recotdtypeIdVal=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Document').getRecordTypeId();
        CD_Approval_Request__c aprReq = new CD_Approval_Request__c();
        aprReq.CD_Expiry_Date__c = expdate;
        aprReq.CD_Blocking_Comments__c = 'test comment1';
        aprReq.CD_Status__c = 'Pending';
        aprReq.Property__c = prop.Id;
        aprReq.CD_Approver_Name__c = user1.Id;
        aprReq.CD_Agent_Name__c = user1.Id;
        
        insert aprReq;
        
        CD_Activity__c testAct = new CD_Activity__c();
        testAct.Name = 'Test activity';
        testAct.CD_Payment__c ='test payment';
        testAct.CD_Receipt_Issued__c ='Yes';
         testAct.CD_Property__c =  prop.Id;
            testAct.RecordTypeId = recotdtypeIdVal;
        list<CD_Activity__c> actList = new list<CD_Activity__c>();
        actList.add(testAct);
        insert actList;
        
         id recotdtypeIdVal2=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Document').getRecordTypeId();
         CD_Activity__c testAct2 = new CD_Activity__c();
        testAct2.Name = 'Test activity';
       // testAct.CD_Payment__c ='test payment';
       // testAct.CD_Receipt_Issued__c ='Yes';
         testAct2.CD_Property__c =  prop.Id;
            testAct2.RecordTypeId = recotdtypeIdVal2;
        list<CD_Activity__c> actList2 = new list<CD_Activity__c>();
        actList2.add(testAct2);
         insert actList2;
        string base64 ='testbase64value';
        string filname = 'Test file.pdf';
          activityCreationCntrlr.uploadFile(base64,filname,testAct2.id);
        activityCreationCntrlr.getFilesPreview(testAct2.id);
         activityCreationCntrlr.getDocActivities(prop.id);
    }
    
}
public class activityCreationCntrlr {
    
    @AuraEnabled
    
    public static list<CD_Activity__c> createActivities(list<CD_Activity__c> getList,string propId)
    {
        system.debug('cd Activity '+getlist);
        id recotdtypeIdVal=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Payment').getRecordTypeId();
        system.debug('check recordType id' +recotdtypeIdVal);
        list<CD_Activity__c> insertList = new list<CD_Activity__c>();
        for(CD_Activity__c act :getList)
        {
            act.CD_Property__c = propId;
            act.RecordTypeId = recotdtypeIdVal;
            insertList.add(act);
        }
        if(insertList.size() > 0)
        {
            insert insertList;
        }
       
        return insertList;
    }
    
    @AuraEnabled(cacheable = false)
    
    public static list<CD_Activity__c> getActivities(string propId)
    {
        id recotdtypeIdVal=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Payment').getRecordTypeId();
        list<CD_Activity__c> getActList =[select id,CD_Activity__c,CD_Payment__c,CD_Date__c,CD_Installment_Type__c,CD_Invoice_Issued__c,CD_Receipt_Issued__c,CD_Activity_Amount__c from CD_Activity__c where CD_Property__c=: propId and RecordTypeId=: recotdtypeIdVal];
        return getActList;
    }
    @AuraEnabled(cacheable = false)
    
    public static list<CD_Activity__c> getDocActivities(string propId)
    {
        id recotdtypeIdVal=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Document').getRecordTypeId();
        list<CD_Activity__c> getActList =[select id,Documents_Activity__c,CD_Date_Added__c,CD_Days_Pending__c from CD_Activity__c where CD_Property__c=: propId and RecordTypeId=: recotdtypeIdVal];
        return getActList;
    }
    @AuraEnabled
    
    public static list<CD_Activity__c> createDocumentActivities(list<CD_Activity__c> getList,string propId)
    {
        system.debug('cd Activity '+getlist);
        id recotdtypeIdVal=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Document').getRecordTypeId();
        system.debug('check recordType id' +recotdtypeIdVal);
        list<CD_Activity__c> insertList = new list<CD_Activity__c>();
        for(CD_Activity__c act :getList)
        {
            act.CD_Property__c = propId;
            act.RecordTypeId = recotdtypeIdVal;
            insertList.add(act);
        }
        if(insertList.size() > 0)
        {
            insert insertList;
        }
        
        return getList;
    }
    @AuraEnabled
    public static String uploadFile(String base64, String filename,string recordIdv)
    {	
        /*  set<id> Idlist = new Set<id>();
for(Document__c doc: doclist)
{
Idlist.add(doc.Id);
} */
        ContentVersion testContentInsert =new ContentVersion();
        
        testContentInsert.Title =filename;
        
        testContentInsert.VersionData=EncodingUtil.base64Decode(base64);
        
        testContentInsert.PathOnClient='/' + fileName ;
        
        insert testContentInsert;
        
        
        
        system.debug('testContentInsert.id '+ testContentInsert.id);
        
        testContentInsert = [select id, ContentDocumentId from ContentVersion WHERE Id =: testContentInsert.Id];
        
        ContentDocumentLink cl = new ContentDocumentLink();
        
        cl.ContentDocumentId = testContentInsert.ContentDocumentId;
        
        cl.LinkedEntityId = recordIdv;
        
        cl.ShareType = 'V';
        
        cl.Visibility = 'AllUsers';
        
        insert cl;
        
        system.debug('testContentInsert.id');
        
        return testContentInsert.id;
    }
    @AuraEnabled(cacheable = false)
    public static map<id,string> getFilesPreview(String fileId)
    {
        // Get record file IDs        
        List<ContentDocumentLink> ConDocList = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :fileId order by ContentDocument.CreatedDate desc limit 1];
        List<ID> fileIDs = new List<ID>();
        for (ContentDocumentLink ConDocLink : ConDocList) {
            fileIDs.add(ConDocLink.ContentDocumentId);
        }
        
        List<ContentVersion> CVList = [SELECT ContentDocumentId, FileExtension, Title 
                                       FROM ContentVersion WHERE ContentDocumentId IN : fileIDs];
        map<id,string> ContentVersionwithIdandTitle =new map<id,string>();
        //list<string> ContentDocumentfileid=new list<string>();
        for (ContentVersion CVLink : CVList) {
            // ContentDocumentfileid.add(docLink.ContentDocumentId);
            ContentVersionwithIdandTitle.put(CVLink.ContentDocumentId, CVLink.Title);
        }
        system.debug(ContentVersionwithIdandTitle);
        return ContentVersionwithIdandTitle;
        // return ContentDocumentfileid;
    }
    
    
    @AuraEnabled
    
    public static list<ContentDocumentLink> createActivitiesWithFiles(list<CD_Activity__c> getList,string propId,string JSONresponses)
    {
        Map<Integer,String> responses = (Map<Integer,String>)JSON.deserialize(JSONresponses, Map<Integer,String>.class);
        system.debug('deserialized responses'+responses);
      /*  Map<Integer,String> fileNameList = (Map<Integer,String>)JSON.deserialize(filenames, Map<Integer,String>.class);
        system.debug('deserialized fileNames'+fileNameList); */
        system.debug('cd Activity '+getlist);
        id recotdtypeIdVal=Schema.SObjectType.CD_Activity__c.getRecordTypeInfosByDeveloperName().get('CD_Document').getRecordTypeId();
        system.debug('check recordType id' +recotdtypeIdVal);
        list<CD_Activity__c> insertList = new list<CD_Activity__c>();
        for(CD_Activity__c act :getList)
        {
            act.CD_Property__c = propId;
            act.RecordTypeId = recotdtypeIdVal;
            insertList.add(act);
        }
        if(insertList.size() > 0)
        {
            insert insertList;
        }
        // map<id,map<string,string>> fileWithId = new map<id,map<string,string>>();
      
        map<string,string> RecMap = new map<string,string>();
        set<Id> conVerIds = new set<Id>();
        for(CD_Activity__c act :getList)
        {
            decimal ind = act.CD_Index_No__c;
            integer intNum =ind.intValue();
            if(responses.containskey(intNum))
            {
                RecMap.put(responses.get(intNum),act.Id);
                conVerIds.add(responses.get(intNum));
            }
            
        }
            list<ContentDocumentLink> conDocLinkList = new list<ContentDocumentLink>();
            // testContentInsert = [select id, ContentDocumentId from ContentVersion WHERE Id =: testContentInsert.Id];
           list<contentVersion> converList =  [select id, ContentDocumentId from ContentVersion WHERE Id =: conVerIds];
           for(contentVersion conVer : converList)
           {
               if(RecMap.containskey(conVer.id))
               {
                   ContentDocumentLink cl = new ContentDocumentLink();
                   
                   cl.ContentDocumentId = conVer.ContentDocumentId;
                   
                   cl.LinkedEntityId = RecMap.get(conVer.id);
                   
                   cl.ShareType = 'V';
                   
                   cl.Visibility = 'AllUsers';
                   
                   conDocLinkList.add(cl);

               }
           }
        insert conDocLinkList;
    
        return conDocLinkList;
    }
    
    
}
@isTest
private class TestCopyAMLFilesToConveyance {
    
    static testMethod void TestCopyAMLFilesToConveyance() {
        try{
            
            //Create Account
            List<Account> AccountList = new List<Account>();
            Account  AccountObj = new Account();
            AccountObj.Name ='test';
            AccountList.add(AccountObj);
            insert AccountList;
           // system.debug('acc='+acc);
            
            //Create Contact
            List<Contact> ContactList = new List<Contact>();
            Contact ContactObj = new Contact();
            ContactObj.LastName ='test1';
            ContactObj.ContactType__c = 'Buyer';	
            ContactList.add(ContactObj);
            insert ContactList;
            //system.debug('cont ='+cont);
            
            //Create Inquiry
            List<pba__Request__c> InquiryList = new List<pba__Request__c>();
            pba__Request__c InquiryObj = new pba__Request__c();
            InquiryObj.RecordTypeId	='0121t0000008UkHAAU';
            InquiryObj.InquiryType__c = 'Buyer';
            InquiryObj.pba__Bedrooms_pb_min__c = 4;
            InquiryObj.pba__Bedrooms_pb_max__c	 =4;
            InquiryObj.pba__ListingPrice_pb_min__c =5;
            InquiryObj.pba__ListingPrice_pb_max__c	=5;
            InquiryList.add(InquiryObj);
            insert InquiryList;
           // system.debug('inq='+inq);
            
            List<Trigger_Setting__c> SettingList = new List<Trigger_Setting__c>();
            Trigger_Setting__c settingObj = new Trigger_Setting__c();
            settingObj.Is_ContentVersion_Inactive__c = true;
            SettingList.add(settingObj);
            insert SettingList;
            
            //Create AML
            List<AML__c> AMLList = new List<AML__c>();
            AML__c AMLObj = new AML__c();
            AMLObj.Company__c = AccountObj.Id;
            AMLObj.Contact__c = ContactObj.Id;
            AMLObj.Inquiry__c = InquiryObj.Id;
            AMLObj.AML_Type__c = 'Corporate';
            AMLObj.Status__c = 'Draft';
            AMLObj.Role__c = 'Buyer';
            AMLObj.AML_Type__c = 'Individual';
            AMLObj.Upload_Passport__c = 'Yes';
            AMLList.add(AMLObj);
            insert AMLList;
           // system.debug('aml ='+aml);
           
            //Create a ContentVersion for passport
            
            ContentVersion ContentVer = new ContentVersion();
            ContentVer.Title = 'Passport';
            ContentVer.ContentUrl= 'test.com';
            insert ContentVer;
            
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument ];
            ContentDocumentLink contDoc = new ContentDocumentLink();
            contDoc.LinkedEntityId = AMLObj.id;
            contDoc.ShareType='V';
            contDoc.ContentDocumentId =[SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: ContentVer.Id].ContentDocumentId;
            contDoc.Visibility='AllUsers';
            insert contDoc;
            
            //Create a ContentVersion title KYC
            
            ContentVersion ContentVer1 = new ContentVersion();
            ContentVer1.Title = 'KYC';
            ContentVer1.ContentUrl= 'test.com';
            insert ContentVer1;
            List<ContentDocument> documents1 = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument ];
            
            ContentDocumentLink contDoc1 = new ContentDocumentLink();
            contDoc1.LinkedEntityId = AMLObj.id;
            contDoc1.ShareType='V';
            contDoc1.ContentDocumentId =[SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: ContentVer1.Id].ContentDocumentId;
            contDoc1.Visibility='AllUsers';
            insert contDoc1;
            
            //Create a ContentVersion title EID
            ContentVersion ContentVer2 = new ContentVersion();
            ContentVer2.Title = 'EID';
            ContentVer2.ContentUrl= 'test.com';
            insert ContentVer2;
            
            List<ContentDocument> documents2 = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument ];
            
            ContentDocumentLink contDoc2 = new ContentDocumentLink();
            contDoc2.LinkedEntityId = AMLObj.id;
            contDoc2.ShareType='V';
            contDoc2.ContentDocumentId =[SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: ContentVer2.Id].ContentDocumentId;
            contDoc2.Visibility='AllUsers';
            insert contDoc2;
            
            
            //Create a ContentVersion title VISA
            
            ContentVersion ContentVer3 = new ContentVersion();
            ContentVer3.Title = 'VISA';
            ContentVer3.ContentUrl= 'test.com';
            insert ContentVer3;
            
            List<ContentDocument> documents3 = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument ];
            
            ContentDocumentLink contDoc3 = new ContentDocumentLink();
            contDoc3.LinkedEntityId = AMLObj.id;
            contDoc3.ShareType='V';
            contDoc3.ContentDocumentId =[SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: ContentVer3.Id].ContentDocumentId;
            contDoc3.Visibility='AllUsers';
            insert contDoc3;
           
            
            //Create Convenyance  
            List<Conveyance__c> ConveyanceList = new List<Conveyance__c>();     
            Conveyance__c conveyanceObj = new Conveyance__c();
            conveyanceObj.Inquiry__c = InquiryObj.Id;
            conveyanceList.add(conveyanceObj);
            insert ConveyanceList;
            
            ContentVersion ContentVerA = new ContentVersion();
            ContentVerA.Title = 'Passport';
            ContentVerA.ContentUrl= 'test.com';
            insert ContentVerA;
            system.debug('ContentVerA'+ContentVerA);
            
            ContentDocumentLink contDocA1 = new ContentDocumentLink();
            contDocA1.LinkedEntityId = conveyanceObj.Id;
            contDocA1.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: ContentVerA.Id].ContentDocumentId;
            insert contDocA1;
            system.debug('contDocA1'+contDocA1);
            
            ContentVersion ContentVerB = new ContentVersion();
            ContentVerB.Title = 'KYC';
            ContentVerB.ContentUrl= 'test.com';
            insert ContentVerB;
            system.debug('ContentVerB'+ContentVerB);
            
            ContentDocumentLink contDocB1 = new ContentDocumentLink();
            contDocB1.LinkedEntityId = conveyanceObj.Id;
            contDocB1.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: ContentVerB.Id].ContentDocumentId;
            insert contDocB1;
            system.debug('contDocB1'+contDocB1);
            
            ContentVersion ContentVerC = new ContentVersion();
            ContentVerC.Title = 'EID';
            ContentVerC.ContentUrl= 'test.com';
            insert ContentVerC;
            system.debug('ContentVerC'+ContentVerC);
            
            ContentDocumentLink contDocC1 = new ContentDocumentLink();
            contDocC1.LinkedEntityId = conveyanceObj.Id;
            contDocC1.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: ContentVerC.Id].ContentDocumentId;
            insert contDocC1;
            system.debug('contDocC1'+contDocC1);
            
            ContentVersion ContentVerD = new ContentVersion();
            ContentVerD.Title = 'VISA';
            ContentVerD.ContentUrl= 'test.com';
            insert ContentVerD;
            system.debug('ContentVerD'+ContentVerD);
            
            ContentDocumentLink contDocD1 = new ContentDocumentLink();
            contDocD1.LinkedEntityId = conveyanceObj.Id;
            contDocD1.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: ContentVerD.Id].ContentDocumentId;
            insert contDocD1;
            system.debug('contDocD1'+contDocD1);
          
            
            Test.startTest();
            
            Database.update(contDoc);
            Test.stopTest();
            }catch(ListException e){
             System.debug('List exception fired');         
        }
    }    
}
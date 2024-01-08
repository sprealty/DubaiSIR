public with Sharing class ConveyanceChecklist {
@AuraEnabled(cacheable=true)
    public static RequestWrapper fetchRecordData(string recordId) {
         Map<String, Object> inquiryMap = new Map<String, Object>(); // Map to store the field labels and their corresponding values for Inquiry record.
        Map<String, Object> childFieldExistsMap = new Map<String, Object>(); // Map to store field labels and their corresponding values for AMLS.
        Map<String, Object> ListingchildFieldExistsMap = new Map<String, object>(); // Map to store field labels and their corresponding values for Listing.
        Map<String, Object> AccountchildFieldExistsMap = new Map<String, object>(); // Map to store field labels and their corresponding values for Account.
        List<Map<String, Object>> amlList = new List<Map<String, Object>>();
        
        List<os_Conveyance__c> ConvencList= new List<os_Conveyance__c>();
        ConvencList = [SELECT Id, Name, os_Inquiry__c FROM os_Conveyance__c WHERE os_Inquiry__c = :recordId];
        
        List<os_Request__c> requestList= new List<os_Request__c>();
        requestList = [SELECT os_Listing__c FROM os_Request__c WHERE Id = :recordId];
        String listingId = '';
        if(requestList != null && !requestList.isEmpty()) {
            os_Request__c request = requestList[0];
            if(request.os_Listing__c != null) {
                listingId = request.os_Listing__c;
            }
            else
            {
                listingId = '';
                system.debug('Listing NO ID');
            }
        }
        
        system.debug('Id of LISTING - '+listingId);    
        
        
        List<os_Request__c> AccountList= new List<os_Request__c>();
        AccountList = [SELECT os_3rd_Party_Agency__c FROM os_Request__c WHERE Id = :recordId];
        String accId = '';
        if(AccountList != null && !AccountList.isEmpty()) {
            os_Request__c request = AccountList[0];
            if(request.os_3rd_Party_Agency__c	 != null) {
                accId = request.os_3rd_Party_Agency__c	;
            }
            else
            {
                accId = '';
                system.debug('Account NO ID');
            }
        }
        
        system.debug('Id of Account - '+accId);        
        
        
        Schema.DescribeSObjectResult describe = os_Request__c.sObjectType.getDescribe();
        Schema.FieldSet myFieldSet = describe.FieldSets.getMap().get('Checklist_Inquiry_Fields'); // Retrieved the 'Checklist_Inquiry_Fields' field set.
        
        Map<String, String> labelMap = new Map<String, String>();
        if (myFieldSet != null) {
            for (Schema.FieldSetMember fsm : myFieldSet.getFields()) {
                if (fsm != null) {
                    labelMap.put(fsm.getFieldPath(), fsm.getLabel());
                }
            }
        }
        
        // a dynamic SOQL query using the fields in the Checklist_Inquiry_Fields field set
        String query = 'SELECT ';
        for (String field : labelMap.keySet()) {
            String label = labelMap.get(field);
            if (field != 'AMLS__r' && field != 'pba__Favorites__r') {
                query += field + ', ';
                InquiryMap.put(label, false);
            }
        }
        system.debug('Query '+query);
        
        // Added a subquery for the AML__c child object
        query += '(SELECT ';
        Schema.DescribeSObjectResult childDescribe = os_AML__c.sObjectType.getDescribe();
        Schema.FieldSet childFieldSet = childDescribe.FieldSets.getMap().get('Checklist_AML_Fields'); // Retrieved the 'Checklist_AML_Fields' field set.
        Map<String, Object> fieldLabels = new Map<String, Object>();
        if (childFieldSet != null) {  
            for (Schema.FieldSetMember field : childFieldSet.getFields()) {
                Schema.DescribeFieldResult fieldDescribe = field.getSObjectField().getDescribe();
                String label = fieldDescribe.getLabel();
                query += 'os_AML__c.' + field.getFieldPath() + ', ';
                fieldLabels.put(field.getFieldPath(), false);
                childFieldExistsMap.put(label,false);
            }
        }
        // Retrieve describe information for the Contact object and its Name field
        Schema.DescribeSObjectResult contactDescribe = Contact.sObjectType.getDescribe();
        Schema.DescribeFieldResult nameFieldDescribe = contactDescribe.fields.getMap().get('Name').getDescribe();
        String nameFieldLabel = nameFieldDescribe.getLabel();
        // Add the Contact object field -Name to the fieldLabels and childFieldExistsMap
        query += 'os_AML__c.os_Contact__r.Name ';
        fieldLabels.put('os_Contact__r.Name', false);
        childFieldExistsMap.put(nameFieldLabel, false); 
        query = query.substring(0, query.length() - 1) + '  FROM AMLS__r)';
        
        system.debug('chek query 3 - '+query);
        system.debug('AML API NAME- '+fieldLabels);
        system.debug('AML LABEL NAME - '+childFieldExistsMap);
        
        query += '  FROM os_Request__c WHERE Id = :recordId';   
        
        // Execute the dynamic SOQL query
        os_Request__c record = Database.query(query);
        system.debug('1 Query list'+query);
        system.debug('1 Query list'+record);
        Map<String, Object> recordFields = record.getPopulatedFieldsAsMap();  // Populate the fieldExistsMap with fields that exist on the record
        Map<String, Boolean> fieldExistsMap = new Map<String, Boolean>();
        for (String field : recordFields.keySet()) {
            if (field != 'Id' && field != 'AMLS__r' ) {
                String label = labelMap.get(field);
                Object value = recordFields.get(field);
                if (value instanceof String && ((String)value).contains('<a href=')) {
                    value = ((String)value).replaceAll('<.*?>', '');
                }
                InquiryMap.put(label, value);
            }
        }
        
        //    InquiryMap.put('Name', record.Name); 
        
        
        // Populate the map of fields that exist on the AML__c child object   
        List<os_AML__c> amlRecords = record.AMLS__r;
        SObjectType amlSObjectType = os_AML__c.sObjectType;
        Map<String, Schema.SObjectField> amlFieldMap = amlSObjectType.getDescribe().fields.getMap();
        // Create a map that maps field labels to their corresponding API names
        Map<String, String> fieldLabelToApiNameMap = new Map<String, String>();
        for (Schema.SObjectField field : amlFieldMap.values()) {
            String fieldLabel = field.getDescribe().getLabel();
            String apiName = field.getDescribe().getName();
            fieldLabelToApiNameMap.put(fieldLabel, apiName);
        }
        
        for (os_AML__c childRecord : amlRecords) {
            Map<String, Object> childFields = new Map<String, Object>();
            Map<String, Object> childFieldExistsMapForRecord = new Map<String, Object>(childFieldExistsMap);
            //    Map<String, Object> amlMap = new Map<String, Object>();
            childFieldExistsMapForRecord.put('Name', childRecord.os_Contact__r.Name);
            for (String fieldLabel : childFieldExistsMap.keySet()) {
                String fieldApiName = fieldLabelToApiNameMap.get(fieldLabel);
                if (fieldApiName != null && childRecord.get(fieldApiName) != null) {
                    childFields.put(fieldLabel, childRecord.get(fieldApiName));
                    childFieldExistsMapForRecord.put(fieldLabel, childRecord.get(fieldApiName));
                }
            }
            // Add other fields as needed
            childFieldExistsMapForRecord.put('Id', childRecord.Id); // Add this line to include the Id field in amlList
            
            string AMLId = childRecord.Id;
            system.debug('before AML list - '+childFieldExistsMapForRecord);
            
            List<os_AML__c> AmlstaticList= new List<os_AML__c>();
            AmlstaticList = [SELECT Name FROM os_AML__c WHERE Id = :AMLId];
            String AmlName = '';
            if(AmlstaticList != null && !AmlstaticList.isEmpty()) {
                os_AML__c Amlfield = AmlstaticList[0];
                if(Amlfield.Name != null) {
                    AmlName = Amlfield.Name;
                }
            }
            system.debug('00002 Inquiry return '+AmlName); 
            childFieldExistsMapForRecord.put('AML record Name', AmlName);
            amlList.add(childFieldExistsMapForRecord);       
        }
        
        if (!String.isEmpty(listingId)) {
            
            Schema.DescribeSObjectResult listingDescribe = os_Listing__c.sObjectType.getDescribe();
            
            // Retrieve the field set named "Checklist_listing_Fields" for the os_Listing__c object
            Schema.FieldSet listingFieldSet = listingDescribe.FieldSets.getMap().get('Checklist_listing_Fields');
            
            Map<String, String> listingLabelToApiNameMap = new Map<String, String>();
            if (listingFieldSet != null) {
                for (Schema.FieldSetMember fsmlist : listingFieldSet.getFields()) {
                    if (fsmlist != null) {
                        listingLabelToApiNameMap.put(fsmlist.getFieldPath(), fsmlist.getLabel()); 
                    } 
                }
            } 
            
            
            // a dynamic SOQL query using the fields in the Checklist_Inquiry_Fields field set
            
            List<String> fieldNames = new List<String>();
            
            for (String field : listingLabelToApiNameMap.keySet()) {
                String label = listingLabelToApiNameMap.get(field);
                fieldNames.add(field);
                ListingchildFieldExistsMap.put(label, false);
            }
            Try{
                String   listingQuery = 'SELECT ' + String.join(fieldNames, ',') + '   FROM pba__Listing__c WHERE Id = :listingId';          
                system.debug('001 listing Query '+listingQuery);
                os_Listing__c listingRecord = Database.query(listingQuery);
                
                Map<String, Object> recordlistFields = listingRecord.getPopulatedFieldsAsMap();  // Populate the fieldExistsMap with fields that exist on the record
                Map<String, Boolean> fieldExistslistMap = new Map<String, Boolean>();
                for (String field : recordlistFields.keySet()) {
                    // ListingchildFieldExistsMap.put(listingLabelToApiNameMap.get(field), true);
                    String label = listingLabelToApiNameMap.get(field);
                    Object value = recordlistFields.get(field);
                    ListingchildFieldExistsMap.put(label, value);
                }
                ListingchildFieldExistsMap.put('Id', listingRecord.Id);
                
            } 
            
            catch(Exception e)
            {
                system.debug('Error try catch');
            }   
        }
        
        
        
        system.debug('00002 listing return '+ListingchildFieldExistsMap);
        system.debug('00002 Inquiry return '+inquiryMap);
        
        
        
        
        if (!String.isEmpty(accId)) {
            
            Schema.DescribeSObjectResult AccountDescribe = Account.sObjectType.getDescribe();
            
            // Retrieve the field set named "Checklist_Account_Fields" for the Account object
            Schema.FieldSet AccountFieldSet = AccountDescribe.FieldSets.getMap().get('Checklist_Account_Fields');
            
            Map<String, String> AccountLabelToApiNameMap = new Map<String, String>();
            if (AccountFieldSet != null) {
                for (Schema.FieldSetMember fsmacclist : AccountFieldSet.getFields()) {
                    if (fsmacclist != null) {
                        AccountLabelToApiNameMap.put(fsmacclist.getFieldPath(), fsmacclist.getLabel()); 
                    } 
                }
            } 
            
            
            // a dynamic SOQL query using the fields in the Checklist_Inquiry_Fields field set
            
            List<String> fieldaccNames = new List<String>();
            
            for (String field : AccountLabelToApiNameMap.keySet()) {
                String label = AccountLabelToApiNameMap.get(field);
                fieldaccNames.add(field);
                AccountchildFieldExistsMap.put(label, false);
            }
            Try{
                String   AccQuery = 'SELECT ' + String.join(fieldaccNames, ',') + '   FROM Account WHERE Id = :accId';          
                system.debug('001 listing Query '+AccQuery);
                Account AccountRecord = Database.query(AccQuery);
                
                Map<String, Object> recordAccFields = AccountRecord.getPopulatedFieldsAsMap();  // Populate the fieldExistsMap with fields that exist on the record
                Map<String, Boolean> fieldExistsAccMap = new Map<String, Boolean>();
                for (String field : recordAccFields.keySet()) {
                    // AccountchildFieldExistsMap.put(AccountLabelToApiNameMap.get(field), true);
                    String label = AccountLabelToApiNameMap.get(field);
                    Object value = recordAccFields.get(field);
                    AccountchildFieldExistsMap.put(label, value);
                }
                AccountchildFieldExistsMap.put('Id', AccountRecord.Id);
                
            } 
            
            catch(Exception e)
            {
                system.debug('Error try catch Account');
            }   
        }
        
        
        system.debug('00333 Account return '+AccountchildFieldExistsMap);
        
        
        
        // Name of The Inquiry Record
        List<os_Request__c> InquirystaticList= new List<os_Request__c>();
        InquirystaticList = [SELECT Name FROM os_Request__c WHERE Id = :recordId];
        String InqName = '';
        if(InquirystaticList != null && !InquirystaticList.isEmpty()) {
            os_Request__c Inquiryfield = InquirystaticList[0];
            if(Inquiryfield.Name != null) {
                InqName = Inquiryfield.Name;
            } 
        }
        system.debug('00002 Inquiry return '+InqName); 
        inquiryMap.put('Inquiry Name', InqName);
        
        // Id of The Inquiry Record
        List<os_Request__c> InquiryIdList= new List<os_Request__c>();
        InquiryIdList = [SELECT Id FROM os_Request__c WHERE Id = :recordId];
        String InqId = '';
        if(InquiryIdList != null && !InquiryIdList.isEmpty()) {
            os_Request__c Inquiryfield = InquiryIdList[0];
            if(Inquiryfield.Id != null) {
                InqId = Inquiryfield.Id;
            } 
        }
        system.debug('00002 Inquiry return '+InqId); 
        inquiryMap.put('Inquiry Id', InqId);
        
        // Inquiry Type of The Inquiry Record
        List<os_Request__c> InquiryTypeList= new List<os_Request__c>();
        InquiryTypeList = [SELECT os_InquiryType__c FROM os_Request__c WHERE Id = :recordId];
        String InqType = '';
        if(InquiryTypeList != null && !InquiryTypeList.isEmpty()) {
            os_Request__c Inquiryfieldtype = InquiryTypeList[0];
            if(Inquiryfieldtype.os_InquiryType__c != null) {
                InqType = Inquiryfieldtype.os_InquiryType__c;
            } 
        }
        system.debug('00002 Inquiry Type '+InqType); 
        inquiryMap.put('Inquiry Type', InqType);
        
        // Name of The Listing Record
        
        List<os_Listing__c> ListingstaticList= new List<os_Listing__c>();
        ListingstaticList = [SELECT os_Brokers_Listing_ID__c FROM os_Listing__c WHERE Id = :listingId];
        String ListName = '';
        if(ListingstaticList != null && !ListingstaticList.isEmpty()) {
            os_Listing__c Listingfield = ListingstaticList[0];
            if(Listingfield.os_Brokers_Listing_ID__c != null) {
                ListName = Listingfield.os_Brokers_Listing_ID__c;
            }
        }
        system.debug('00002 Inquiry return '+ListName); 
        ListingchildFieldExistsMap.put('Listing Name', ListName);
        
        // Name of The Account Record
        
        List<Account> ACCstaticList= new List<Account>();
        ACCstaticList = [SELECT Name FROM Account WHERE Id = :accId];
        String ACCName = '';
        if(ACCstaticList != null && !ACCstaticList.isEmpty()) {
            Account ACCfield = ACCstaticList[0];
            if(ACCfield.Name != null) {
                ACCName = ACCfield.Name;
            }
        }
        system.debug('00002 Inquiry return '+ACCName); 
        AccountchildFieldExistsMap.put('Agency Name', ACCName);
        
        
        // User and its profile
        
        List<os_Request__c> InquiryUserList= new List<os_Request__c>();
        InquiryUserList = [SELECT os_User_Generated_Inquiry__c	 FROM os_Request__c WHERE Id = :recordId];
        String InqUser = '';
        if(InquiryUserList != null && !InquiryUserList.isEmpty()) {
            os_Request__c InquiryUSER = InquiryUserList[0];
            if(InquiryUSER.os_User_Generated_Inquiry__c	 != null) {
                InqUser = InquiryUSER.os_User_Generated_Inquiry__c	;
            } 
        }
        system.debug('00002 Inquiry User -> '+InqUser); 
        inquiryMap.put('Inquiry User', InqUser);
        
        List<User> UserProfileList= new List<User>();
        UserProfileList = [SELECT Profile.Name FROM User WHERE Id = :InqUser];
        String InqProfile = '';
        if(UserProfileList != null && !UserProfileList.isEmpty()) {
            User InquiryUSER = UserProfileList[0];
            if(InquiryUSER.Profile.Name != null) {
                InqProfile = InquiryUSER.Profile.Name;
            } 
        }
        system.debug('00002 Profile - >'+InqProfile); 
        inquiryMap.put('Inquiry Profile', InqProfile);
        
        
        
        
        
        
        
        return new RequestWrapper(inquiryMap, amlList, ListingchildFieldExistsMap, AccountchildFieldExistsMap, ConvencList);  
        
    }
    
    public class RequestWrapper { 
        @AuraEnabled public Map<String, Object> inquiryMap; // The inquiry map that contains the checklist inquiry fields.
        @AuraEnabled public List<Map<String, Object>> amlList; // The list of AMLS records associated with the main record.
        @AuraEnabled public Map<String, Object> ListingchildFieldExistsMap; // The list of listing records associated with the main record.
        @AuraEnabled public Map<String, Object> AccountchildFieldExistsMap; // The list of Account records associated with the main record.
        @AuraEnabled public list<os_Conveyance__c> ConvencList;
        public RequestWrapper(Map<String, Object> inquiryMap, List<Map<String, Object>> amlList, Map<String, Object> ListingchildFieldExistsMap,  Map<String, Object> AccountchildFieldExistsMap, list<os_Conveyance__c> ConvencList) {
            this.inquiryMap = inquiryMap;
            this.amlList = amlList;
            this.ListingchildFieldExistsMap = ListingchildFieldExistsMap;
            this.AccountchildFieldExistsMap = AccountchildFieldExistsMap;
            this.ConvencList = ConvencList;
        }
        
    }
    
}
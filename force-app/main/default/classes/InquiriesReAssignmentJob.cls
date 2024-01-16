global class InquiriesReAssignmentJob implements Database.Batchable<sObject>, Database.Stateful{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String soql = 'SELECT ID,pba_uaefields__Community_Propertyfinder__c,OwnerId,pba__Status__c FROM pba__Request__c WHERE Assign_Owner_using_Assignment_Rules__c = true and LastModifiedDate <'+(System.now().addHours(-23).addMinutes(-59).format('yyyy-MM-dd\'T\'hh:mm:ss\'z\''));
        if(Test.isRunningTest()){
            soql = 'SELECT ID,pba_uaefields__Community_Propertyfinder__c,OwnerId,pba__Status__c FROM pba__Request__c WHERE B2B_Buyers_Full_Name__c = \'__TEST1__\' limit 1';        
        }
        return Database.getQueryLocator(soql);
    }
    
    public void execute(Database.BatchableContext BC, list<pba__Request__c> records){
        pba__Request__c currRecord;
        System.debug(records);
        for(sObject sObj: records){
            currRecord = (pba__Request__c) sObj;
            List<Inquiry_Reassignment__c> currReassignments = [select id,Agent__c from Inquiry_Reassignment__c where Request__c = :currRecord.Id];
            List<GroupMember> queueMembers = [select userOrGroupId from GroupMember where Group.Name = :'Inquiry Assignment: '+currRecord.pba_uaefields__Community_Propertyfinder__c];

            Set<Id> prevAgentIds = new Set<Id>();

            for(Inquiry_Reassignment__c ir : currReassignments){
                prevAgentIds.add(ir.Agent__c);
            }

            Boolean newAgentFlag = false;
            for(GroupMember gm : queueMembers){
                System.debug('Assigning to Queue Member');
                if(!prevAgentIds.contains(gm.userOrGroupId)){
                    currRecord.OwnerId = gm.userOrGroupId;
                    update currRecord;
                    insert new Inquiry_Reassignment__c(Request__c = currRecord.Id, Agent__c = gm.userOrGroupId, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = 'No Activity', Inquiry_Status_when_Reassigned__c = currRecord.pba__Status__c);
                    newAgentFlag = true;
                    break;
                }
            }

            if(!newAgentFlag){
                System.debug('Assigning back to Queue');
                Group g = [SELECT Id FROM Group where Name = :'Call Center'][0];
                currRecord.OwnerId = g.Id;
                update currRecord;
                insert new Inquiry_Reassignment__c(Request__c = currRecord.Id, IsQueue__c = true, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = 'No Activity', Inquiry_Status_when_Reassigned__c = currRecord.pba__Status__c);
            }


        }
    }
    
    public void finish(Database.BatchableContext BC){
        
    }
}
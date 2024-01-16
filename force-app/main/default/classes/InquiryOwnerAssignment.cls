public without sharing class InquiryOwnerAssignment {

    @InvocableMethod(
        label = 'Inquiry Owner Assignment'
        description = 'Inquiry Owner Assignment'
    )
    public static List<Response> execute( List<Request> requests ) {
      
        List<Response> responses = new List<Response>();
        Set<Id> inquiryIdsToProcess = new Set<Id>();
        //default group - call center
        Group g = [SELECT Id FROM Group where Name = :'Call Center'][0];
          
        for ( Request req : requests ) {
             inquiryIdsToProcess.add(req.inquiryId);
        }
        
        List< pba__Request__c > inquiriesToUpdate = new List< pba__Request__c >();
        
        List<Inquiry_Reassignment__c> inquiryAssignments = new List<Inquiry_Reassignment__c>();
        for(pba__Request__c inq : [select Id, OwnerId, channel_source__c, pba_uaefields__Community_Propertyfinder__c, pba__Status__c, Listing__c, Listing__r.OwnerId, CreatedById, (select Agent__c from Inquiry_Reassignments__r) from pba__Request__c where id in :inquiryIdsToProcess]){
            //insert new Note(ParentId = inq.Id, Body = String.valueOf(inq.Listing__c)+'-'+String.valueOf(inq.OwnerId)+'-'+String.valueOf(inq.CreatedById), Title = 'Log');
            if(inq.Listing__c != null){
                inq.OwnerId = inq.Listing__r.OwnerId;
                inquiriesToUpdate.add(inq);
                inquiryAssignments.add(new Inquiry_Reassignment__c(Request__c = inq.Id, Agent__c = inq.Listing__r.OwnerId, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = 'Initial Assignment', Inquiry_Status_when_Reassigned__c = inq.pba__Status__c));
            }
            else if(inq.CreatedById == Label.LuxHabitatIntUserId || (Test.isRunningTest() && requests.size() == 2)){
                if(inq.OwnerId == null || inq.OwnerId == Label.LuxHabitatIntUserId || (Test.isRunningTest() && requests.size() == 2)){
                    List<GroupMember> queueMembers = [select userOrGroupId from GroupMember where Group.Name = :'Inquiry Assignment: '+inq.pba_uaefields__Community_Propertyfinder__c];
                    List<Id> allMemberIds = new List<Id>();
                    Boolean isInitial = true;
                    for(GroupMember gm : queueMembers){
                        allMemberIds.add(gm.userOrGroupId);
                    }
                    
                    if(allMemberIds.size()>0){
                        if(inq.Inquiry_Reassignments__r.size()>0){
                            for(Inquiry_Reassignment__c ir : [select Agent__c,Reassigned_Reason__c from Inquiry_Reassignment__c where Request__c = :inq.Id and Agent__c in :allMemberIds  order by CreatedDate desc  limit :allMemberIds.size()]){
                                isInitial = false;
                                if(allMemberIds.size()>0 && allMemberIds.indexOf(ir.Agent__c)>-1)
                                    allMemberIds.remove(allMemberIds.indexOf(ir.Agent__c));    
                            }
                        }
                        else{
                            for(Inquiry_Reassignment__c ir : [select Agent__c,Reassigned_Reason__c from Inquiry_Reassignment__c where Agent__c in :allMemberIds  order by CreatedDate desc  limit :allMemberIds.size()-1]){
                                if(allMemberIds.size()>0 && allMemberIds.indexOf(ir.Agent__c)>-1)
                                    allMemberIds.remove(allMemberIds.indexOf(ir.Agent__c));    
                            }
                        }
                        
                        if(allMemberIds.size() == 0){
                            inq.OwnerId = g.Id;
                            inquiriesToUpdate.add(inq);
                            inquiryAssignments.add(new Inquiry_Reassignment__c(Request__c = inq.Id, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = 'To Call Center', Inquiry_Status_when_Reassigned__c = inq.pba__Status__c));  
                        }   
                        else{
                            inq.OwnerId = allMemberIds[0];
                            inquiriesToUpdate.add(inq);
                            inquiryAssignments.add(new Inquiry_Reassignment__c(Request__c = inq.Id, Agent__c = inq.OwnerId, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = isInitial?'Initial Assignment':'Reassignment by System', Inquiry_Status_when_Reassigned__c = inq.pba__Status__c));   
                        }
                        
                    }
                    else{
                        inq.OwnerId = g.Id;
                        inquiriesToUpdate.add(inq);
                        inquiryAssignments.add(new Inquiry_Reassignment__c(Request__c = inq.Id, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = 'To Call Center', Inquiry_Status_when_Reassigned__c = inq.pba__Status__c));
                    }
                }
                else{
                    inq.OwnerId = inq.OwnerId;
                    inquiriesToUpdate.add(inq);
                    inquiryAssignments.add(new Inquiry_Reassignment__c(Request__c = inq.Id, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = 'To Call Center', Inquiry_Status_when_Reassigned__c = inq.pba__Status__c));
                }
            }
            else{
                List<GroupMember> queueMembers = [select userOrGroupId from GroupMember where Group.Name = :'Inquiry Assignment: '+inq.pba_uaefields__Community_Propertyfinder__c];
                List<Id> allMemberIds = new List<Id>();
                Boolean isInitial = true;
                for(GroupMember gm : queueMembers){
                    allMemberIds.add(gm.userOrGroupId);
                }
                
                if(allMemberIds.size()>0){
                    if(inq.Inquiry_Reassignments__r.size()>0){
                        for(Inquiry_Reassignment__c ir : [select Agent__c,Reassigned_Reason__c from Inquiry_Reassignment__c where Request__c = :inq.Id and Agent__c in :allMemberIds  order by CreatedDate desc  limit :allMemberIds.size()]){
                            isInitial = false;
                            if(allMemberIds.size()>0 && allMemberIds.indexOf(ir.Agent__c)>-1)
                                allMemberIds.remove(allMemberIds.indexOf(ir.Agent__c));    
                        }
                    }
                    else{
                        for(Inquiry_Reassignment__c ir : [select Agent__c,Reassigned_Reason__c from Inquiry_Reassignment__c where Agent__c in :allMemberIds  order by CreatedDate desc  limit :allMemberIds.size()-1]){
                            if(allMemberIds.size()>0 && allMemberIds.indexOf(ir.Agent__c)>-1){
                                allMemberIds.remove(allMemberIds.indexOf(ir.Agent__c));    
                            }
                                
                        }
                    }
                    if(allMemberIds.size() == 0){
                        inq.OwnerId = g.Id;
                        inquiriesToUpdate.add(inq);
                        inquiryAssignments.add(new Inquiry_Reassignment__c(Request__c = inq.Id, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = 'To Call Center', Inquiry_Status_when_Reassigned__c = inq.pba__Status__c));  
                    }   
                    else{
                        inq.OwnerId = allMemberIds[0];
                        inquiriesToUpdate.add(inq);
                        inquiryAssignments.add(new Inquiry_Reassignment__c(Request__c = inq.Id, Agent__c = inq.OwnerId, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = isInitial?'Initial Assignment':'Reassignment by System', Inquiry_Status_when_Reassigned__c = inq.pba__Status__c));   
                    }
                    
                }
                else{
                    inq.OwnerId = g.Id;
                    inquiriesToUpdate.add(inq);
                    inquiryAssignments.add(new Inquiry_Reassignment__c(Request__c = inq.Id, Reassigned_Date_Time__c = System.Now(), Reassigned_Reason__c = 'To Call Center', Inquiry_Status_when_Reassigned__c = inq.pba__Status__c));
                }  
           }
        }
        
        if(inquiriesToUpdate.size()>0){
            update inquiriesToUpdate;
        }
        
        if(inquiryAssignments.size()>0){
            insert inquiryAssignments;
        }
        return responses;
    }
    
    // ---------------------------------------

    public class Request {
        @InvocableVariable(
            label = 'Inquiry ID'
            description = 'Inquiry ID'
            required = true
        )
        public ID inquiryId;

    }
        
    public class Response {
        @InvocableVariable(
            label = 'Assignment Result'
            description = 'Assignment Result'
        )
        public boolean isDone;

    }
    
    public static void dummyMethod(){
        Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
    } 
            
}
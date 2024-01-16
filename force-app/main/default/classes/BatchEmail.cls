public class BatchEmail  implements database.Batchable<sObject>{
    
    public database.QueryLocator start(database.BatchableContext bc){
        date curDate = system.today()+1;
        //return (database.getQueryLocator([select id,lastName,email  from contact ]));
        system.debug('inside start');
        
        return ( database.getQueryLocator([select id, CD_Approver__c, CD_Approver_Email__c, CD_AgentName_txt__c, CD_Property_Name__c, Property__c from CD_Approval_Request__c where CD_Status__c='Pending'and CD_Expiry_Date__c =:curDate ]));        
    }
    public void execute(database.BatchableContext bc,list<CD_Approval_Request__c>lstAprl){
        system.debug('inside execute');
        System.debug('lstAprl is '+lstAprl);
        
        //User ur = [SELECT Id, Name FROM User WHERE Name = 'Tareq Darwish'];
        
        EmailTemplate et = [SELECT Id, Name, Subject, Body FROM EmailTemplate WHERE name = 'Inventory Approval Request'];
        system.debug('et test template '+et);
        for(CD_Approval_Request__c a : lstAprl){
            system.debug('Inside for');
            System.debug('a is'+a);
            System.debug('a.CD App'+a.CD_Approver__c);
            //System.debug('a user is'+a.user);
            string htmlBody = et.Body;
            htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_Approver__c}', a.CD_Approver__c);
            htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_AgentName_txt__c}',a.CD_AgentName_txt__c);
            htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_Property_Name__c}', a.CD_Property_Name__c);
            
            // For Testing
            
            //htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_Approver__c}', ur.Name);
            //htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_AgentName_txt__c}', ur.Name);
            //htmlBody = htmlBody.replace('{!CD_Approval_Request__c.CD_Property_Name__c}', a.CD_Property_Name__c);
            Messaging.SingleEmailMessage email =  new  Messaging.SingleEmailMessage();
             //email.setToAddresses( new List<String> {'harishraja411@gmail.com'});
            list<String> ToAddress = new list<String>();
            ToAddress.add(a.CD_Approver_Email__c);
            //ToAddress.add(a.CD_Agent_Email__c);
            
            //For Testing
            
            //ToAddress.add('harishraja411@gmail.com');
            //ToAddress.add('sureshmahath@gmail.com');
            email.setToAddresses(ToAddress);
            //email.setToAddresses(new List<String> {CD_Approval_Request__c.CD_Approver_Email__c});
            //email.setWhatId(a.Id);
            system.debug('what id '+a.id);
            email.setTemplateId(et.Id);
            system.debug('set template id' + et.id);
            email.setSubject(et.Subject);
            system.debug('set subject '+et.Subject);
            email.setPlainTextBody(htmlBody);
            system.debug('set platin text body '+htmlBody);
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {email});
            
        }
    }
    public void finish(database.BatchableContext bc){
        
    }
}
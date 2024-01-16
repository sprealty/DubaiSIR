public class UnitTriggerHandler {
    public static void handleAfterUpdate(List<CD_Property__c> newUnits, Map<Id, CD_Property__c> oldUnitMap) {
        List<CD_Property__c> unitsWithChangedStatus = new List<CD_Property__c>();
        
        // Check for changes in unit status
        for (CD_Property__c newUnit : newUnits) {
            CD_Property__c oldUnit = oldUnitMap.get(newUnit.Id);
            if (oldUnit != null && newUnit.Status__c != oldUnit.Status__c) {
                unitsWithChangedStatus.add(newUnit);
            }
        }
        
        // Send email alerts for units with changed status
        if (!unitsWithChangedStatus.isEmpty()) {
            sendEmailAlerts(unitsWithChangedStatus);
        }
    }
    @TestVisible
    private static void sendEmailAlerts(List<CD_Property__c> units) {
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        
        for (CD_Property__c unit : units) {
            if (unit.CD_Property_owner_Contact__c != null) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setTemplateId('00X3O000003RFamUAG');
                email.setTargetObjectId(unit.CD_Property_owner_Contact__c);
                email.setWhatId(unit.Id);
                email.setToAddresses(new String[] { 'admin@example.com' });
                emailMessages.add(email);
            }else{
                System.debug('Skipping email for CD_Property__c record with Id: ' + unit.Id + ' due to missing CD_Property_owner_Contact__c');
            }
            
        }
        
        // Send the email alerts
        if(!emailMessages.isEmpty()){
            Messaging.SendEmailResult[] results = Messaging.sendEmail(emailMessages);
            // Handle the results if needed
            for (Messaging.SendEmailResult result : results) {
                if (result.isSuccess()) {
                    System.debug('Email sent successfully.');
                } else {
                    System.debug('Error sending email: ' + result.getErrors()[0].getMessage());
                }
            }
        }
    }
}
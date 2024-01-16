global class InquiriesReAssignmentJobScheduler implements Schedulable{
    global void execute(SchedulableContext sc){       
        InquiriesReAssignmentJob batchObj = new InquiriesReAssignmentJob();
        database.executeBatch(batchObj,1);
    }
}
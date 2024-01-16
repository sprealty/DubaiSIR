public class batchEmailScheduler implements schedulable {
    
    public void execute(SchedulableContext sc){
        batchEmail be = new batchEmail();
        database.executeBatch(be);
        //System.scheduleBatch(batchable, jobName, minutesFromNow);
    }

}
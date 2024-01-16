public class closingTriggerHandler {
    
    /******** method for After Insert ********/
    public void closingUpdate(list<pba__Closing__c> closingList)
    {
        list<pba__Closing__Share> closeShareList = new list<pba__Closing__Share>();
        for(pba__Closing__c cls: closingList)
        {
            if(cls.gsir_closing_broker__c != null)
            {
                pba__Closing__Share closShare = new pba__Closing__Share ();
                closShare.ParentId = cls.Id;
                closShare.UserOrGroupId = cls.gsir_closing_broker__c;
                closShare.RowCause = 'manual';
                closShare.AccessLevel= 'Read';
                closeShareList.add(closShare);
            }
            
            if(cls.gsir_second_broker__c != null)
            {
                pba__Closing__Share closShare = new pba__Closing__Share ();
                closShare.ParentId = cls.Id;
                closShare.UserOrGroupId = cls.gsir_second_broker__c;
                closShare.RowCause = 'manual';
                closShare.AccessLevel= 'Read';
                closeShareList.add(closShare);
            }
            if(cls.gsir_third_broker__c != null)
            {
                pba__Closing__Share closShare = new pba__Closing__Share ();
                closShare.ParentId = cls.Id;
                closShare.UserOrGroupId = cls.gsir_third_broker__c;
                closShare.RowCause = 'manual';
                closShare.AccessLevel= 'Read';
                closeShareList.add(closShare);
            }
            
            if(cls.gsir_fourth_broker__c != null)
            {
                pba__Closing__Share closShare = new pba__Closing__Share ();
                closShare.ParentId = cls.Id;
                closShare.UserOrGroupId = cls.gsir_fourth_broker__c;
                closShare.RowCause = 'manual';
                closShare.AccessLevel= 'Read';
                closeShareList.add(closShare);
            }
            
        }
        
        if(closeShareList.size() > 0)
        {
            insert closeShareList;
        }
        //return closeShareList;       
    }
    
    
    /******** method for After Update ********/
    public void onClosingUpdate(list<pba__Closing__c> closingList, map<id,pba__Closing__c> newClsmap,  map<id,pba__Closing__c> oldClsMap){
        
        set<id> closingIdSet = new set<id>();
        Set<Id> newUserIdSet = new Set<Id>();
        Set<Id> oldClsIdset =  new set<id>();
        Set<id> oldUserIdSet = new set<Id>();
        
        List<pba__Closing__share> insertCloseShareList = new List<pba__Closing__share>();
        List<pba__Closing__share> deleteCloseShareList = new List<pba__Closing__share>();

        /********** Insert Share records **********/
        for(pba__Closing__c cls1 : closingList){
            
            oldClsIdset.add(cls1.id);
                            
            if (cls1.gsir_closing_broker__c != Null && cls1.gsir_closing_broker__c != oldClsMap.get(cls1.id).gsir_closing_broker__c){
                
                oldUserIdSet.add(oldClsMap.get(cls1.id).gsir_closing_broker__c);
                newUserIdSet.add(newClsMap.get(cls1.id).gsir_closing_broker__c);
                
                pba__Closing__Share closShare = new pba__Closing__Share ();
                closShare.ParentId = cls1.Id;
                closShare.UserOrGroupId = cls1.gsir_closing_broker__c;
                closShare.RowCause = 'manual';
                closShare.AccessLevel= 'Read';
                insertCloseShareList.add(closShare);
                
            } else if (cls1.gsir_closing_broker__c == Null && cls1.gsir_closing_broker__c != oldClsMap.get(cls1.id).gsir_closing_broker__c){
                oldUserIdSet.add(oldClsMap.get(cls1.id).gsir_closing_broker__c);
            }
            
            system.debug('CB old:'+oldClsMap.get(cls1.id).gsir_closing_broker__c);
            system.debug('CB :'+cls1.gsir_closing_broker__c);
            
            if (cls1.gsir_second_broker__c != Null && cls1.gsir_second_broker__c != oldClsMap.get(cls1.id).gsir_second_broker__c){
                
                oldUserIdSet.add(oldClsMap.get(cls1.id).gsir_second_broker__c);
                newUserIdSet.add(newClsMap.get(cls1.id).gsir_second_broker__c);
                    
                pba__Closing__Share closShare = new pba__Closing__Share ();
                closShare.ParentId = cls1.Id;
                closShare.UserOrGroupId = cls1.gsir_second_broker__c;
                closShare.RowCause = 'manual';
                closShare.AccessLevel= 'Read';
                insertCloseShareList.add(closShare);
                
            } else if (cls1.gsir_second_broker__c == Null && cls1.gsir_second_broker__c != oldClsMap.get(cls1.id).gsir_second_broker__c) {
                oldUserIdSet.add(oldClsMap.get(cls1.id).gsir_second_broker__c);
            }
            system.debug('SB old :'+oldClsMap.get(cls1.id).gsir_second_broker__c);
            system.debug('SB :'+cls1.gsir_second_broker__c);
            
            if (cls1.gsir_third_broker__c != Null && cls1.gsir_third_broker__c != oldClsMap.get(cls1.id).gsir_third_broker__c){
                
                oldUserIdSet.add(oldClsMap.get(cls1.id).gsir_third_broker__c);
                newUserIdSet.add(newClsMap.get(cls1.id).gsir_third_broker__c);
                
                pba__Closing__Share closShare = new pba__Closing__Share ();
                closShare.ParentId = cls1.Id;
                closShare.UserOrGroupId = cls1.gsir_third_broker__c;
                closShare.RowCause = 'manual';
                closShare.AccessLevel= 'Read';
                insertCloseShareList.add(closShare);
                
            } else if (cls1.gsir_third_broker__c == Null && cls1.gsir_third_broker__c != oldClsMap.get(cls1.id).gsir_third_broker__c) {
                oldUserIdSet.add(oldClsMap.get(cls1.id).gsir_third_broker__c);
            }
            
            system.debug('TB old :'+oldClsMap.get(cls1.id).gsir_third_broker__c);
            system.debug('TB :'+cls1.gsir_third_broker__c);
            
            if (cls1.gsir_fourth_broker__c != Null && cls1.gsir_fourth_broker__c != oldClsMap.get(cls1.id).gsir_fourth_broker__c){
                
                oldUserIdSet.add(oldClsMap.get(cls1.id).gsir_fourth_broker__c);
                newUserIdSet.add(newClsMap.get(cls1.id).gsir_fourth_broker__c);
                
                pba__Closing__Share closShare = new pba__Closing__Share ();
                closShare.ParentId = cls1.Id;
                closShare.UserOrGroupId = cls1.gsir_fourth_broker__c;
                closShare.RowCause = 'manual';
                closShare.AccessLevel= 'Read';
                insertCloseShareList.add(closShare);
                
            } else if (cls1.gsir_fourth_broker__c == Null && cls1.gsir_fourth_broker__c != oldClsMap.get(cls1.id).gsir_fourth_broker__c) {
                oldUserIdSet.add(oldClsMap.get(cls1.id).gsir_fourth_broker__c);
            }
            
            system.debug('FB old :'+oldClsMap.get(cls1.id).gsir_fourth_broker__c);
            system.debug('FB :'+cls1.gsir_fourth_broker__c);
        }
        
        system.debug('Update Share List: '+insertCloseShareList.size());
        
        if(insertCloseShareList != Null && insertCloseShareList.size() > 0){
            database.insert (insertCloseShareList, false);
        }
        
        /**********  Delete Old Share record  **********/
        
        system.debug('OldUserIdSet :'+oldUserIdSet);
        system.debug('oldClsIdset :'+oldClsIdset);
        
        List<pba__Closing__share> clsShareList = [select id, parentId, userOrGroupId, ROwCause from pba__Closing__share 
                                                  where parentId IN: oldClsIdset and userOrGroupId IN: oldUserIdSet and userOrGroupId NOT IN: newUserIdSet];
        
        for(pba__Closing__share clsShare : clsShareList){
            if(oldUserIdSet.contains(clsShare.UserOrGroupId)){
                deleteCloseShareList.add(clsShare);
           } 
        }
        
        system.debug('deleteCloseShareList :'+deleteCloseShareList.size()); 
        
        if(deleteCloseShareList != Null && deleteCloseShareList.size()>0){
            database.delete (deleteCloseShareList, false);
        }
        
    }
    
}
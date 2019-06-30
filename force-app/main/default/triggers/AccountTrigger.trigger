trigger AccountTrigger on Account (before insert, after insert, before update, after update) {
    
    if (Trigger.isUpdate && Trigger.isAfter) {
        AccountTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
    }
    
}
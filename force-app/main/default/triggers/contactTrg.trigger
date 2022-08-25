
trigger contactTrg on Contact (before insert,before update,after insert, after update) {
    
    if(trigger.isAfter && trigger.isInsert) {
   
          ContactTriggerHandler.crtCase(Trigger.new);
        
    }
}
trigger LeadTrigger on Lead (before insert, after insert, before update, after update) {
    LeadTriggerHandler.handleTrigger(
        Trigger.new,
        Trigger.oldMap,
        Trigger.isBefore,
        Trigger.isAfter,
        Trigger.operationType
        //1
    );
}

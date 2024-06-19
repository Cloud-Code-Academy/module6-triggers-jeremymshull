trigger OpportunityTrigger on Opportunity (before update, before delete) {
  if (Trigger.isBefore) {
    if (Trigger.isUpdate) {
      OpportunityTriggerHandler.beforeUpdate(Trigger.new);
    }

    if (Trigger.isDelete) {
      OpportunityTriggerHandler.beforeDelete(Trigger.old);
    }
  }
}
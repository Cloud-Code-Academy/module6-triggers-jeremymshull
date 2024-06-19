trigger OpportunityTrigger on Opportunity (before update) {
  if (Trigger.isBefore) {
    if (Trigger.isUpdate) {
      OpportunityTriggerHandler.beforeUpdate(Trigger.new);
    }
  }
}
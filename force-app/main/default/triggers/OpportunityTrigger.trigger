trigger OpportunityTrigger on Opportunity (before update, before delete) {
  switch on Trigger.OperationType {
    when BEFORE_UPDATE {
      OpportunityTriggerHandler.beforeUpdate(Trigger.new);
    }
    when BEFORE_DELETE {
      OpportunityTriggerHandler.beforeDelete(Trigger.old);
    }
  }
}
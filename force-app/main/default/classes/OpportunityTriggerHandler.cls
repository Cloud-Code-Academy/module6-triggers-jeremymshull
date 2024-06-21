public class OpportunityTriggerHandler {
    // Handler methods
    public static void beforeUpdate (List<Opportunity> newOpps) {
        validateOpportunityAmmount(newOpps);
        setPrimaryContact(newOpps);
    }    
    
    public static void beforeDelete (List<Opportunity> oldOpps) {
        preventDeletionOfClosedWonOppsForBanking(oldOpps);
    }
    
    // Helper methods
    private static void validateOpportunityAmmount (List<Opportunity> newOpps) {
        /*
        * Question 5
        * Opportunity Trigger
        * When an opportunity is updated validate that the amount is greater than 5000.
        * Error Message: 'Opportunity amount must be greater than 5000'
        * Trigger should only fire on update.
        */
        for (Opportunity opp : newOpps) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }    
        
    private static void setPrimaryContact (List<Opportunity> newOpps) {
       /*
        * Question 7
        * Opportunity Trigger
        * When an opportunity is updated set the primary contact on the opportunity to the contact on the same account with the title of 'CEO'.
        * Trigger should only fire on update.
        */
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : newOpps) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }     
        }

        Map<Id, Contact> accToContactMap = new Map<Id, Contact>();
        for (Contact con : [SELECT Id, AccountId FROM Contact WHERE Title = 'CEO' AND AccountID IN :accountIds]) {
            if (!accToContactMap.containsKey(con.AccountId)) {
                accToContactMap.put(con.AccountId, con);
            }
        }

        for (Opportunity opp : newOpps) {
            Contact ceoContact = accToContactMap.get(opp.AccountId);
            if (ceoContact != null) {
                opp.Primary_Contact__c = ceoContact.Id;
            }   
        } 
    }    

    private static void preventDeletionOfClosedWonOppsForBanking (List<Opportunity> oldOpps) {
        /*
        * Question 6
        * Opportunity Trigger
        * When an opportunity is deleted prevent the deletion of a closed won opportunity if the account industry is 'Banking'.
        * Error Message: 'Cannot delete closed opportunity for a banking account that is won'
        * Trigger should only fire on delete.
        */
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp: oldOpps) {
            accountIds.add(opp.AccountId);
        }

        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :accountIds]);
        for (Opportunity opp : oldOpps)  {
            Account acc = accountMap.get(opp.AccountId); 
            if (opp.StageName == 'Closed Won' && acc.Industry == 'Banking') {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }    
}

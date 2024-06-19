public class AccountTriggerHandler {
    public static void beforeInsert(List<Account> newAccounts) {
        /*
        * Question 1
        * Account Trigger
        * When an account is inserted change the account type to 'Prospect' if there is no value in the type field.
        * Trigger should only fire on insert.
        */
        for (Account acc : newAccounts) {
            if (acc.Type == null) {
              acc.Type = 'Prospect';
            }
        }
    }
}
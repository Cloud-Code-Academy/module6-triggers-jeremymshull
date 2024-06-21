public class AccountTriggerHandler {
    public static void beforeInsert (List<Account> newAccounts) {
        acctTypeProspect(newAccounts);
        copyShippingAddressToBillingAddress(newAccounts);
        setAcctRatingToHot(newAccounts);
    }
    
    public static void afterInsert (List<Account> newAccounts) {
        createDefaultContact(newAccounts);
    }

    private static void acctTypeProspect (List<Account> newAccounts) {
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
    
    private static void copyShippingAddressToBillingAddress (List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            /*
            * Question 2
            * Account Trigger
            * When an account is inserted copy the shipping address to the billing address.
            * BONUS: Check if the shipping fields are empty before copying.
            * Trigger should only fire on insert.
            */
            // Check if shipping fields are populated
            if (acc.ShippingStreet != null && 
                acc.ShippingCity != null && 
                acc.ShippingState != null && 
                acc.ShippingPostalCode != null && 
                acc.ShippingCountry != null) {
            // Copy shipping address to billing address
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
        }
    }

    private static void setAcctRatingToHot (List<Account> newAccounts) {
        for (Account acc : newAccounts) {
           /*
            * Question 3
            * Account Trigger
            * When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
            * Trigger should only fire on insert.
            */
            if (acc.Phone != null &&
                acc.Website != null &&
                acc.Fax != null) {
                acc.Rating = 'Hot';
            } 
        }
    }
                
    private static void createDefaultContact (List<Account> newAccounts) {
        /*
        * Question 4
        * Account Trigger
        * When an account is inserted create a contact related to the account with the following default values:
        * LastName = 'DefaultContact'
        * Email = 'default@email.com'
        * Trigger should only fire on insert.
        */
        
        // Create List to store Contacts related to accounts
        List<Contact> contsToInsert = new List<Contact>();
        
        for (Account acc : newAccounts) {
            Contact newContact = new Contact(
                LastName = 'DefaultContact',
                Email = 'default@email.com',
                AccountId = acc.Id
            );
            
            contsToInsert.add(newContact);
        }

        // Insert list of contacts
        insert contsToInsert;
    }        
}
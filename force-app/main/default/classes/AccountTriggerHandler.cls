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
            } else {
                // Add error if any of the shipping fields are empty
                acc.addError('Shipping fields should not be empty');
            }
        }
    }
}
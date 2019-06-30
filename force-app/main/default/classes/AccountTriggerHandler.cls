public class AccountTriggerHandler {
    
    public static void afterUpdateHandler(List<Account> triggerNew, Map<Id, Account> triggerOldMap) {
        // update all Account opportunities ONLY when Account industry changes
        List<Id> applicableIds = new List<Id>();
        
        for (Account account : triggerNew) {
            if (account.Industry != triggerOldMap.get(account.Id).Industry) {
                // found an industry change
                applicableIds.add(account.Id);
            }
        }

        // proceed if there are applicable accounts
        if (applicableIds.size() > 0) {
            List<Opportunity> opps = [SELECT Id, ForecastCategoryName FROM Opportunity WHERE AccountId IN :applicableIds];

            // update account's child opportunities
            if (opps.size() > 0) {
                List<Opportunity> oppUpdates = new List<Opportunity>();
                for (Opportunity opp : opps) {
                    opp.ForecastCategoryName = 'Pipeline';
                    oppUpdates.add(opp);
                }

                update oppUpdates;
            }
        }
    }

}

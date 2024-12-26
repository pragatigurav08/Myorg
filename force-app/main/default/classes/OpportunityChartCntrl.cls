/*public with sharing class AccountDataController {
    @AuraEnabled(cacheable=true)
    public static List<AccountCreationData> getAccountCreationData() {
        List<AggregateResult> results = [
            SELECT DAY_ONLY(CreatedDate) day, COUNT(Id) accountCount
            FROM Account
            WHERE CreatedDate = LAST_N_DAYS:7
            GROUP BY DAY_ONLY(CreatedDate)
            ORDER BY DAY_ONLY(CreatedDate)
        ];
    System.debug('Results'+results);
        // Convert AggregateResult to a custom wrapper class
        List<AccountCreationData> accountCreationDataList = new List<AccountCreationData>();
        for (AggregateResult ar : results) {
            Date createdDay = (Date) ar.get('day'); // Accessing the day correctly
            Integer accountCount = (Integer) ar.get('accountCount'); // Accessing the count correctly
            
            accountCreationDataList.add(
                new AccountCreationData(createdDay, accountCount)
            );
        }
        return accountCreationDataList;
    }

    // Wrapper class to hold the result data
    public class AccountCreationData {
        @AuraEnabled public Date day { get; set; }
        @AuraEnabled public Integer count { get; set; }

        public AccountCreationData(Date day, Integer count) {
            this.day = day;
            this.count = count;
        }
    }    
}*/

public class OpportunityChartCntrl {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(){
        return [SELECT Amount,Name,StageName FROM Opportunity WHERE CloseDate >= LAST_N_DAYS:30 AND StageName = 'Closed Won'];
    }
}
public with sharing class AccountDataController {
    
    @AuraEnabled(cacheable=true)
    public static List<AccountDataWrapper> getAccountCreationData() {
        List<AccountDataWrapper> accountData = new List<AccountDataWrapper>();
        
        // SOQL query to count accounts created in the last 7 days, grouped by day
        List<AggregateResult> results = [
            SELECT DAY_ONLY(CreatedDate) day, COUNT(Id)
            FROM Account
            WHERE CreatedDate = LAST_N_DAYS:7
            GROUP BY DAY_ONLY(CreatedDate)
            ORDER BY DAY_ONLY(CreatedDate)
        ];

        // Mapping for day of the week
        Map<Integer, String> dayOfWeekMap = new Map<Integer, String>{
            1 => 'Sunday',
            2 => 'Monday',
            3 => 'Tuesday',
            4 => 'Wednesday',
            5 => 'Thursday',
            6 => 'Friday',
            7 => 'Saturday'
        };

        // Loop through the results and add them to the list
        for (AggregateResult result : results) {
            Date day = (Date) result.get('day');
            Integer count = (Integer) result.get('count');

            // Get the day of the week as an integer and map it to the name
            Integer dayOfWeek = day.toStartOfWeek().day();
            String dayName = dayOfWeekMap.get(dayOfWeek);
            
            accountData.add(new AccountDataWrapper(dayName, count));
        }
        
        return accountData;
    }
    
    // Wrapper class to send data to LWC
    public class AccountDataWrapper {
        @AuraEnabled
        public String day { get; set; }
        @AuraEnabled
        public Integer count { get; set; }

        public AccountDataWrapper(String day, Integer count) {
            this.day = day;
            this.count = count;
        }
    }
}
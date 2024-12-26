public class orderTriggerHandler {
public static void deleteRelOpp(list<order> newList)
    {
        set<id>setId=new set<id>();
        List<Account> accountsToDelete = new List<Account>();
        List<Opportunity> oppDelete = new List<Opportunity>();
        set<id>setAccId =new set<id>();
        integer sizeOrder;
        integer sizeOrder2;

        for(order od:newList)
        {
            setId.add(od.OpportunityId);
        }
        for(opportunity opp:[select id,name,AccountId,(select id,accountId,OpportunityId from orders)
                             from opportunity where id in:setId])
        {
            opp.orders.size();
            sizeOrder=opp.orders.size();
            if(sizeOrder==0)
            {
                oppDelete.add(opp);
            } 
            setAccId.add(opp.accountId);
        }
        if (!oppDelete.isEmpty()) 
        {
        	delete oppDelete;
    	}
        List<Account> accountsWithOpportunities = [SELECT Id, (SELECT Id FROM Opportunities)
                                                   FROM Account WHERE Id IN :setAccId];
    		for (Account acc : accountsWithOpportunities) 
            {
                sizeOrder2=acc.Opportunities.size();
                if(sizeOrder2==0)
            	{
                	accountsToDelete.add(acc);
            	} 
    		}
        if (!accountsToDelete.isEmpty()) 
        {
        	delete accountsToDelete;
       	}
    }
   
 public static void undeleteRelatedRecords(List<Account> undeletedAccounts) 
    {
        Set<Id> accountIds = new Set<Id>();
        // Collect the Account IDs related to the undeleted Accounts
        for (Account account : undeletedAccounts) {
            accountIds.add(account.Id);
        }
        //system.debug('account Id'+accountIds);
        List<Opportunity> opportunitiesToUndelete = [SELECT Id FROM Opportunity WHERE AccountId IN :accountIds];
        //system.debug('opp Id'+opportunitiesToUndelete);
        // Undelete Opportunities
        if (!opportunitiesToUndelete.isEmpty()) {
           undelete opportunitiesToUndelete;
        }
        Set<Id> opportunityIds = new Set<Id>();
        for (Opportunity opp : opportunitiesToUndelete) {
            opportunityIds.add(opp.Id);
        }
        List<Order> ordersToUndelete = [SELECT Id FROM Order WHERE OpportunityId IN :opportunityIds];
        if (!ordersToUndelete.isEmpty()) {
            undelete ordersToUndelete;
        }
    }
}
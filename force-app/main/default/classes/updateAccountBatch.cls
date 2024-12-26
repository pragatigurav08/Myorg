global class updateAccountBatch implements Database.Batchable<sObject>
{
	global Database.QueryLocator start(Database.BatchableContext BC)
		{
			String query ='SELECT Id,Industry Name FROM Account where CreatedById=system.today()-30';
			return Database.getQueryLocator(query);
		}
	global void execute(Database.BatchableContext BC, List<Account> accList)
		{
			for(Account a:accList)
			{
				a.Industry='Banking';
			}
			update accList;
	}
	global void finish(Database.BatchableContext BC)
	{

	}
}
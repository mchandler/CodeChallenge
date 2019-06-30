@isTest
public class AccountTriggerHandlerTest {
    
    @isTest
    public static void testAfterUpdate() {
        Account account = new Account(Name = 'Test Account', Industry = 'Agriculture');
        insert account;

        Opportunity opportunity = new Opportunity(Name = 'Test Opp', StageName = 'Prospecting',
                    CloseDate = Date.Today().addDays(15));
        opportunity.AccountId = account.Id;
        insert opportunity;

        Test.startTest();
        account.Industry = 'Consulting';
        update account;
        Test.stopTest();

        Opportunity resultOpp = [SELECT Id, ForecastCategoryName FROM Opportunity WHERE AccountId = :account.Id];
        System.assertEquals('Pipeline', resultOpp.ForecastCategoryName);
    }

}

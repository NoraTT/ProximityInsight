@isTest
public class ContactTriggerHandler_Test_1 {
    //Testing ContactTriggerHandler.crtCase();
    @isTest 
    public static void createCase(){
        // Create Test data
        Account acc = new Account();
        acc.Name = 'Test Account';
 
        List<Contact> conList = new List<Contact>();

        Contact con = new Contact();
        con.FirstName = 'John';
        con.LastName = 'Wright';
        con.AccountId = acc.Id;
        con.Level__c = 'Primary';
        conList.add(con);
    
        
        Contact con1 = new Contact();
        con1.FirstName = 'John';
        con1.LastName = 'Wright';
        con1.AccountId = acc.Id;
        con1.Level__c = 'Secondary';
        conList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = 'John';
        con2.LastName = 'Wright';
        con2.AccountId = acc.Id;
        con2.Level__c = 'Tertiary';
        conList.add(con2);

        
        
        Contact con3 = new Contact();
        con3.FirstName = 'John';
        con3.LastName = 'Wright';
        con3.AccountId = acc.Id;
        con3.Level__c = 'NullTest';
        conList.add(con3);
   
        
        Test.startTest();
        insert acc;
        insert conList;
        Test.stopTest();
        
     
       List<Case> lstCase = [SELECT Id from Case];
       List<Task> lstTask = [SELECT Id from Task];
       
        system.assertEquals(4, lstCase.size());
        system.assertEquals(4, lstTask.size());
       
    }
}
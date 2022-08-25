public with sharing class ContactTriggerHandler {
    // Create a Case whenever a Contact has been created
    // If the Contact is related to an Account, the Case should also be related to the Account
    // If the Contact Level is Primary, the Case Priority should be High
    //If the Contact Level is Secondary, the Case Priority should be Medium
    //If the Contact Level is Tertiary, the Case Priority should be Low.

    public static void crtCase(List<Contact> lstNew) {
        List<Case> caseLst = new List<Case>();
        List<Task> taskLst = new List<Task>();
        Set<Id> caseIds = new Set<Id>();

        for(Contact con:lstNew){
            Case cs=new Case();
            if(con.AccountId!=null){
                cs.AccountId = con.AccountId;
            }
            if (con.Level__c!=null){
                if(con.Level__c =='Primary'){
                    cs.Priority = 'High';
                }else if (con.Level__c == 'Secondary'){
                    cs.Priority = 'Medium';
                }else if(con.Level__c == 'Tertiary'){
                    cs.Priority = 'Low';
                }

            }
            cs.ContactId = con.Id;
            cs.Status = 'Working';
            cs.Origin = 'New Contact';
            cs.OwnerId = con.OwnerId;
            caseLst.add(cs);
        }
        if(!caseLst.isEmpty()){
            insert caseLst;
        }
        
        for(Case c:caseLst){
            caseIds.add(c.Id);
        }
        // Crreate a Task for each Case created at first step.
        // If the Case is High Priority, task activity date should be in 1 week
        // If the Case is Medium Priority, task activity date should be in 2 weeks
        // If the Case is Low Priority, task activity date should be in 3 weeks

        List<Case> newCaseLst = [SELECT ID,ContactId,Status,Origin,OwnerId,CaseNumber,Priority,CreatedDate,Contact.OwnerId FROM Case WHERE Id =: caseIds];
        system.debug(newCaseLst);

        for (Case eachCase : newCaseLst){
            Task ts= new Task();
            ts.WhoId= eachCase.ContactId;
            ts.WhatId=eachCase.Id;
            ts.Status = 'Not Started';
            ts.Subject = 'Welcome Call for'+ eachCase.CaseNumber;
            ts.Priority = 'Normal';
            if(eachCase.Priority!=null && eachCase.Priority=='High'){
                ts.ActivityDate=eachCase.CreatedDate.Date().addDays(7);
                } else if(eachCase.Priority!=null && eachCase.Priority=='Medium'){
                ts.ActivityDate=eachCase.CreatedDate.Date().addDays(14); 
                }else if(eachCase.Priority!=null && eachCase.Priority=='Low'){
                ts.ActivityDate=eachCase.CreatedDate.Date().addDays(21);
                }
          
            ts.OwnerId= eachCase.Contact.OwnerId;
            taskLst.add(ts);

        }
        if(!taskLst.isEmpty()){
            insert taskLst;
        }

    }
 }
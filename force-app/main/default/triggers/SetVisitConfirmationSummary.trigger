trigger SetVisitConfirmationSummary on Visit_Confirmation__c (before insert, before update) {
    
    for(Visit_Confirmation__c visitConfirmation : Trigger.New) {
            Facility__c thisFacility = [SELECT Id, Street__c, City__c, Facility_Name__c, State_Province__c FROM Facility__c WHERE Id = :visitConfirmation.Facility__c];
            Room__c thisRoom = [SELECT Id, Name, Floor__c FROM Room__c WHERE Id = :visitConfirmation.Room__c];
                        
            visitConfirmation.Visit_Information_Summary__c =  '<span style=\"font-size:16px;\">' + '<b>'+ '<u>' +'Meeting Information' + '</u>' + '</b>' + '</span>' + '<br/>' + '<br/>';
            visitConfirmation.Visit_Information_Summary__c += '<b>'+ 'Date: ' + '</b>' + visitConfirmation.Event_Start_DateTime__c + '<br/>';
            visitConfirmation.Visit_Information_Summary__c += '<b>'+ 'Subject: ' + '</b>' + visitConfirmation.Event_Subject__c + '<br/>';
            visitConfirmation.Visit_Information_Summary__c += '<b>'+ 'Government POC: ' + '</b>' + VisitConfirmation.Government_POC_Name__c + '<br/>';
            visitConfirmation.Visit_Information_Summary__c += '<b>'+ 'Site: ' + '</b>' + thisFacility.Facility_Name__c + '<br/>';
            visitConfirmation.Visit_Information_Summary__c += '<b>'+ 'Room: ' + '</b>' + thisRoom.Name + '<br/>';
            visitConfirmation.Visit_Information_Summary__c += '<b>'+ 'Address: ' + '</b>' + '<br/>';
            visitConfirmation.Visit_Information_Summary__c += thisFacility.Street__c + '<br/>';       
            visitConfirmation.Visit_Information_Summary__c += thisFacility.City__c + ', ' + thisFacility.State_Province__c + '<br/>';       
    }  


}
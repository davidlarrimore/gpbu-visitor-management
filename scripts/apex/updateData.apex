//This Apex Class updates Demo data so that it works in target orgs

String departmentOfTheFuture = '';

//Update Accounts
Map<String, Id> recordTypeMap = new Map<String, Id>();
for(RecordType rt: [Select Id, Name from RecordType where sObjectType='Account']){
    recordTypeMap.put(rt.Name, rt.Id);
}
List<Account> accounts = [Select Id, Name, GPBUDVM_Demo_Record__c, GPBUDVM_External_Id__c, Hand_Crafted_for_Demo_Scenario__c, Record_Type_Name__c from Account];
for (Account thisRecord: accounts){
    thisRecord.Hand_Crafted_for_Demo_Scenario__c = true;
    thisRecord.GPBUDVM_Demo_Record__c = true;   
    if(thisRecord.Name == 'Department of the Future'){
        thisRecord.RecordTypeId = recordTypeMap.get('Default');  
        thisRecord.Record_Type_Name__c = 'Default';     
        departmentOfTheFuture = thisRecord.Id;     
    } else{
        thisRecord.RecordTypeId = recordTypeMap.get('Vendor');  
        thisRecord.Record_Type_Name__c = 'Vendor';  
    }
}
update accounts;


//Update Employee Contacts
recordTypeMap = new Map<String, Id>();
for(RecordType rt: [Select Id, Name from RecordType where sObjectType='Contact']){
    recordTypeMap.put(rt.Name, rt.Id);
}

List<Contact> contacts = [Select Id, GPBUDVM_Demo_Record__c, GPBUDVM_External_Id__c, Hand_Crafted_for_Demo_Scenario__c, Record_Type_Name__c from Contact WHERE AccountId = :departmentOfTheFuture];
for (Contact thisRecord: contacts){
    thisRecord.Hand_Crafted_for_Demo_Scenario__c = true;
    thisRecord.GPBUDVM_Demo_Record__c = true;    
    thisRecord.GPBUDVM_External_Id__c = thisRecord.Id;  
    thisRecord.RecordTypeId = recordTypeMap.get('Employee');  
    thisRecord.Record_Type_Name__c = 'Employee';   
}
update contacts;


//Update Vendor Contacts
recordTypeMap = new Map<String, Id>();
for(RecordType rt: [Select Id, Name from RecordType where sObjectType='Contact']){
    recordTypeMap.put(rt.Name, rt.Id);
}

contacts = [Select Id, GPBUDVM_Demo_Record__c, GPBUDVM_External_Id__c, Hand_Crafted_for_Demo_Scenario__c, Record_Type_Name__c from Contact WHERE AccountId != :departmentOfTheFuture];
for (Contact thisRecord: contacts){
    thisRecord.Hand_Crafted_for_Demo_Scenario__c = true;
    thisRecord.GPBUDVM_Demo_Record__c = true;    
    thisRecord.GPBUDVM_External_Id__c = thisRecord.Id;  
    thisRecord.RecordTypeId = recordTypeMap.get('Vendor');  
    thisRecord.Record_Type_Name__c = 'Vendor';   
}
update contacts;


//Update Facilities
recordTypeMap = new Map<String, Id>();
for(RecordType rt: [Select Id, Name from RecordType where sObjectType='Facility__c']){
    recordTypeMap.put(rt.Name, rt.Id);
}
List<Facility__c> facilities = [Select Id, GPBUDVM_Demo_Record__c, GPBUDVM_External_Id__c, Hand_Crafted_for_Demo_Scenario__c, Record_Type_Name__c from Facility__c];
for (Facility__c thisRecord: facilities){
    thisRecord.Hand_Crafted_for_Demo_Scenario__c = true;
    thisRecord.GPBUDVM_Demo_Record__c = true;    
    thisRecord.GPBUDVM_External_Id__c = thisRecord.Id;    
    thisRecord.RecordTypeId = recordTypeMap.get('Default');  
    thisRecord.Record_Type_Name__c = 'Default';  
}
update facilities;


//Update Visit Confirmations
recordTypeMap = new Map<String, Id>();
for(RecordType rt: [Select Id, Name from RecordType where sObjectType='Visit_Confirmation__c']){
    recordTypeMap.put(rt.Name, rt.Id);
}
List<Visit_Confirmation__c> visitConfirmations = [Select Id, GPBUDVM_Demo_Record__c, GPBUDVM_External_Id__c, Hand_Crafted_for_Demo_Scenario__c, Record_Type_Name__c from Visit_Confirmation__c];
for (Visit_Confirmation__c thisRecord: visitConfirmations){
    thisRecord.Hand_Crafted_for_Demo_Scenario__c = true;
    thisRecord.GPBUDVM_Demo_Record__c = true;    
    thisRecord.RecordTypeId = recordTypeMap.get('Site Visit');  
    thisRecord.Record_Type_Name__c = 'Site Visit';  
}
update visitConfirmations;



//Update Office Visits
recordTypeMap = new Map<String, Id>();
for(RecordType rt: [Select Id, Name from RecordType where sObjectType='Office_Visit__c']){
    recordTypeMap.put(rt.Name, rt.Id);
}
List<Office_Visit__c> officeVisits = [Select Id, GPBUDVM_Demo_Record__c, GPBUDVM_External_Id__c, Hand_Crafted_for_Demo_Scenario__c, Record_Type_Name__c from Office_Visit__c];
for (Office_Visit__c thisRecord: officeVisits){
    thisRecord.Hand_Crafted_for_Demo_Scenario__c = true;
    thisRecord.GPBUDVM_Demo_Record__c = true;    
    thisRecord.GPBUDVM_External_Id__c = thisRecord.Id;   
    thisRecord.RecordTypeId = recordTypeMap.get('Office Visit');  
    thisRecord.Record_Type_Name__c = 'Office Visit';  
}
update officeVisits;




//Update Rooms
for(RecordType rt: [Select Id, Name from RecordType where sObjectType='Room__c']){
    recordTypeMap.put(rt.Name, rt.Id);
}
List<Room__c> rooms = [Select Id, GPBUDVM_Demo_Record__c, GPBUDVM_External_Id__c, Hand_Crafted_for_Demo_Scenario__c, Record_Type_Name__c from Room__c];
for (Room__c thisRecord: rooms){
    thisRecord.Hand_Crafted_for_Demo_Scenario__c = true;
    thisRecord.GPBUDVM_Demo_Record__c = true;    
    thisRecord.GPBUDVM_External_Id__c = thisRecord.Id; 
    thisRecord.RecordTypeId = recordTypeMap.get('Room');  
    thisRecord.Record_Type_Name__c = 'Room';       
}
update rooms;

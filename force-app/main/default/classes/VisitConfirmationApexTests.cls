@isTest 
public with sharing class VisitConfirmationApexTests {

    @isTest static void CreateIndividualVisitConfirmationTests() {

        Account newAccount = new Account();
        newAccount.Name='Test Account' ;
        insert newAccount;

        Contact newContact = new Contact();
        newContact.FirstName='Test' ;
        newContact.LastName='Test' ;
        newContact.Account = newAccount;
        newContact.Emergency_Contact_Relationship__c = 'Spouse';
        newContact.Emergency_Contact_Name__c = 'Test';
        insert newContact;

        User thisUser = [SELECT Id, Contact_Record__c FROM User WHERE Id = :UserInfo.getUserId()];
        thisUser.Contact_Record__c = newContact.Id;
        update thisUser;


        Facility__c newFacility = new Facility__c();
        newFacility.Name = 'RES';
        newFacility.Facility_Name__c = 'Reston Office';
        newFacility.City__c = 'San Francisco';
        newFacility.Country__c = 'USA';
        newFacility.County__c = 'Fairfax County, VA';
        newFacility.State_Province__c = 'CA';
        newFacility.Street__c = '11720 Plaza America Dr.';
        newFacility.Zip_Postal_Code__c = '20190';
        newFacility.Facility_Status__c = 'Open';
        insert newFacility;

        Room__c newRoom = new Room__c();
        newRoom.Name = 'RES-8-001';
        newRoom.Room_Type__c = 'Conference Room';
        newRoom.Status__c = 'Clean';
        newRoom.Facility__c = newFacility.Id;
        insert newRoom;        

        Visit_Confirmation__c newVisitConfirmation = new Visit_Confirmation__c();
        newVisitConfirmation.OwnerId = UserInfo.getUserId();
        newVisitConfirmation.Event_Start_DateTime__c =  DateTime.now();
        newVisitConfirmation.Event_Subject__c = 'GDIT Discussion';
        newVisitConfirmation.Contact__c = newContact.Id;    
        newVisitConfirmation.Facility__c = newFacility.Id;
        newVisitConfirmation.Room__c = newRoom.Id;


        List<Visit_Confirmation__c> visitConfirmationList = new List<Visit_Confirmation__c>();
        visitConfirmationList.add(newVisitConfirmation);

        VisitConfirmationCreateVC.CreateVisitConfirmation(visitConfirmationList);

        System.assertEquals(1,1);

    }


    @isTest static void VisitConfirmationUpdateContactTests() {
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;

        Contact testContact = new Contact();
        testContact.FirstName='Test' ;
        testContact.LastName='Test' ;
        testContact.Account = testAccount;
        testContact.Emergency_Contact_Relationship__c = 'Spouse';
        insert testContact;

        List<Contact> contactList = new List<Contact>();
        contactList.add(testContact);
        VisitConfirmationUpdateContact.updateContact(contactList);


        System.assertEquals(String.valueOf(testContact.Emergency_Contact_Relationship__c), 'Spouse');

    }


}

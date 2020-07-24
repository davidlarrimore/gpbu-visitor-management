public class VisitConfirmationUpdateContact {
    
   @InvocableMethod
   public static void updateContact(List<Contact> newContacts) {
      Contact thisContact = newContacts[0];
      thisContact.Emergency_Contact_Relationship__c = String.valueOf(newContacts[0].Emergency_Contact_Relationship__c);
      update newContacts[0];
   }

}
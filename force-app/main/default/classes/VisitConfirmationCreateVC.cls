public class VisitConfirmationCreateVC {
    
   @InvocableMethod
   public static void CreateVisitConfirmation(List<Visit_Confirmation__c> newVisitConfirmation) {
       for (Visit_Confirmation__c individualVisitConfirmation : newVisitConfirmation){
           VisitConfirmationCreateVC.createIndividualVisitConfirmation(individualVisitConfirmation);
       }
   }    
    
    public static void createIndividualVisitConfirmation(Visit_Confirmation__c newVisitConfirmation){

       newVisitConfirmation.Event_Type__c = String.valueOf(newVisitConfirmation.Event_Type__c);

       //We default owner to Bob if no Owner is provided
       if(newVisitConfirmation.OwnerId == NULL){
           User bob = [SELECT Id from User WHERE FirstName = 'bob.young.demo@mailinator.com'];
           newVisitConfirmation.OwnerId = bob.Id;     
       }
       
       User VisitOwner = [SELECT Id, Email, Contact_Record__c FROM User WHERE Id = : newVisitConfirmation.OwnerId];
       Contact VisitOwnerContact = [SELECT Id, Office_Facility__c, Room__c FROM Contact WHERE Id = :VisitOwner.Contact_Record__c LIMIT 1];
            
       //We default facility to Owners if none is provided.
       if(newVisitConfirmation.Facility__c == NULL){
            newVisitConfirmation.Facility__c = VisitOwnerContact.Office_Facility__c; 
       }
       
       //We default room to Owners if none is provided.
       if(newVisitConfirmation.Room__c == NULL){
            newVisitConfirmation.Room__c = VisitOwnerContact.Room__c; 
       }       


       insert newVisitConfirmation;
   }    
}
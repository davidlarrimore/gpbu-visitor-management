
#No Longer Needed
#echo "*** Creating Managed Package ..."
#sfdx force:package:create --name "Demo Reset Tools" --packagetype Managed --path "force-app"
#sfdx force:package1:version:create --packageid 033xx00000007oi --name ”Spring 17” --description ”Spring 17 Release” --version 3.2 --managedreleased

echo "*** Updating Org Data ..."
sfdx force:apex:execute -f ./scripts/apex/updateData.apex 

echo "*** Pulling Data from Org ..."
#sfdx force:data:tree:import -f ./data/Facility__cs.json,./data/Accounts.json -u MyComponentsScratch
sfdx sfdmu:run --sourceusername MyComponentsScratch --targetusername csvfile --path ./data/

echo "*** Creating JSON Files ..."
csvtojson ./data/Account.csv > ./data/json/Account.json
csvtojson ./data/Contact.csv > ./data/json/Contact.json
csvtojson ./data/RecordType.csv > ./data/json/RecordType.json
csvtojson ./data/Room__c.csv > ./data/json/Room__c.json
csvtojson ./data/Facility_c.csv > ./data/json/Facility_c.json
csvtojson ./data/Visit_Confirmation__c.csv > ./data/json/Visit_Confirmation__c.json
csvtojson ./data/UserAndGroup.csv > ./data/json/UserAndGroup.json

#echo "*** Creating Unlocked Package ..."
#sfdx force:package:create --name "gPBU Component Package Manager Unlocked" --packagetype Unlocked --path "force-app"




echo "*** Creating Unlocked Package Version..."
sfdx force:package:version:create --package "gPBU Component Package Manager" -x --wait 10 --codecoverage 

#echo "*** Promoting Latest Managed Package ..."
#sfdx force:package:version:promote -p $(sfdx force:package:version:list -p 'Demo Reset Tools' -o CreatedDate --concise | tail -1 | awk '{print $3}')

echo "*** Promoting Latest Unlocked Package ..."
sfdx force:package:version:promote -p $(sfdx force:package:version:list -p 'gPBU Component Package Manager' -o CreatedDate --concise | tail -1 | awk '{print $3}')

#echo "*** Pushing Package to Package Manager Org ..."
#sfdx force:package:install --package "Demo Reset Tools@0.1.0-6" --targetusername PackageManager --installationkey test1234

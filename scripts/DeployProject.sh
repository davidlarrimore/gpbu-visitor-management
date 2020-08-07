
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
for fullfile in ./data/*.csv; do
    if [[ "$fullfile"  =~ "./data/MissingParentRecordsReport" ]];
        then
            echo "Skipping MissingParentRecordsReport.csv"
        else
            filename=$(basename -- "$fullfile")
            extension="${filename##*.}"
            filename="${filename%.*}"
            filenameWithoutC="${filename//__c}"
            echo "Exporting $filename to JSON"
            csvtojson ./data/Account.csv > ./force-app/main/default/staticresources/Data_$filenameWithoutC.json
            echo '<?xml version="1.0" encoding="UTF-8"?><StaticResource xmlns="http://soap.sforce.com/2006/04/metadata"><cacheControl>Public</cacheControl><contentType>application/json</contentType></StaticResource>' > ./force-app/main/default/staticresources/Data_$filenameWithoutC.resource-meta.xml
    fi
done

echo "*** Copying Demo Config Over ..."
cp ./demo-config.json ./force-app/main/default/staticresources/Demo_Config.json
echo '<?xml version="1.0" encoding="UTF-8"?><StaticResource xmlns="http://soap.sforce.com/2006/04/metadata"><cacheControl>Public</cacheControl><contentType>application/json</contentType></StaticResource>' > ./force-app/main/default/staticresources/Demo_Config.resource-meta.xml


#echo "*** Creating Unlocked Package ..."
#sfdx force:package:create --name "Visitor Management Demo Scenario" --packagetype Unlocked --path "force-app"

echo "*** Creating Unlocked Package Version..."
sfdx force:package:version:create --package "Visitor Management Demo Scenario" -x --wait 10 --codecoverage 

echo "*** Promoting Latest Unlocked Package ..."
sfdx force:package:version:promote -p $(sfdx force:package:version:list -p 'Visitor Management Demo Scenario' -o CreatedDate --concise | tail -1 | awk '{print $3}')

#echo "*** Pushing Package to Package Manager Org ..."
#sfdx force:package:install --package "Demo Reset Tools@0.1.0-6" --targetusername PackageManager --installationkey test1234

echo "*** Creating scratch org ..."
sfdx force:org:create -f config/project-scratch-def.json --setdefaultusername --setalias MyComponentsScratch -d 30

#echo "*** Opening scratch org ..."
#sfdx force:org:open

echo "*** Installing Dependent Packages ..."
#GPBU Package Manager
#sfdx force:package:install --package 0Ho3h000000k9sWCAQ -w 1000 -u MyComponentsScratch 

#Unnoficial SF
sfdx force:package:install --package 04t1t0000034vZjAAI -w 1000 -u MyComponentsScratch
sfdx force:package:install --package 04t1K000002J0KK -w 1000 -u MyComponentsScratch

#sfdx force:package:install --package 04t6C000000HrR5 -w 1000 -u MyComponentsScratch

echo "*** Pushing metadata to scratch org ..."
sfdx force:source:push

echo "*** Generating password for your user ..."
sfdx force:user:password:generate --targetusername MyComponentsScratch

echo "*** Pushing data"
#sfdx force:data:tree:import -f ./data/Facility__cs.json,./data/Accounts.json -u MyComponentsScratch
sfdx sfdmu:run --sourceusername csvfile --targetusername MyComponentsScratch --path ./data/
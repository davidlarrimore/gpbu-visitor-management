echo "*** Creating scratch org ..."
sfdx force:org:create -f config/project-scratch-def.json --setdefaultusername --setalias MyComponentsScratch -d 30

echo "*** Opening scratch org ..."
#sfdx force:org:open

echo "*** Installing Dependent Packages ..."
sfdx force:package:install --package 04t1t0000034vZjAAI -w 1000 -u MyComponentsScratch
sfdx force:package:install --package 04t1K000002J0KK -w 1000 -u MyComponentsScratch

echo "*** Pushing metadata to scratch org ..."
sfdx force:source:push

echo "*** Assigning permission set to your user ..."
sfdx force:user:permset:assign --permsetname gPBU_Package_Manager

echo "*** Generating password for your user ..."
sfdx force:user:password:generate --targetusername MyComponentsScratch

echo "*** Creating data"
sfdx force:data:tree:import -f ./data/export-demo-GPBU_Package__cs.json -u MyComponentsScratch

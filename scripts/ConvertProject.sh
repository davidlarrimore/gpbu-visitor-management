echo "*** Creating PKG Directory ..."
mkdir mdapipkg

echo "*** pulling change set ..."
sfdx force:mdapi:retrieve -s -r ./mdapipkg -p "visitor_management" -u CrisisManagementProd -w 10

echo "*** Cleaning up ..."
cd mdapipkg
unzip ./unpackaged.zip -d ./
rm unpackaged.zip
cd ../

echo "*** Converting to source ..."
sfdx force:mdapi:convert -r ./mdapipkg/

echo "*** Removing pkg directory ..."
rm -r ./mdapipkg


echo "*** Pushing metadata to scratch org ..."
sfdx force:source:deploy -p force-app -u MyComponentsScratch

echo "*** Getting Data ..."
sfdx sfdmu:run --sourceusername CrisisManagementProd --targetusername MyComponentsScratch --path ./data/
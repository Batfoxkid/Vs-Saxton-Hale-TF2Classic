# Go to build dir
cd build

# Create package dir
mkdir -p package/cfg
mkdir -p package/addons/sourcemod/plugins

# Copy all required stuffs to package
cp -r addons/sourcemod/plugins/cvsh.smx package/addons/sourcemod/plugins
cp -r cfg/randomizer_vsh.cfg package/cfg
cp -r ../models package
cp -r ../materials package
cp -r ../sound package
cp -r ../LICENSE.txt package
# Go to build scripting folder with cvsh.sp
cd build/addons/sourcemod/scripting

# Get plugin version
export PLUGIN_VERSION=$(sed -En '/#define PLUGIN_VERSION\W/p' cvsh.sp)
echo "PLUGIN_VERSION<<EOF" >> $GITHUB_ENV
echo $PLUGIN_VERSION | grep -o '[0-9]*\.[0-9]*\.[0-9]*' >> $GITHUB_ENV
echo 'EOF' >> $GITHUB_ENV

# Set revision to cvsh.sp
sed -i -e 's/#define PLUGIN_REVISION.*".*"/#define PLUGIN_REVISION "'$PLUGIN_REVISION'"/g' cvsh.sp
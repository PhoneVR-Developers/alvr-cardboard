# # Download ALVR source
# rm -r "ALVR"
# curl -sLS "https://github.com/alvr-org/ALVR/archive/refs/heads/master.zip" > download.zip
# # curl -sLS "https://github.com/ShootingKing-AM/ALVR/archive/refs/heads/phonevr.zip" > download.zip
# unzip download.zip
# rm download.zip
# mv ALVR-master ALVR
# # mv ALVR-phonevr ALVR

pushd ALVR
cargo xtask prepare-deps $@
popd

rm -r cardboard

# Download sdk source
rm -r "cardboard-master"
curl -sLS "https://github.com/googlevr/cardboard/archive/refs/heads/master.zip" > download.zip
unzip download.zip
rm download.zip

# Build sdk
pushd "cardboard-master"
./gradlew sdk:assembleRelease -Parm64-v8a
popd

# Prepare files
mkdir cardboard
mv "cardboard-master/sdk/build/outputs/aar/sdk-release.aar" cardboard/cardboard-sdk.aar
cp "cardboard-master/sdk/include/cardboard.h" cardboard/cardboard.h
rm -r "cardboard-master"

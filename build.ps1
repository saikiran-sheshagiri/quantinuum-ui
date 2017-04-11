 param (
    $dtrUsername,
    $dtrPassword,
    $dtrOrganization
 )

# Print environment variables
write-host "build number: $env:BUILD_BUILDNUMBER"
write-host "definitionName: $env:BUILD_DEFINITIONNAME"
write-host "dtrOrganization: $dtrOrganization"

# define specific build number tag, and set this build as latest in DTR
$buildTag = $dtrOrganization + "/" + $env:BUILD_DEFINITIONNAME + ":" + $env:BUILD_BUILDNUMBER
$latestTag = $dtrOrganization + "/" + $env:BUILD_DEFINITIONNAME + ":latest"

# build and tag it
docker build -t $buildTag -t $latestTag .

# login to dtr and push both build and latest
docker login --username $dtrUsername --password $dtrPassword dtr.neudemo.net 
docker push $buildTag
docker push $latestTag
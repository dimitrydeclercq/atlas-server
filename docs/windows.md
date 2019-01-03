# Configure Windows for Containers
- Add the 'Container' Feature from the Role and Features
- Reboot
- Install the Docker CLI from PS (as admin): `Install-Module -Name DockerMsftProvider -Repository PSGallery -Force`
- Reboot again
- Verify Docker for Windows by executing the following: `docker run microsoft/sample-dotnet`, you should see a success message

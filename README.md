# data-access-service-templates
This project lists the OpenShift Templates that create Data Access Services. In order to enable these templates in your own local OpenShift instance follow the directions below. If you already have a OpenShift instance running then skip to "Data Access Service" Template section.

## Install Docker

If you do not have docker installed already install docker on your machine. Find the instructions to installing docker on web specific to your operating system. For Fedora you can follow this 
https://developer.fedoraproject.org/tools/docker/docker-installation.html

## Installing the "OC" command 

Download the the file from below link and extract the "oc" file. 
https://drive.google.com/file/d/1PtpGLAYo0C5MzdUXdF8zoE5KkCR_jJ4_/view?usp=sharing (only Linux, for others OS please find alternative downloads)

Then copy the "oc" command to yor execution path, for example in RHEL based systems run below

```
$sudo mv oc /usr/bin/oc
```

then issue the following command and make sure the versions match

```
$oc version

oc v3.7.9
kubernetes v1.7.6+a08f5eeb62
features: Basic-Auth GSSAPI Kerberos SPNEGO
```
# Installing CDK 3.2
use the following link to download the CDK installer https://github.com/redhatdemocentral/rhcs-cloudforms-demo/archive/master.zip

Once the downloaded, extract into any directory and run 

```
./init.sh
```
This should take few minutes to download CDK, OpenShift when done, you will see a text like

```
====================================================
=                                                  =
= Install complete, get ready to rock your Cloud.  =
= Look for information at end of OCP install.      =
=                                                  =
=  The server is accessible via web console at:    =
=                                                  =
=	  https://192.168.42.152:8443              =
=                                                  =
=  Log in as user: openshift-dev                   =
=        password: devel                           =
=                                                  =
=  Admin log in as: admin                          =
=         password: admin                          =
=                                                  =
=  Now get your Red Hat Demo Central example       =
=  projects here:                                  =
=                                                  =
=     https://github.com/redhatdemocentral         =
=                                                  =
=  To stop and restart your OCP cluster with       =
=  installed containers, see Readme.md in the      =
=  NOTES section for details.                      =
=                                                  =
=  When finished, clean up your demo with:         =
=                                                  =
=     $ docker-machine rm -f openshift             =
=                                                  =
====================================================
```

Now execute following to login into the OpenShift instance.

```
$oc login 192.168.42.152:8443 

Authentication required for https://192.168.42.152:8443 (openshift)
Username: admin
Password: 
Login successful.
```

You are now ready to do the real reason you are here for, i.e. Data Access Template.

# Data Access Service Template

- Clone this repository or download the ZIP file of this repository and unzip the contents to any directory
- cd into "komodo" directory and execute
```
./load.sh

imagestream "komodo" created
template "data-access-service" created
```
this should load the "Data Access Service" template into your OpenShift instance. Now using your browser if you login into OpenShift "Web Console", on the main page you should see a icon called "Data Access Service" (NOTE: it could upto 15 minutes before this icon shows up in the Web Console). Once it is there you can click on it and "provision" it.

if for some reason you can not wait 15 minutes to icon to show up, then you can also execute following command

```
oc process data-access-service -p NAMESPACE=myproject -n openshift | oc create -f -
```
This has exact effect of "provision" by clicking on the icon on Web Console. Once the instace is provisioned, then go into your project (in this case "myproject"), you will see service being started, wait until all services are started then go to the "application/route" page to find the endpoint where you can access the "Data Access Service". 

When you go the link very first time, the process will take you through a login, then giving some authorization permissions to the program. If all goes correct you should see the Beetle main page (once integrated). You can also append "/vdb-builder" to same URL to see the Swagger API based page for Teiid Komodo Engine.

Now let's get this thing moving..

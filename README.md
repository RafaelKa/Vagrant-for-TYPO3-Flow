# Vagrant Box for TYPO3-Flow
NOTE: Work in progress and currently not really usable

## Setup

1. Download and install VirtualBox
2. Download and install Vagrant - the most recent version should be fine
3. Clone this repository and cd in this directory
4. Install Vagrant plugin to manage hostname for first project automatically. Run `vagrant plugin install vagrant-hostmanager`
5. Run `vagrant up`
6. Setup your IDE for using project as project on remote host.


### Setup your IDE

#### PhpStorm

##### Use default project

1. `File` -> `New Project from Existing Files...`
2. Choose `Web server is on remote host, files are accessible via FTP/SFTP/FTPS.`
3. Please specify project name and local path to download project files to.:
  3.1 Project name: `typo3-flow.dev`
  3.2 (Optional) Project local path: You can point in this vagrant box directory under `projects/typo3-flow.dev`.
  3.3 Click `next`
4. Choose `Add new remote server` and click `next`
5. Specify parameters for a new server.:
  5.1 Name: `Vagrant Box for TYPO3-Flow`
  5.2 Type: `SFTP`
  5.3 SFTP host: `typo3-flow.dev`
  5.4 Port: `2222`
  5.5 Root path: `/var/www/projects/`
  5.6 User name: `typo3`
  5.7 Auth type: `Password`
  5.8 Password: `typo3`
  5.9 Web server root URL: `http://typo3-flow.dev`
  5.10 Check `Don't check HTTP conection to server` and click `next`
6 Specify root folder on the remote server:
  6.1 Choose `typo3-flow.dev` folder and click on `Project Root` button on the top of current window
  6.2 Click `next` and then `Finish`
  6.3 PhpStorm will download all TYPO3 Flow files in your project root. This can take a while(<3 minutes)
7. Automatic upload on save:
  7.1 Choose `Tools` -> `Deployment` -> `Automatic Upload`

##### Create new Project

1. `File` -> `New Project from Existing Files...`
2. Choose `Web server is on remote host, files are accessible via FTP/SFTP/FTPS.`
3. Specify project name (and local path if needed) and click `next`
4. Choose `Use existing server` or go to steps 4 and 5 from [Use default project](##### Use default project)
  4.1 Choose `Vagrant Box for TYPO3-Flow` which was created in steps 4 and 5 from [Use default project](##### Use default project)
  4.2 Click `next`
5. Specify root folder on the remote server:
  5.1 Right click on `Vagrant Box for TYPO3-Flow (typo3-flow.dev/var/www/projects/)` -> `Create Folder...`
  5.2 Enter folder name from step 5.9: `{lover-case-projectname[.dev]}` and click `OK`
  5.3 Choose created folder and click on `Project Root` button on the top of current window
  5.4 Click `next` and `Finish`
  5.5 Automatic upload on save:
    5.5.1 Choose `Tools` -> `Deployment` -> `Automatic Upload`
6. Click `Tools` -> `Start SSH session` or run `ssh localhost -p 2222 -l typo3` and enter password `typo3`(skip 6.1 if using ssh in console)
  6.1 Choose `Vagrant Box for TYPO3-Flow`
  6.2 Run `composer create-project --dev --keep-vcs typo3/flow-base-distribution {lover-case-projectname[.dev]}` and other commands
7. Download project files in projects root folder:
  7.1 Click `Tools` -> `Deployment` -> `Download from default server` or right click on the root directory in Project window and `Deployment` -> `Download from ......`
  7.2 PhpStorm will download all TYPO3 Flow files in your project root. This can take a while(<3 minutes)

## Notices

### Windows

#### VBoxAdpNet.sys

On `vagrant up` you will be asked for `VBoxAdpNet.sys` file. You must point in VirtualBox window on `C:\Program Files\Oracle\VirtualBox\drivers\network\netadp\VBoxNetAdp.sys`



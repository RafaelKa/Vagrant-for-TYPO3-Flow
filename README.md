# Vagrant Box for TYPO3-Flow
NOTE: Work in progress and currently not really usable

## Setup

1. Download and install VirtualBox
2. Download and install Vagrant
3. Clone this repository and cd in its directory
4. Install Vagrant plugin to manage hostname for first project automatically.
  * Run `vagrant plugin install vagrant-hostmanager`
5. Run `vagrant up` (Windows user notice: [missing VBoxAdpNet.sys](#vboxadpnetsys) )
6. Setup your IDE for using project as project on remote host.


### Setup your IDE

#### PhpStorm

##### Use default project

1. `File` -> `New Project from Existing Files...`
2. Choose `Web server is on remote host, files are accessible via FTP/SFTP/FTPS.`
3. Please specify project name and local path to download project files to.:
  * Project name: `typo3-flow.dev`
  * (Optional) Project local path: You can point in this vagrant box directory under `projects/typo3-flow.dev`.
  * Click `next`
4. Choose `Add new remote server` and click `next`
5. Specify parameters for a new server.:
  * Name: `Vagrant Box for TYPO3-Flow`
  * Type: `SFTP`
  * SFTP host: `typo3-flow.dev`
  * Port: `2222`
  * Root path: `/var/www/projects/`
  * User name: `typo3`
  * Auth type: `Password`
  * Password: `typo3`
  * Web server root URL: `http://typo3-flow.dev`
  * Check `Don't check HTTP conection to server` and click `next`
6 Specify root folder on the remote server:
  * Choose `typo3-flow.dev` folder and click on `Project Root` button on the top of current window
  * Click `next` and then `Finish`
  * PhpStorm will download all TYPO3 Flow files in your project root. This can take a while(<3 minutes)
7. Automatic upload on save:
  * Choose `Tools` -> `Deployment` -> `Automatic Upload`

##### Create new Project

1. `File` -> `New Project from Existing Files...`
2. Choose `Web server is on remote host, files are accessible via FTP/SFTP/FTPS.`
3. Specify project name (and local path if needed) and click `next`
4. Choose `Use existing server` or go to steps 4 and 5 from [Use default project](#use-default-project)
  * Choose `Vagrant Box for TYPO3-Flow` which was created in steps 4 and 5 from [Use default project](#use-default-project)
  * Click `next`
5. Specify root folder on the remote server:
  * Right click on `Vagrant Box for TYPO3-Flow (typo3-flow.dev/var/www/projects/)` -> `Create Folder...`
  * Enter folder name: `{lover-case-projectname[.dev]}`
  * Click `OK`
  * Choose created folder and click on `Project Root` button on the top of current window
  * Click `next` and `Finish`
  * Automatic upload on save:
    * Choose `Tools` -> `Deployment` -> `Automatic Upload`
6. Install TYPO3 Flow with composer inside a Vagrant box:
  * Click `Tools` -> `Start SSH session`
  * Choose `Vagrant Box for TYPO3-Flow`
  * Run `composer create-project --dev --keep-vcs typo3/flow-base-distribution {lover-case-projectname[.dev]}`
  * Run other commands f.x. `composer require ...`
7. Download project files in projects root folder:
  * Click `Tools` -> `Deployment` -> `Download from default server`
    or right click on the root directory in Project window from PhpStorm and choose `Deployment` -> `Download from ......`
  * PhpStorm will download all TYPO3 Flow files in your project root. This can take a while(<3 minutes)

## Notices Windows

### VBoxAdpNet.sys

On `vagrant up` you will be asked for `VBoxAdpNet.sys` file. You must point in VirtualBox window on `C:\Program Files\Oracle\VirtualBox\drivers\network\netadp\VBoxNetAdp.sys`



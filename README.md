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
  * Port: `22`
  * Root path: `/var/www/projects/`
  * User name: `typo3`
  * Auth type: `Password`
  * Password: `typo3`
  * Web server root URL: `http://typo3-flow.dev`
  * Check `Don't check HTTP conection to server` and click `next`
6. Specify root folder on the remote server:
  * Choose `typo3-flow.dev` folder and click on `Project Root` button on the top of current window
  * Click `next` and then `Finish`
  * PhpStorm will download all TYPO3 Flow files in your project root. This can take a while(<3 minutes)
7. Automatic upload on save:
  * Choose `Tools` -> `Deployment` -> `Automatic Upload`
8. Go with your web browser to [typo3-flow.dev](http://typo3-flow.dev) (if it does not work on Windows check [hosts on Windows](#hostsfile))
  * Follow the on-screen or [Quick Start Guide for TYPO3 Flow](http://docs.typo3.org/flow/TYPO3FlowDocumentation/Quickstart/Index.html) instructions.

##### Create new Project

1. `File` -> `New Project from Existing Files...`
2. Choose `Web server is on remote host, files are accessible via FTP/SFTP/FTPS.`
3. Specify project name (and local path if needed) and click `next`
4. Choose `Use existing server` or go to steps 4 and 5 from [Use default project](#use-default-project)
  * Choose `Vagrant Box for TYPO3-Flow` which was created in steps 4 and 5 from [Use default project](#use-default-project)
  * Click `next`
5. Specify root folder on the remote server:
  * Right click on `Vagrant Box for TYPO3-Flow (typo3-flow.dev/var/www/projects/)` -> `Create Folder...`
  * Enter folder name: `{lower-case-projectname[.dev]}`
  * Click `OK`
  * Choose created folder and click on `Project Root` button on the top of current window
  * Click `next` and `Finish`
  * Automatic upload on save:
    * Choose `Tools` -> `Deployment` -> `Automatic Upload`
6. Install TYPO3 Flow with composer inside a Vagrant box:
  * Click `Tools` -> `Start SSH session`
  * Choose `Vagrant Box for TYPO3-Flow`
  * Run `composer create-project --dev --keep-vcs typo3/flow-base-distribution {lower-case-projectname[.dev]}`
  * Run other commands f.x. `composer require ...`
7. Download project files in projects root folder:
  * Click `Tools` -> `Deployment` -> `Download from default server`
    or right click on the root directory in Project window from PhpStorm and choose `Deployment` -> `Download from ......`
  * PhpStorm will download all TYPO3 Flow files in your project root. This can take a while(<3 minutes)
8. Add `192.168.144.100 {lower-case-projectname[.dev]}` line in /etc/hosts (Windows: %SystemRoot%\system32\drivers\etc\hosts) file.

## Environment configuration

You can use settings.yaml to enable and disable installation and auto start from services like MySQL, Apache, NginX, etc.

## Notices Windows

### VBoxAdpNet.sys

On `vagrant up` you will be asked for `VBoxAdpNet.sys` file. You must point in VirtualBox window on `C:\Program Files\Oracle\VirtualBox\drivers\network\netadp\VBoxNetAdp.sys`

### hosts file

Vagrants plugin `vagrant-hostmanager` seems to get troubles with [hosts on Windows host machine](https://github.com/smdahlen/vagrant-hostmanager#windows-support).
Therefore most likely on Windows machines you must add an entry manually in `hosts` file.

* Run Editor as administrator and navigate to `%SystemRoot%\system32\drivers\etc` (always `C:\Windows\System32\drivers\etc` ) folder
* Choose `show all files`
* Choose `hosts` file and click `open`.
* Add `192.168.144.100 {lower-case-projectname[.dev]}` line at the end of file.
* Click save and close Editor
* Now you can request `{lower-case-projectname[.dev]}` ind your web browser

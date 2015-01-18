# Vagrant Box for TYPO3-Flow
NOTE: Work in progress and currently not really usable

## Setup

1. Download and install VirtualBox
2. Download and install Vagrant - the most recent version should be fine
3. Clone this repository and cd in this directory
4. Run `vagrant up`
5. Setup your IDE for using project as project on remote host.


### Setup your IDE for using project as project on remote host.

#### PhpStorm

1. File -> `New Project from Existing Files...`
2. Choose `Web server is on remote host, files are accessible via FTP/SFTP/FTPS.`
3. Specify project name (and local path if needed) and click `next`
4. Choose `Add new remote server` and click `next`
5. Specify parameters for a new server.:
5.1 Name: `Vagrant Box for TYPO3-Flow`
5.2 Type: `SFTP`
5.3 SFTP host: `localhost`
5.4 Port: `2222`
5.5 Root path: `/var/www/projects/`
5.6 User name: `typo3`
5.7 Auth type: `Password`
5.8 Password: `typo3`
5.9 Web server root URL: `http://{lover-case-projectname[.dev]}` <- is needed in step 6.2
5.10 Check `Don't check HTTP conection to server` and click `next`
6 Specify root folder on the remote server:
6.1 Right click on `Vagrant Box for TYPO3-Flow (localhost/var/www/projects/)` -> `Create Folder...`
6.2 Enter folder name from step 5.9: `{lover-case-projectname[.dev]}` and click `OK`
6.3 Choose created folder and click on `Project Root` button on the top of current window
6.4 Click `next` and `Finish`
7. Tools -> `Start SSH session`
7.1 Choose `Vagrant Box for TYPO3-Flow`
7.2 Run `composer create-project --dev --keep-vcs typo3/flow-base-distribution {lover-case-projectname[.dev]}`



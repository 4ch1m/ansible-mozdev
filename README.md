# ansible-mozdev
> A collection of Ansible playbooks to aid development of Mozilla Mail Extensions (/ Web Extensions).

```diff
- WORK IN PROGRESS -
```

  * [Disclaimer](#disclaimer)
  * [Installation](#installation)
  * [Update](#update)
  * [Usage](#usage)
  * [Playbooks](#playbooks)
  * [Roles](#roles)
  * [License](#license)

## Disclaimer
I created these playbooks primarily to simplify my work on Thunderbird [MailExtensions](https://developer.thunderbird.net/add-ons/mailextensions).

Since [web-ext](https://github.com/mozilla/web-ext) currently only offers support for WebExtensions, I had to come up with a bunch of custom shell-scripts to make IDE-integration with simple run-configurations for MailExtensions possible.

After some time I realized that the use of Ansible could improve things even more.
I'm aware that Ansible probably wasn't designed for such a use-case; but it just works so damn well. :sunglasses:

It's also possible to utilize this for Firefox WebExtension development by overriding the product specific default-variables in the `mozdev`-role: [mozdev/defaults/main.yml](mozdev/defaults/main.yml)

**Please also take note that these playbooks are intended for use on Linux/Unix systems.**

## Installation
You can either clone the repo directly into your project folder, or use it as a submodule of a git-managed project.

### Clone
```
git clone https://github.com/4ch1m/ansible-mozdev.git
```

### Submodule
```
git submodule add https://github.com/4ch1m/ansible-mozdev.git
```

... to get all playbooks within an `ansible-mozdev`-folder.

## Update

### Cloned
In the `ansible-mozdev`-folder:
```
git pull
``` 

### Submodule
In your project-root:
```
git submodule update --remote --merge
``` 

## Usage

The only real requirement for the playbooks to work is that you'll have a `src`-folder present, containing your add-on resources.

A `bin`-folder will be created/used to download and store all Thunderbird/Firefox executables, as well as the according profile-directories.

The `src`-folder should be the root of your MailExtension/WebExtension. 

So this is what it should look like:

```
.
├── [bin]
├── [ansible-mozdev]
├── [src]
├── [.git]
├── .gitmodules
├── ansible-mozdev.yml
└── package.json
```

(A manually created and optional file called `ansible-mozdev.yml`-file (right beside the `ansible-mozdev`-folder) can be used to override the [default variables](mozdev/default/main.yml) (basically **any** variables). But don't forget to pass it in when invoking Ansible.)

All this will come in handy if you're referencing the playbooks from within a `package.json`-file - which will usually integrate nicely with an IDE. :smirk:

e.g.

```
...
  "ansible": "ansible-playbook --extra-vars @ansible-mozdev.yml",
  "scripts": {
    "prestart": "$npm_package_ansible ansible-mozdev/install.yml",
    "start": "$npm_package_ansible ansible-mozdev/run.yml",
    "clean": "$npm_package_ansible ansible-mozdev/remove.yml",
    "sort-messages": "$npm_package_ansible ansible-mozdev/sort_messages.yml",
    "find-unused-messages": "$npm_package_ansible ansible-mozdev/find_unused_messages.yml",
    "lint": "web-ext --source-dir src lint",
...
```

(See a full example here: [mozext/signatureswitch-me](https://github.com/4ch1m/mozext/tree/master/signatureswitch-me))

### Playbooks
Here's a short summary for each script (in alphabetical order):

* [find_unused_messages.yml](find_unused_messages.yml)

  finds unused messages defined in message.json-files

* [install.yml](install.yml)

  installs your extension in the profile

* [package.yml](package.yml)

  creates an XPI file from your extension

* [remove.yml](remove.yml)

  deletes the folder of your installed extension from the profile

* [run.yml](run.yml)

  runs Thunderbird/Firefox with the appropriate profile

* [sort_messages.yml](sort_messages.yml)

  sorts all messages in message.json-files based on key-name

### Roles
* [mozdev](mozdev)

  this role automatically downloads the desired Thunderbird/Firefox binaries; creates the profile-folder; presets development-settings (prefs.js)

## License
Please read the [license](license) file.

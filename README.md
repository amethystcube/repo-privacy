# Repo Privacy

When working on repositories from different devices, the name and email used for Git commits can sometimes be different than intended, resulting in an unintentional information leak. These scripts can help you check commit logs for sensitive data.

## Table of Contents

- [Repo Privacy](#repo-privacy)
  - [Table of Contents](#table-of-contents)
  - [Some Notes](#some-notes)
  - [Usage](#usage)
    - [Fetch Repositories](#fetch-repositories)
    - [Audit Repositories](#audit-repositories)
    - [Generate a `.mailmap`](#generate-a-mailmap)
    - [Filter Repositories](#filter-repositories)
    - [Verify Your Changes](#verify-your-changes)
    - [Reconnect Repositories to GitHub](#reconnect-repositories-to-github)
  - [Issues and Pull Requests](#issues-and-pull-requests)
  - [License](#license)

## Some Notes

1. These scripts are intended for use with repositories hosted on GitHub and have not been tested elsewhere. To use them in other environments, they must be modified; pull requests welcome!
2. There's probably a more efficient version of this process, but I wanted to proceed slowly because messing with existing commits is risky business; again, pull requests are welcome!
3. If you receive errors you don't understand at *any* point in the process, start over! Maybe something just went wrong; if the error keeps happening, then you've found a usage I didn't account for. Reach out and tell me about it!

## Usage

Some of the scripts in this repository use [newren's `git-filter-repo`](https://github.com/newren/git-filter-repo) Python package, which you can install with following command:
```
pip3 install git-filter-repo
```

This of course means you need Python for these scripts to work as well! Follow along below to learn how to fix up your commit logs.

### Fetch Repositories

To begin, run `download.sh` and pass your GitHub account as an argument:
```
sh download.sh amethystcube
```

The repositories will be cloned into a `repos` folder that will be created if it does not already exist.

### Audit Repositories

Once the repositories you'd like to check are downloaded, you can run `audit.sh` and pass what you'd like to search for as an argument: 

```
sh audit.sh "Personal Info"
```

The commit logs of the cloned repositories will be scanned and the results will be printed. An example of the script's output is below:

```
Safe Repositories
==============================
safe-repo-one
safe-repo-two

Exposed Repositories
==============================
exposed-repo-one: 2 result(s)
exposed-repo-two: 3 result(s)
```

### Generate a `.mailmap`

Once you know which repositories are exposed, you can use `log.sh` search their commit logs to find out which email was used for the exposing commit:

```
sh log.sh exposed-repo-one "Personal Info"
```

Now that you've got the email used for the exposed commit, you can generate a mailmap that `git-filter-repo` will use to alter the commit log. Just run `mailmap.sh` and follow the prompts by entering:
1. the old commit email
2. the new commit email (these can be the same!)
3. the name you want to associate with the commits that will be changed

### Filter Repositories

Pass a repository name to `filter.sh` and the commit history will be altered using the `.mailmap` you generated above:

```
sh filter.sh exposed-repo-one
```

### Verify Your Changes

Make sure everything worked as intended by running the audit again and seeing if the repository has moved from the *Exposed* list to the *Safe* list:
```
sh audit.sh "Personal Info"
```


### Reconnect Repositories to GitHub

Altering the commit history changes the commit hash because the hash is meant to be unique and is created using information associated with the commit—like the information you just changed. This means the repository gets disconnected from GitHub; to reconnect it, run `reconnect.sh` and follow the prompt to choose a repository and the GitHub account it should be connected to.

*NOTE: This script uses the `--force` flag to ignore GitHub's warning that the commit hashes of the local and remote versions of the repository are different. __MAKE SURE YOU ENTER THE CORRECT REPOSITORY NAME.__*

## Issues and Pull Requests

I haven't used these featured too much, but if anything comes up or if you can improve these files in any way, please reach out!

## License

This repository uses the [Creative Commons Zero v1.0 Universal](./LICENSE) license.
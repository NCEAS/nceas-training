# Contributing to nceas-training

:tada: First off, thanks for contributing! :tada:

[1. Definitions](#1-definitions)

[2. Types of contributions](#2-types-of-contributions)

[3. Getting started](#3-getting-started)

[4. Fixing a bug or contributing to a lesson or files](#4-fixing-a-bug-or-contributing-to-a-lesson-or-files)

[5. Adding a training event](#5-adding-a-training-event)

[6. Syncing your forked repository with the upstream repository](#6-syncing-your-forked-repository-with-the-upstream-repository)

[7. Materials Development Workflow](#7-materials-development-workflow)

[8. Building the book](#8-building-the-book)

## 1. Definitions

- **forked repository**: this refers to contributors' forked copy of the `NCEAS/nceas-training` repository which is specified with the path `{yourUsername}/nceas-training`
- **upstream repository**: this refers to the original repository that contributors fork from which is `NCEAS/nceas-training` 
- **origin or remote repository**: this refers to your forked repository on GitHub

## 2. Types of contributions

We welcome all types of contributions, including bug fixes, new lessons, lesson improvements, and new training events.

- Report a bug or issue to our [issue tracker](https://github.com/NCEAS/nceas-training/issues)
- Fix a bug or contribute a lesson with a Pull Request
- Add a training event with a Pull Request

## 3. Getting started
For this repository, contributors use a [forking workflow](https://learning.nceas.ucsb.edu/2023-04-coreR/session_17.html#forking-workflow). This means contributors make edits to files from the `NCEAS/nceas-training` repository in their forked repository `{yourUsername}/nceas-training`, and to merge these edits to `NCEAS/nceas-training` (the original repository) they open a pull request (PR). 

We use pull requests to review and discuss changes before merging contributor's additions or new features into `NCEAS/nceas-training`. See documentation on pull requests [here](https://help.github.com/articles/about-pull-requests/) and [here](https://www.atlassian.com/git/tutorials/making-a-pull-request).

To contribute to this repository, use these steps to get started:

1. `Fork` the `nceas-training` repository by clicking the "Fork" button at the top right of the repository 

    a. In the "Create a new fork" screen make sure the Owner is set to your GitHub user and don't change the repository name
    
    b. If you need access to more branches than `main` in the `NCEAS/nceas-training` repository, uncheck "Copy the `main` branch only"
    
2. Clone `{yourUsername}/nceas-training` (this is your forked copy) into your workspace onto your computer
3. Sync your forked repository with the upstream repository. It's important to note that no matter how you are contributing, you should check that the branch you're working on in your forked repository is in the same state as the same branch in the upstream repository. [See section 6 for more detailed instructions on how to sync your forked respository with the upstream repository](#6-syncing-your-forked-repository-with-the-upstream-repository)

## 4. Fixing a bug or contributing to a lesson or files

1. Add an [issue](https://github.com/NCEAS/nceas-training/issues) describing your planned changes, or add a comment to an existing issue
2. **Make sure you're working in the right branch and sync changes / pull from the upstream respository before you start making changes.** [See section 6](#6-syncing-your-forked-repository-with-the-upstream-repository) 

    a. Once you've identified which branch you want to work in check that the branch in your forked repository is in "Sync" with `NCEAS/nceas-training` (aka the upstream repository) *before* you start making changes. This will ensure that your forked repository (`{yourUsername}/nceas-training`) and the upstream repository (`NCEAS/nceas-training`) are in the same state and will prevent merge conflicts from occurring when you PR.

4. Make your changes and `push` changes to your forked repository 
5. Open a Pull Request (PR). Make sure that the base repository is `NCEAS/nceas-training` and the head repository is `{yourUsername}/nceas-training`. It's also important to double check that the base branch of `NCEAS/nceas-training` matches up with the compare branch in `{yourUsername}/nceas-training`. Aka make sure that you're PRing (and ultimately, merging) the right branches
6. Assign someone from the NCEAS GitHub Organization to review your changes
7. Your reviewer may request changes before merging in the changes and closing the PR. This discussion can take place in the "Conversation" tab of the PR webpage
8. Once changes have been confirmed, the reviewer will merge in the changes and close the PR, and you're done!

## 5. Adding a training event

Each branch in the `NCEAS/nceas-training` repository represents a specific training event. This allows for curriculum and additional training event materials to be selected, remixed, and adapted to fit the specific needs of each event.

* **`main`**: The `main` branch represents the most recent version of materials used in the most recent training event. 
* **YYYY-MM-org**: Event branches are named with the year and month in which the event takes place, and the organization or name of the event. For example, the branch name for the October 2020 Arctic Data Center training event would be 2020-10-arctic. This branch also contains all the training materials used in that training event.

**To add a training event, follow these steps:**

1. **Make sure your forked repository is up-to-date and sync your forked repository with the main branch from the upstream repository.** [See section 6](#6-syncing-your-forked-repository-with-the-upstream-repository)
2. Create a branch in the upstream respository (it's probably easiest to do this on GitHub)
3. In your local workspace, create a new branch. You can create a new branch in the Terminal or in RStudio, but in either case make sure the remote setup is to origin and NOT the upstream.

    a. Create a branch in the Terminal by running `git checkout -b {newBranchName}` and then setup the remote and push the new branch to the remote by running `git push --set-upstream origin {newBranchName}`
    
    b. Create a branch in RStudio by clicking the new branch button (see in red box) and create new branch and keep remote set to origin
    <img width="418" alt="create-branch-rstudio" src="https://github.com/hdolinh/nceas-training/assets/88209419/7b2f36fc-9087-4fac-abab-60bc31735717">

5. Now the new branch exists in both the upstream repository and your forked repository. This means you can now sync or pull changes from the upstream repository. That's it!

**If you are trying to add an existing training event branch that a contributor has created to your forked repository, follow these steps:**

1. **Make sure your forked repository is up-to-date and sync your forked repository with the main branch from the upstream repository.**
2. In the Terminal, run `git fetch upstream` to see the new branch name
3. Create a branch with the same name of the new branch name you saw from running `git fetch`. Review steps for creating a branch above in the steps for "To add a training event"
4. In the Terminal, run `git pull upstream {newBranchName}`.
5. Check on GitHub that you have successfully pushed the new branch and any new changes to your forked repository

## 6. Syncing your forked repository with the upstream repository 

These instructions provide two methods for syncing your forked repository (`{yourUsername}/nceas-training`) with upstream repository (`NCEAS/nceas-training`).
    
**1. One way to sync your forked repository is through GitHub, where you click "Sync fork" on the main page of your git repository on GitHub.** On GitHub, you'll either see a message informing you that either your forked repository is up to date with the upstream repository or it is not (when it's not it'll either specify if the branch you're working in is either "ahead" or "behind" the upstream repository). You'll need to `pull` these changes when you first open your workspace, so that your local repository is in the same state as your origin repository. 
    <img width="996" alt="sync-fork-uptodate" src="https://github.com/hdolinh/nceas-training/assets/88209419/dff48db5-3c03-4e54-a44e-ae40b8f5aa26">
    <img width="997" alt="sync-fork-not-uptodate" src="https://github.com/hdolinh/nceas-training/assets/88209419/92de9868-fd2b-4694-8c56-ed814a5ac05c">

**2. Another way to sync your forked repository is through the Terminal.** First you need to verify your remote (or origin) and upstream are setup. Do this by typing `git remote -v` in the Terminal. In this screenshot, user `hdolinh` is working in the `2023-04-coreR` branch and only has the remote repository setup.

![check-remote-setup](https://github.com/hdolinh/nceas-training/assets/88209419/56dd9580-8da6-4d2d-a2aa-c73ebec38255)

If you code looks similar, then it means you need to setup the upstream repository. Do this by typing `git remote add upstream {GitHub link to upstream repository}` in the Terminal. In this screenshot, user `hdolinh` has setup the upstream repository to `NCEAS/nceas-training`

![add-upstream](https://github.com/hdolinh/nceas-training/assets/88209419/efb83a89-4770-4f27-9107-ca5ab88e6422)
    
Run `git remote -v` again to confirm that you successfully setup the upstream repository
![check-add-upstream](https://github.com/hdolinh/nceas-training/assets/88209419/c083f01b-7260-4e1f-b36a-2f1c9b8ee304)

Now that your upstream is setup, to sync your forked repository with the upstream repository run `git pull upstream {branchName}` to get the most recent changes from `NCEAS/nceas-training` in your workspace. To have this reflected on your remote repository on GitHub, you will need to push these changes by running `git push`. You do not need to `push` to the upstream repository, you will use a PR to merge changes from your forked repo to `NCEAS/nceas-training`.

## 7. Materials Development Workflow

### Material Development Guidelines

Lesson content is stored in `materials/sections/`. Bookdown sections are generated in the top level of the `materials/` directory, which knit together the child RMarkdown section documents.

In expanding existing materials you are welcome to:

- add a new section as an Rmd to the `materials/sections` directory
- add or edit material to existing Rmd sections

In developing content for a new event you will likely need to:

- create top level Rmd files in `materials/` that select the sections you are teaching
- edit `materials/index.Rmd` to customize introductory material to your event
- edit `materials/_bookdown.yml` to include the chapters in `materials/` that you are teaching

We ask that you not:

- delete content wholesale. Content that you are not teaching can remain in the repository without needing to be deleted. Instead, select content via your chapters in `materials/` and the content of `materials/_bookdown.yml`
- commit very large data or presentation files

## 8. Building the book

While there are many workflows for building the Rmd files into the rendered bookdown,
probably the simplest to use during authoring is to run `bookdown::serve_book('materials')`,
assuming your working directory is the root of the nceas-training repository. This
will load the rendered view into the RStudio `Viewer` pane, and any time you make a change
to the Rmd files in the book, the book will be rebuild and loaded into the pane. For a larger
view, you can open the content from the VIewer pane into a separate web browser. When you
are done, or if you want to stop the book from being served, run `servr::daemon_stop()`.


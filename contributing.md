# Contributing to nceas-training

:tada: First off, thanks for contributing! :tada:

- [Types of contributions](#types-of-contributions)
- [Getting started](#getting-started)
- [Pull Requests](#pull-requests)
- [Development Workflow](#development-workflow)

## Types of contributions

We welcome all types of contributions, including bug fixes, new lessons, lesson improvements, and new training events.

- Report a bug or issue to our [issue tracker](https://github.com/NCEAS/nceas-training/issues)
- Fix a bug or contribute a lesson with a Pull Request
- Add a training event with a Pull Request

## Getting started
For this repository, contributors use a [forking workflow](https://learning.nceas.ucsb.edu/2023-04-coreR/session_17.html#forking-workflow). This means contributors make edits to the materials from this repository in their forked copy of `nceas-training` and to merge these edits to `NCEAS/nceas-training` (the original repository) then they open a pull request (PR).

To contribute to this repository, use these steps to get started:

1. `Fork` the `nceas-training` repository by clicking the "Fork" button at the top right of the repository 
    a. In the "Create a new fork" screen make sure the Owner is set to your GitHub user and don't change the repository name
    b. If you need access to more branches than `main` in the `NCEAS/nceas-training` repository, uncheck "Copy the `main` branch only"
2. Clone `{yourUsername}/nceas-training` (this is your forked copy) into your workspace onto your computer

## Fixing a bug or contributing to a lesson or files in `nceas-training`

1. Add an [issue](https://github.com/NCEAS/nceas-training/issues) describing your planned changes, or add a comment to an existing issue
2. **Make sure you're working in the right branch and sync changes / pull from the upstream respository before you start making changes** 

    a. Once you've identified which branch you want to work in check that the branch in your forked repository is in "Sync" with `NCEAS/nceas-training` (aka the upstream repository) *before* you start making changes. This will ensure that your forked repository (`{yourUsername}/nceas-training`) and the upstream repository (`NCEAS/nceas-training`) are in the same state and will prevent merge conflicts from occurring when you PR. For more detailed instructions on how to sync your forked repository, see the section [Syncing your forked repository with the upstream repository](#syncing-your-forked-repository-with-the-upstream-repository)

4. Make your changes and `push` changes to your forked repository 
5. Open a Pull Request (PR). Make sure that the base repository is `NCEAS/nceas-training` and the head repository is `{yourUsername}/nceas-training`. It's also important to double check that the base branch of the `NCEAS/nceas-training` matches up with the compare branch in `{yourUsername}/nceas-training`. Aka make sure that you're merging in the right branches
6. Assign someone from the NCEAS GitHub Organization to review your changes
7. Your reviewer may request changes before merging in the changes and closing the PR. This discussion can take place in the "Conversation" tab of the PR webpage
8. Once changes have been confirmed, the reviewer will merge in the changes and close the PR, and you're done!

## Adding a training event


## Syncing your forked repository with the upstream repository 

These are detailed instructions building off step two in the Fixing a bug or contributing to a lesson or files in `nceas-training` section and step {BLANK} in the Adding a training event section. These instructions provide two methods for syncing your forked repository (`{yourUsername}/nceas-training`) with upstream repository (`NCEAS/nceas-training`).
    
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

## Pull Requests
We use pull requests to review and discuss changes before merging contributor's additions or new feature into `NCEAS/nceas-training`

We use the pull-request model for contributions. See [GitHub's help on pull-requests](https://help.github.com/articles/about-pull-requests/).

In short:

- add an [issue](https://github.com/NCEAS/nceas-training/issues) describing your planned changes, or add a comment to an existing issue;
- on GitHub, fork the [nceas-training repository](https://github.com/NCEAS/nceas-training)
- on your computer, clone your forked copy of the nceas-training repository
- checkout the appropriate event branch and commit your changes, or create a new branch
- push your branch to your forked repository, and submit a pull-request against the event branch on nceas-training
- our team will be notified of your Pull Request and will review your changes
- our team may request changes before we will approve the Pull Request, or we will make them for you
- once the code is reviewed, our team will merge in your changes and you're done!

## Materials Development Workflow

Changes to materials, including adding lessons or events, are managed through the git repository at https://github.com/NCEAS/nceas-training. The repository is organized into several branches, each corresponding to a specific training event. This allows for material to be selected, remixed, and adapted to fit the specific needs of each event.

**master**. The `master` branch represents the most recent version of materials used in any event. 

**YYYY-MM-org**. Event branches are named with the year and month in which the event takes place, and the organization or name of the event. For example, the October 2020 Arctic Data Center training event materials are located under 2020-10-arctic.

### Material Development Guidelines

Lesson content is stored in `materials/sections/`. Bookdown sections are generated in the top level of the `materials/` directory, which knit together the child RMarkdown section documents.

In expanding existing materials you are welcome to:

- add a new section as an Rmd to the `materials/sections` directory
- add or edit material to existing Rmd sections

In developing content for a new event you will likely need to:

- create top level Rmd files in `materials/` that select the sections you are teaching
- edit `materials/index.Rmd` to customize introductory material to your event
- edit `materials/_bookdown.yml` to include the chapters in `materials/` that you are teaching.

We ask that you not:

- delete content wholesale. Content that you are not teaching can remain in the repository without needing to be deleted. Instead, select content via your chapters in `materials/` and the content of `materials/_bookdown.yml`.
- commit very large data or presentation files.

## Building the book

While there are many workflows for building the Rmd files into the rendered bookdown,
probably the simplest to use during authoring is to run `bookdown::serve_book('materials')`,
assuming your working directory is the root of the nceas-training repository. This
will load the rendered view into the RStudio `Viewer` pane, and any time you make a change
to the Rmd files in the book, the book will be rebuild and loaded into the pane. For a larger
view, you can open the content from the VIewer pane into a separate web browser. When you
are done, or if you want to stop the book from being served, run `servr::daemon_stop()`.


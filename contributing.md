# Contributing to nceas-training

:tada: First off, thanks for contributing! :tada:

- [Types of contributions](#types-of-contributions)
- [Pull Requests](#pull-requests)
- [Development Workflow](#development-workflow)

## Types of contributions

We welcome all types of contributions, including bug fixes, new lessons, lesson improvements, and new courses.

- Report a bug or issue [issue tracker](https://github.com/NCEAS/nceas-training/issues)
- Fix a bug or contribute a lesson with a Pull Request
- Add a training event with a Pull Request

## Building the book

While there are many workflows for building the Rmd files into the rendered bookdown,
probably the simplest to use during authoring is to run `bookdown::serve_book('materials')`,
assuming your working directory is the root of the nceas-training repository. This
will load the rendered view into the RStudio `Viewer` pane, and any time you make a change
to the Rmd files in the book, the book will be rebuild and loaded into the pane. For a larger
view, you can open the content from the VIewer pane into a separate web browser. When you
are done, or if you want to stop the book from being served, run `servr::daemon_stop()`.

## Pull Requests
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


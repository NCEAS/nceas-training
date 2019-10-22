NCEAS Training
==============

This repository contains lessons used in NCEAS training events. The lessons are all written in RMarkdown and set up so that they build as a bookdown.

## Customizing Materials

To create a custom book for a specific training, create a new branch for the training event (eg 2019-11-RRCourse). In that branch, you can make changes to _bookdown.yml to specify which chapters to include, and you can modify chapters. The built book should be hosted on another repository specific to that training event, **not** this repository. Please do not commit built versions of the book. Additionally, when adding material please carefully consider file size. PDF presentations should be compressed, and data files, if absolutely necessary, should be small (< 1MB). 

## Updating Materials

Changes to chapters that would be beneficial to other training events should be merged back into the master branch.
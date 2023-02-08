Find HXL Proxy resources on HDX
===============================

This script will crawl the [Humanitarian Data Exchange](https://data.humdata.org) (HDX) and identify all public resources that have links to the [#HXL Proxy](https://proxy.hxlstandard.org)


## Installation

Using the Makefile will create a Python3 virtual environment automatically. If you wish to do it manually, use the following commands:

  python3 -m venv venv
  pip3 install -r requirements.txt
  

## Usage

Output will appear in ``output/hxl-proxy-resources.csv`` and ``output/hxl-proxy-recipes.csv``

### Initial run

    make run

### Update

    make clean run

## Output format

### Resources

The output is a #HXL-tagged CSV file with the following columns:

Header | #HXL hashtag | Description
-- | -- | --
Org | #org+provider | The unique short name for the provider org on HDX.
Dataset | #x_dataset | The unique short name for the dataset on HDX.
Resource | #x_resource | The unique identifier for the resource on HDX.
State | #status | The status of the dataset (e.g. "active").
URL | #meta+url | The #HXL Proxy URL for the resource contents.

### REcipes

The output is a #HXL-tagged CSV file with the following columns:

Header | #HXL hashtag | Description
-- | -- | --
Recipe | #x_recipe_url | The base URL of the HXL Proxy saved recipe.
Count | #meta+count | The number of times the recipe is used in HDX resources.

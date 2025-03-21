#!/bin/bash

################################################################################################
### OBTAINING DATA
################################################################################################

## Load all datasets from sources using the civic data loader
## https://github.com/NYCPlanning/data-loading-scripts

cd '/prod/data-loading-scripts'

## Open_datasets - PULLING FROM OPEN DATA
echo 'Loading open source datasets...'
node loader.js install sca_cp_programs
node loader.js install sca_cp_programs_prev
node loader.js install sca_cp_cap_schools
node loader.js install sca_cp_cap_location
node loader.js install sca_cp_cap_location_process
node loader.js install sca_cp_cap_schools_prev
node loader.js install sca_cp_cap_location_prev
node loader.js install sca_cp_prek_schools
node loader.js install sca_cp_prek_location
node loader.js install sca_cp_prek_schools_prev
node loader.js install sca_cp_prek_location_prev
node loader.js install sca_cp_threeprek_schools
node loader.js install sca_cp_threeprek_location
node loader.js install sca_cp_rep_schools
node loader.js install sca_cp_class_size_reduction
node loader.js install doe_facilities_lcgms
node loader.js install doe_facilities_schoolsbluebook
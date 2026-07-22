
<!-- README.md is generated from README.Rmd. Please edit that file -->

# About

The R code and data provided in this repository allow users to reproduce
Figures 1 and 2 from *“Toward a Participatory and Adaptive Ecology of
Biodiversity Conservation”*.

The data from Eichenberg et al. (2020) used in Figure 2, i.e., species
occupancy probabilities for German ordnance grid cells, are publicly
available through the iDiv Data Repository:

<https://idata.idiv.de/ddm/Data/ShowData/1875?version=9>

## Folder structure

### `r_scripts_forpub`

1.  `00-preamble.R`  
    Loads the R packages, fonts, plotting settings, object definitions,
    and other global options required to reproduce the figures.

2.  `01-gdiv-visualization.R`  
    Reproduces Figures 1 and 2. The script maps threatened plant species
    recorded in GartenDiv, summarizes their Red List categories,
    quantifies records occurring north of species’ historical ranges,
    and visualizes two example species.

### `data_forpub`

1.  `counts_germany.rds`  
    Spatial polygon dataset used for Figure 1a. It contains
    geographically aggregated GartenDiv observations for Germany,
    including the number of threatened-species observations and the
    number of threatened species recorded in each spatial unit.

2.  `rl_freqs.csv`  
    Summary table used for Figure 1b. It contains the number of
    GartenDiv plant species assigned to each Red List category.

3.  `polewards.csv`  
    Dataset used for Figure 2a. It contains estimated northward
    differences between GartenDiv records and the northern limits of the
    corresponding species’ historical ranges. The variable
    `poleward_shift` is expressed in degrees latitude.

4.  `salixm_historical_range.rds`  
    Spatial dataset describing the historical distribution of *Salix
    myrtilloides* in Germany. The dataset contains estimated occupancy
    probabilities (`OP`) for German ordnance grid cells and is used as
    the background layer in Figure 2b.

5.  `salixm_gartendiv.rds`  
    Spatial point dataset containing spatially scrambled GartenDiv
    records of *Salix myrtilloides*. It is used to compare GartenDiv
    occurrences with the species’ historical range in Figure 2b.

6.  `astera_historical_range.rds`  
    Spatial dataset describing the historical distribution of *Aster
    amellus* in Germany. The dataset contains estimated occupancy
    probabilities (`OP`) for German ordnance grid cells and is used as
    the background layer in Figure 2c.

7.  `astera_gartendiv.rds`  
    Spatial point dataset containing spatially scrambled GartenDiv
    records of *Aster amellus*. It is used to compare GartenDiv
    occurrences with the species’ historical range in Figure 2c.

## Contact

Please contact us at <ingmar.staude@uni-leipzig.de> if you have further
questions.

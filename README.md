
Southern hake governance analysis

This repository contains the code and processed data to reproduce Figures 2, 3A, 3B, and 4 from the manuscript:

**Untangling the Overexploitation Trap: Governance, Politics of Concepts, and the Sustainability Claims of Chilean Southern Hake**

*Published in Fisheries Management and Ecology*

DOI: 

## Repository structure

Southernhake/
├── README.md # This file
├── figures.R # R script to reproduce all figures
├── data/ # Processed CSV files (derived from official STC minutes)
└── output/ # Generated figures (PNG)

## Requirements

- R (version 4.0 or later)
- R packages: `ggplot2`, `reshape2`, `dplyr`

Install them with:
```r
install.packages(c("ggplot2", "reshape2", "dplyr"))

**Instructions**

Clone or download this repository.
Open R and set the working directory to the repository folder.
Run the script:

r
source("figures.R")

The figures will be saved in the output/ folder as PNG files.
Data sources

All data were derived from official meeting minutes of Chile's Scientific Technical Committee for Demersal Resources in the Southern Austral Zone (STC-DRSAZ), spanning December 2013 – October 2025, and official quota resolutions from the Ministry of Economy, Development and Tourism (MINECON). The raw minutes are publicly available on the SUBPESCA website. This repository contains only the processed summaries necessary to reproduce the figures.


**Contact**

Corresponding author: Renato Gozzer-Wuest (renato.gozzer@ocean-action.org)

# pHe-analysis
Scripts for analysis of pHe Data

## pHViability.R

This R script takes counted nuclei (DAPI-total, FITC-dead via SYTOX Green) and 
arranges them such that hypothesis testing and plotting can be done with minimal
intervention in spreadsheet software. 

## totalCellCount.R

This R script is for the most part identical to pHViability.R, but 
has the following changes

+ Rather than analyze percent viability, we are analyzing the total cell count per image frame

This is useful if you need to see if cells are lysing/detaching due to a
condition.

## gapClosure.R

Quantification of migration during gap closure assay.

## nhe1Active.pml

PyMOL script to render a PDB (7DSV) of NHE1 with the following

+ Bound calcineurin removed
+ Subunits of the dimer colored gray/tv_green
+ C-Terminal tails colored cyan/tv_blue
+ Cartoon-style rendering ([Goodsell-like](https://pymolwiki.org/index.php/Gallery))

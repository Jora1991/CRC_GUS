# Analysis for gut microbial β-glucuronidases in Colorectal Cancer
Development of colorectal cancer (CRC) is accompanied by microbial and metabolic dysbiosis, with gut microbial β-glucuronidases (gmGUSs) potentially impacting carcinogenesis through de-glucuronidation of diverse important molecules. This study constructed an atlas of 550 gmGUSs from a public CRC cohort, employing 114 reference GUSs, three GUS domains, and seven conserved residues. Analysis along CRC stages revealed enrichment of Mini-Loop2 and GUS-harboring species Bacteroides cellulosilyticus and Bacteroides nordii, in late-stage. Moreover, 38 differential gmGUSs were identified totally, effectively classifying patients from controls (AUCs > 0.8). A GUSscore model based on five gmGUSs mainly from B. cellulosilyticus well predicted CRC outcomes (AUCs > 0.8). Notable gmGUS-associated genus-level shifts included reduced Lachnospira and Bifidobacterium, and increased Prevotella, Alistipes, and Fusobacterium. Particularly, several functional species were enriched in late-stage, including sulfate reducers, mucin and flavonoid degraders. Orthology-gmGUS-metabolite interactions revealed specific biological links in amino acid metabolism, vitamin biosynthesis, bacterial behavior, and LPS biosynthesis. These findings firstly define the disturbance of microbe-gmGUS-metabolite axis in colorectal tumorigenesis and its potential as early diagnostic biomarkers and therapeutic targets for CRC.

## Contents in 00.rawdata
This folder contains the raw files needed for analysis
* [CNV](CNV/): Output from MIDAS2, used for copy number variation analysis.
* [Cohorts](Cohorts/): The group information and GUS abundance profile of the AUS, FRA, GER cohorts.
* [KOinfo](KOinfo/): The KEGG-Orthology (KO) information.
* [Liter](Liter/): Manual categorization of species, KOs, and metabolites.
* [mOTUs4](mOTUs4/): Species profile based on mOTUs4.
* [supp](supp/): Supplementary files from the study cohort, including profiles of species, KOs, and metabolites, as well as the differences of these features.
* [38gmGUS.tre](38gmGUS.tre): The netwick tree file of 38 significant gmGUSs.
* [GUSabun_ABS.csv](GUSabun_ABS.csv): The absolute abundance profile of gmGUSs.
* [GUSabun_TPM.csv](GUSabun_TPM.csv): The TPM abundance profile of gmGUSs.
* [GUSsStat.csv](GUSsStat.csv): The loop category, taxonomic annotation of gmGUSs.
* [GlcA.LCA.output.m8](GlcA.LCA.output.m8): List of GlcA-utilizing species, tabular format.
* [group.csv](group.csv): Group information of the study cohort.
* [referenceStat.csv](referenceStat.csv): The loop category and taxonomic information of 114 references.
* [signGUSs.RDS](signGUSs.RDS): A RDS file for the 38 signficant gmGUSs.


## System Requirements
The R scripts requires only a standard computer with enough RAM to support the in-memory operations.
The scripts have been tested on macOS system, but Linux is theoretically feasible as well.
* [R](https://cran.r-project.org)

## Installation
No additional installation is required. Simply download the scripts and resources for use.

## Citation
For usage of the tool, please cite the associated manuscript.

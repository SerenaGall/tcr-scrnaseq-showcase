# Shared setup sourced at the top of every chapter -----------------------------

suppressPackageStartupMessages({
  library(Seurat)
  library(SeuratObject)
  library(tidyverse)
  library(patchwork)
  library(scales)
  library(ggrepel)
  library(knitr)
  library(clustree)
  library(DoubletFinder)
  library(harmony)
  library(edgeR)
  library(limma)
  library(AnnotationDbi)
  library(org.Mm.eg.db)
  library(clusterProfiler)
  library(ReactomePA)
  library(SingleCellExperiment)
  library(miloR)
  library(slingshot)
  library(tradeSeq)
})

# Resolve namespace clashes in favour of the tidyverse verbs used in the book
select <- dplyr::select
filter <- dplyr::filter
rename <- dplyr::rename
count  <- dplyr::count

set.seed(42)
options(future.globals.maxSize = 8 * 1024^3)

for (d in c("data", "output", "tables", "figures")) {
  dir.create(d, showWarnings = FALSE, recursive = TRUE)
}

# Study design (GEO GSE344965, lung CD4+ T cells) -----------------------------
# Hashtag-multiplexed mice from one 10x GEM-X 5' library. Two arms are analysed:
#   Control : control VHH, mice M01-M04
#   TNFR2a  : TNFR2 agonist, mice M05-M08
# Each mouse is a biological replicate and is used as `orig.ident`.

geo_accession <- "GSE344965"
geo_rds_url <- paste0(
  "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE344nnn/GSE344965/suppl/",
  "GSE344965_Figure3_Mouse_CD4_Lung.RDS"
)
geo_rds_file <- "data/raw/GSE344965_Figure3_Mouse_CD4_Lung.RDS"

cond_levels <- c("Control", "TNFR2a")

sample_design <- tibble::tibble(
  geo_mouse = c("M01", "M02", "M03", "M04", "M05", "M06", "M07", "M08"),
  geo_treatment = rep(c("OD545-GFP", "OD1031-TNFR2a"), each = 4),
  Condition = rep(cond_levels, each = 4),
  sample = c(paste0("Ctrl_", 1:4), paste0("TNFR2a_", 1:4))
) %>%
  dplyr::mutate(suffix = paste0("_", dplyr::row_number()))

sample_levels <- sample_design$sample

# Cell barcodes in the merged object end in the per-sample suffix above
sample_suffix_map <- sample_design %>% dplyr::select(sample, suffix)

condition_from_sample <- function(x) {
  factor(
    dplyr::case_when(
      grepl("^Ctrl_", x) ~ "Control",
      grepl("^TNFR2a_", x) ~ "TNFR2a",
      TRUE ~ NA_character_
    ),
    levels = cond_levels
  )
}

condition_cols <- c(Control = "#7F7F7F", TNFR2a = "#D55E00")

# Cell-state vocabulary shared by all downstream chapters
source("R/states.R")

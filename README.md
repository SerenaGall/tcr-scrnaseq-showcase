# Lung CD4⁺ T cells under TNFR2 agonism: scRNA-seq + TCR-seq workflow

A reproducible Quarto book that walks through a complete single-cell RNA-seq and paired TCR-seq analysis of CD4⁺ T cells, using public data from [GEO GSE344965](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE344965) (TNFR2 agonist vs control, 4 mice per arm).

**Read the book:** https://serenagall.github.io/tcr-scrnaseq-showcase/

## Contents

Preprocessing and hashtag demultiplexing · QC, doublet detection, SCTransform and Harmony integration · Leiden clustering and annotation · TCR clonotype reconstruction and expansion · Pseudobulk differential expression (edgeR) · Clonotype-informed DE · Pathway enrichment (ORA/GSEA) · Trajectory analysis (Slingshot, tradeSeq)

## Reproduce

Requires R (≥ 4.4) with Seurat 5, and Quarto.

```bash
quarto render
```

The first chapter downloads the GEO object (~530 MB) to `data/raw/`. Computed results are cached in `_freeze/`; the GitHub Actions workflow publishes the site from that cache without re-running R.

## Data note

GEO provides the authors' processed Seurat object. Raw integer UMI counts are recovered exactly from its CPM assay (see the Preprocessing chapter); mitochondrial and ribosomal-protein genes were removed by the depositors, so their per-cell fractions are taken from the deposited metadata.

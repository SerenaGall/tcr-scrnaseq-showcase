# Helper functions shared across chapters --------------------------------------

#' Summarise singlet/doublet calls per sample
#'
#' @param obj_list Named list of Seurat objects (one per sample).
#' @param class_col Metadata column holding "Singlet"/"Doublet" calls.
#' @param sample_col Metadata column holding the sample name.
#' @return list(summary_table = tibble with Sample, Singlet, Doublet,
#'   Total, Doublet_Rate in percent).
quick_doublet_summary_auto <- function(obj_list,
                                       class_col = "DF_status",
                                       sample_col = "orig.ident") {
  summary_table <- purrr::map_dfr(obj_list, function(x) {
    md <- x@meta.data
    tibble::tibble(
      Sample = as.character(unique(md[[sample_col]]))[1],
      Singlet = sum(md[[class_col]] == "Singlet", na.rm = TRUE),
      Doublet = sum(md[[class_col]] == "Doublet", na.rm = TRUE)
    )
  }) %>%
    dplyr::mutate(
      Total = Singlet + Doublet,
      Doublet_Rate = round(100 * Doublet / Total, 2)
    )

  list(summary_table = summary_table)
}

#' Mouse cell-cycle genes from Seurat's human list (title-case conversion)
mouse_cc_genes <- function() {
  cc <- Seurat::cc.genes.updated.2019
  tibble::tibble(
    mgi_symbol = stringr::str_to_title(c(cc$s.genes, cc$g2m.genes)),
    phase = c(rep("S", length(cc$s.genes)), rep("G2M", length(cc$g2m.genes)))
  )
}

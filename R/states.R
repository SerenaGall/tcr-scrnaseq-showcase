# Refined CD4+ T-cell states (assigned in Revised_clustering.qmd) --------------

state_levels_all <- c(
  "Naive_like",
  "Activated_memory_like",
  "Th1_cytotoxic_like",
  "Th2_tissue_like",
  "IL17_like",
  "Treg_resting_like",
  "Treg_tissue_like",
  "IFN_response",
  "Cycling",
  "Unresolved_state"
)

state_labels_all <- c(
  "Naive_like"            = "Naive-like",
  "Activated_memory_like" = "Activated/memory-like",
  "Th1_cytotoxic_like"    = "Th1/cytotoxic-like",
  "Th2_tissue_like"       = "Th2/tissue-like",
  "IL17_like"             = "IL-17-like",
  "Treg_resting_like"     = "Treg resting-like",
  "Treg_tissue_like"      = "Treg tissue-like",
  "IFN_response"          = "IFN-response",
  "Cycling"               = "Cycling",
  "Unresolved_state"      = "Unresolved"
)

state_cols_all <- c(
  "Naive_like"            = "#E76F51",
  "Activated_memory_like" = "#C77C00",
  "Th1_cytotoxic_like"    = "#7CAE00",
  "Th2_tissue_like"       = "#00A087",
  "IL17_like"             = "#1F78B4",
  "Treg_resting_like"     = "#8ECFE8",
  "Treg_tissue_like"      = "#00838F",
  "IFN_response"          = "#619CFF",
  "Cycling"               = "#CC79A7",
  "Unresolved_state"      = "#BDBDBD"
)

# States used for the activation trajectory (conventional CD4 + Treg branches)
trajectory_states_default <- c(
  "Naive_like",
  "Activated_memory_like",
  "Th1_cytotoxic_like",
  "Treg_resting_like",
  "Treg_tissue_like"
)

# Shared diagnostic marker panel for the refined states
state_marker_groups <- list(
  "T-cell identity"        = c("Cd3e", "Cd4"),
  "Naive / central memory" = c("Sell", "Ccr7", "Lef1", "Dapl1"),
  "Activated / memory"     = c("Cd44", "Tnfsf8", "Tnfsf11", "Itgb1"),
  "Th1 / cytotoxic"        = c("Tbx21", "Ifng", "Ccl5", "Nkg7"),
  "Th2 / tissue"           = c("Gata3", "Il1rl1", "Arg1", "Pparg"),
  "IL-17"                  = c("Rorc", "Il23r", "Il17a", "Il1r1"),
  "Treg"                   = c("Foxp3", "Il2ra", "Ctla4", "Izumo1r"),
  "Tissue Treg / TNFR2"    = c("Tnfrsf1b", "Klrg1", "Areg", "Tnfrsf9"),
  "IFN-response"           = c("Ifit1", "Isg15", "Irf7"),
  "Cycling"                = c("Mki67", "Top2a", "Ccna2"),
  "Contamination check"    = c("Cd8a", "Zbtb16", "Klrb1c", "Cd19")
)

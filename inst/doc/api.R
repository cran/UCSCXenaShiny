## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center"
)

## ----setup--------------------------------------------------------------------
library(UCSCXenaShiny)

## -----------------------------------------------------------------------------
args(query_pancan_value)

## -----------------------------------------------------------------------------
gene_expr <- query_pancan_value("TP53")

## -----------------------------------------------------------------------------
str(gene_expr)

## ----eval=FALSE---------------------------------------------------------------
#  transcript_expr <- query_pancan_value("ENST00000000233", data_type = "transcript")

## ----eval=FALSE---------------------------------------------------------------
#  gene_cnv <- query_pancan_value("TP53", data_type = "cnv")

## ----eval=FALSE---------------------------------------------------------------
#  gene_mut <- query_pancan_value("TP53", data_type = "mutation")

## ----eval=FALSE---------------------------------------------------------------
#  miRNA_expr <- query_pancan_value("hsa-let-7a-2-3p", data_type = "miRNA")

## ----fig.width=12-------------------------------------------------------------
vis_toil_TvsN(Gene = "TP53", Mode = "Violinplot", Show.P.value = FALSE, Show.P.label = FALSE)

## ----fig.width=5--------------------------------------------------------------
vis_toil_TvsN_cancer(
  Gene = "TP53",
  Mode = "Violinplot",
  Show.P.value = TRUE,
  Show.P.label = TRUE,
  Method = "wilcox.test",
  values = c("#DF2020", "#DDDF21"),
  TCGA.only = FALSE,
  Cancer = "ACC"
)

## ----fig.width=5, fig.height=6------------------------------------------------
vis_unicox_tree(
  Gene = "TP53",
  measure = "OS",
  threshold = 0.5,
  values = c("grey", "#E31A1C", "#377DB8")
)


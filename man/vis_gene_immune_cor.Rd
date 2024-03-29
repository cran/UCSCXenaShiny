% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vis_pancan_value.R
\name{vis_gene_immune_cor}
\alias{vis_gene_immune_cor}
\title{Heatmap for Correlation between Gene and Immune Signatures}
\usage{
vis_gene_immune_cor(
  Gene = "TP53",
  cor_method = "spearman",
  data_type = "mRNA",
  Immune_sig_type = "Cibersort",
  Plot = "TRUE",
  opt_pancan = .opt_pancan
)
}
\arguments{
\item{Gene}{a molecular identifier (e.g., "TP53") or a formula specifying
genomic signature (\code{"TP53 + 2 * KRAS - 1.3 * PTEN"}).}

\item{cor_method}{correlation method}

\item{data_type}{choose gene profile type,
including "mRNA", "transcript", "protein", "mutation", "cnv", "methylation", "miRNA".}

\item{Immune_sig_type}{quantification method, default is "Cibersort"}

\item{Plot}{output the plot directly, default 'TRUE'}

\item{opt_pancan}{specify one dataset for some molercular profiles}
}
\description{
Heatmap for Correlation between Gene and Immune Signatures
}
\examples{
\dontrun{
p <- vis_gene_immune_cor(Gene = "TP53")
}
}

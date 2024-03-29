% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tcga_surv.R
\name{tcga survival analysis}
\alias{tcga survival analysis}
\alias{tcga_surv_get}
\alias{tcga_surv_plot}
\title{TCGA Survival Analysis}
\usage{
tcga_surv_get(
  item,
  TCGA_cohort = "LUAD",
  profile = c("mRNA", "miRNA", "methylation", "transcript", "protein", "mutation", "cnv"),
  TCGA_cli_data = dplyr::full_join(load_data("tcga_clinical"), load_data("tcga_surv"), by
    = "sample"),
  opt_pancan = .opt_pancan
)

tcga_surv_plot(
  data,
  time = "time",
  status = "status",
  cutoff_mode = c("Auto", "Custom"),
  cutpoint = c(50, 50),
  cnv_type = c("Duplicated", "Normal", "Deleted"),
  profile = c("mRNA", "miRNA", "methylation", "transcript", "protein", "mutation", "cnv"),
  palette = "aaas",
  ...
)
}
\arguments{
\item{item}{a molecular identifier, can be gene symbol (common cases), protein symbol, etc.}

\item{TCGA_cohort}{a TCGA cohort, e.g. "LUAD" (default), "LUSC", "ACC".}

\item{profile}{a molecular profile. Option can be one of "mRNA" (default), "miRNA", "methylation", "transcript", "protein", "mutation", "cnv".}

\item{TCGA_cli_data}{a \code{data.frame} containing TCGA clinical data. Default use pre-compiled TCGA clinical data in
this package.}

\item{opt_pancan}{specify one dataset for some molercular profiles}

\item{data}{a subset of result from \code{tcga_surv_get()}.}

\item{time}{the column name for "time".}

\item{status}{the column name for "status".}

\item{cutoff_mode}{mode for grouping samples, can be "Auto" (default) or "Custom".}

\item{cutpoint}{cut point (in percent) for "Custom" mode, default is \code{c(50, 50)}.}

\item{cnv_type}{only used when profile is "cnv", can select from \code{c("Duplicated", "Normal", "Deleted")}.}

\item{palette}{color palette, can be "hue", "grey", "RdBu", "Blues", "npg", "aaas", etc.
More see \code{?survminer::ggsurvplot}.}

\item{...}{other parameters passing to \code{survminer::ggsurvplot}}
}
\value{
a \code{data.frame} or a plot.
}
\description{
\itemize{
\item Firstly, get merged data of one molecular profile value and associated clinical data from TCGA Pan-Cancer dataset.
\item Secondly, filter data as your wish.
\item Finally, show K-M plot.
}
}
\examples{
\dontrun{
# 1. get data
data <- tcga_surv_get("TP53")
# 2. filter data (optional)

# 3. show K-M plot
tcga_surv_plot(data, time = "DSS.time", status = "DSS")
}
}

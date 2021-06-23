% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vis_pancan_value.R
\name{vis_pancan_anatomy}
\alias{vis_pancan_anatomy}
\title{Visualize Single Gene Expression in Anatomy Location}
\usage{
vis_pancan_anatomy(
  Gene = "TP53",
  Gender = c("Female", "Male"),
  data_type = "mRNA",
  option = "D"
)
}
\arguments{
\item{Gene}{a molecular identifier (e.g., "TP53") or a formula specifying
genomic signature (\code{"TP53 + 2 * KRAS - 1.3 * PTEN"}).}

\item{Gender}{a string, "Female" (default) or "Male".}

\item{data_type}{choose gene profile type, including "mRNA","transcript","methylation","miRNA","protein","cnv_gistic2"}

\item{option}{A character string indicating the colormap option to use. Four
options are available: "magma" (or "A"), "inferno" (or "B"), "plasma" (or "C"),
"viridis" (or "D", the default option) and "cividis" (or "E").}
}
\value{
a \code{ggplot} object
}
\description{
Visualize Single Gene Expression in Anatomy Location
}
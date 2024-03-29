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
  option = "D",
  opt_pancan = .opt_pancan
)
}
\arguments{
\item{Gene}{a molecular identifier (e.g., "TP53") or a formula specifying
genomic signature (\code{"TP53 + 2 * KRAS - 1.3 * PTEN"}).}

\item{Gender}{a string, "Female" (default) or "Male".}

\item{data_type}{choose gene profile type, including "mRNA","transcript","methylation","miRNA","protein","cnv"}

\item{option}{A character string indicating the color map option to use.
Eight options are available:
\itemize{
 \item "magma" (or "A")
 \item "inferno" (or "B")
 \item "plasma" (or "C")
 \item "viridis" (or "D")
 \item "cividis" (or "E")
 \item "rocket" (or "F")
 \item "mako" (or "G")
 \item "turbo" (or "H")
}}

\item{opt_pancan}{specify one dataset for some molercular profiles}
}
\value{
a \code{ggplot} object
}
\description{
Visualize Single Gene Expression in Anatomy Location
}

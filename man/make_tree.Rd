% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_tree.R
\name{make_tree}
\alias{make_tree}
\title{Make a tree of an ontology}
\usage{
make_tree(..., reverse = FALSE, ontology = NULL)
}
\arguments{
\item{...}{\code{\link[=character]{character(1)}}\cr the concepts that shall be the
target, combination of \emph{'column name = value'}.}

\item{reverse}{\code{\link[=logical]{logical(1)}}\cr whether or not to make a tree that
gives the parents, instead of the children, of target concepts.}

\item{ontology}{\code{\link[=list]{ontology(1)}}\cr either a path where the ontology is
stored, or an already loaded ontology.}
}
\description{
Make a tree of an ontology
}

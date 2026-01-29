#!/usr/bin/env Rscript

# gRNA Cloning Oligo Formatter
# Formats pre-designed gRNA sequences into cloning-ready oligonucleotides
# with appropriate overhangs for BsmBI-based cloning into lentiGuide-puro
#
# NOTE: This tool does NOT design gRNAs. Use gRNA design tools like
# CHOPCHOP, Benchling, or CRISPick to design your target sequences first.
#
# Author: Can Ozcan
# Date: 2023-07-09
# Updated: 2026-01-28

# Load required libraries
cat("Loading required packages...\n")
suppressPackageStartupMessages({
  library(readxl)
  library(tidyverse)
  library(openxlsx)
})

# Function to reverse string
strreverse <- function(x) {
  strsplit(x, NULL) %>% 
    lapply(rev) %>% 
    sapply(paste, collapse = "")
}

# Define overhangs for BsmBI-based cloning into lentiGuide-puro
forw_overhang <- "cacc"
forw_overhang_g <- "caccg"
rev_overhang <- "aaac"
rev_overhang_2 <- "c"

# Main function
design_oligos <- function(input_file = "oligo_list.xlsx", 
                          output_file = "ready_to_order.xlsx",
                          sheet_name = "Sayfa1") {
  
  cat("========================================\n")
  cat("gRNA Cloning Oligo Formatter\n")
  cat("========================================\n\n")
  
  # Check if input file exists
  if (!file.exists(input_file)) {
    stop(paste("Error: Input file", input_file, "not found in current directory."))
  }
  
  cat(paste("Reading input file:", input_file, "\n"))
  
  # Read input file
  tryCatch({
    input_data <- read_excel(input_file, sheet = sheet_name)
  }, error = function(e) {
    # If specified sheet doesn't exist, try the first sheet
    cat("Specified sheet not found, trying first sheet...\n")
    input_data <- read_excel(input_file, sheet = 1)
  })
  
  # Validate input columns
  if (!all(c("name", "target_seq") %in% colnames(input_data))) {
    stop("Error: Input file must contain 'name' and 'target_seq' columns")
  }
  
  cat(paste("Processing", nrow(input_data), "guide sequences...\n\n"))
  
  # Generate reverse complement
  input_data <- input_data %>% 
    mutate(reversed = strreverse(target_seq))
  
  input_data$reversed <- chartr("ACGT", "TGCA", input_data$reversed)
  
  # Add appropriate overhangs
  input_data <- input_data %>% 
    mutate(
      forward_oligo = as.character(target_seq),
      forward_oligo = ifelse(
        startsWith(target_seq, "G"),
        paste0(forw_overhang, target_seq),
        paste0(forw_overhang_g, target_seq)
      )
    ) %>% 
    mutate(
      reverse_oligo = as.character(reversed),
      reverse_oligo = ifelse(
        startsWith(target_seq, "G"),
        paste0(rev_overhang, reversed),
        paste0(rev_overhang, reversed, rev_overhang_2)
      )
    )
  
  # Format output
  output_data <- input_data[, c(1, 4, 5)]
  output_data <- output_data %>% 
    pivot_longer(
      !name, 
      names_to = "strand", 
      values_to = "sequence"
    ) %>% 
    mutate(oligo_name = paste0(name, "-", strand))
  
  # Clean up oligo names
  output_data$oligo_name <- gsub("_o.*", "", output_data$oligo_name)
  output_data <- output_data[, c(4, 3)]
  
  # Write output
  cat(paste("Writing output to:", output_file, "\n"))
  write.xlsx(
    output_data, 
    file = output_file, 
    sheetName = "Sheet1", 
    colNames = TRUE, 
    append = FALSE, 
    colWidths = "auto"
  )
  
  cat("\n========================================\n")
  cat("Processing complete!\n")
  cat("========================================\n\n")
  cat("Summary:\n")
  cat(paste("- Input sequences:", nrow(input_data), "\n"))
  cat(paste("- Output oligos:", nrow(output_data), "\n"))
  cat(paste("- Sequences starting with G:", sum(startsWith(input_data$target_seq, "G")), "\n"))
  cat(paste("- Sequences NOT starting with G:", sum(!startsWith(input_data$target_seq, "G")), "\n"))
  cat("\nOutput file saved successfully!\n")
  cat(paste("File location:", file.path(getwd(), output_file), "\n"))
  
  # Preview first few entries
  cat("\nFirst 3 oligo pairs:\n")
  print(head(output_data, 6))
  
  return(invisible(output_data))
}

# Run the main function
if (!interactive()) {
  # Script is being run from command line
  args <- commandArgs(trailingOnly = TRUE)
  
  if (length(args) == 0) {
    # Use default filenames
    design_oligos()
  } else if (length(args) == 1) {
    # Input file specified
    design_oligos(input_file = args[1])
  } else if (length(args) >= 2) {
    # Input and output files specified
    design_oligos(input_file = args[1], output_file = args[2])
  }
} else {
  cat("Script loaded. Run design_oligos() to process your data.\n")
  cat("Usage: design_oligos(input_file = 'oligo_list.xlsx', output_file = 'ready_to_order.xlsx')\n")
}

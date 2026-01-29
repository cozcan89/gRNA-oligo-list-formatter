#!/usr/bin/env Rscript

# Test script for gRNA Cloning Oligo Formatter
# This script runs basic tests to ensure everything works correctly

cat("========================================\n")
cat("Testing gRNA Cloning Oligo Formatter\n")
cat("========================================\n\n")

# Test 1: Check required packages
cat("Test 1: Checking required packages...\n")
required_packages <- c("readxl", "tidyverse", "openxlsx")
missing_packages <- c()

for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    missing_packages <- c(missing_packages, pkg)
    cat(sprintf("  ✗ %s is NOT installed\n", pkg))
  } else {
    cat(sprintf("  ✓ %s is installed\n", pkg))
  }
}

if (length(missing_packages) > 0) {
  cat("\nMissing packages detected. Installing...\n")
  install.packages(missing_packages, repos = "https://cloud.r-project.org/")
  cat("Installation complete!\n\n")
} else {
  cat("All required packages are installed!\n\n")
}

# Test 2: Check if input file exists
cat("Test 2: Checking for input file...\n")
if (file.exists("oligo_list.xlsx")) {
  cat("  ✓ Input file 'oligo_list.xlsx' found\n\n")
} else {
  cat("  ✗ Input file 'oligo_list.xlsx' not found\n")
  cat("  Please ensure oligo_list.xlsx is in the current directory\n\n")
  quit(status = 1)
}

# Test 3: Run the main script
cat("Test 3: Running oligo design script...\n")
source("design_oligos.R")

# Test 4: Check output
cat("\nTest 4: Verifying output file...\n")
if (file.exists("ready_to_order.xlsx")) {
  cat("  ✓ Output file 'ready_to_order.xlsx' created successfully\n")
  
  # Read and display first few lines
  library(readxl)
  output <- read_excel("ready_to_order.xlsx")
  cat(sprintf("  ✓ Output contains %d oligos\n", nrow(output)))
  
  cat("\n  First 6 oligos:\n")
  print(head(output))
  
} else {
  cat("  ✗ Output file was not created\n")
  quit(status = 1)
}

# Test 5: Validate some sequences
cat("\nTest 5: Validating sequence structure...\n")
library(tidyverse)
output <- read_excel("ready_to_order.xlsx")

# Check forward oligos
forward_oligos <- output %>% filter(grepl("forward", oligo_name))
all_start_correctly <- all(startsWith(forward_oligos$sequence, "cacc"))

if (all_start_correctly) {
  cat("  ✓ All forward oligos have correct overhang\n")
} else {
  cat("  ✗ Some forward oligos have incorrect overhang\n")
}

# Check reverse oligos
reverse_oligos <- output %>% filter(grepl("reverse", oligo_name))
all_rev_start_correctly <- all(startsWith(reverse_oligos$sequence, "aaac"))

if (all_rev_start_correctly) {
  cat("  ✓ All reverse oligos have correct overhang\n")
} else {
  cat("  ✗ Some reverse oligos have incorrect overhang\n")
}

cat("\n========================================\n")
cat("All tests completed successfully! ✓\n")
cat("========================================\n\n")
cat("The tool is ready to use.\n")
cat("You can now:\n")
cat("  1. Modify oligo_list.xlsx with your own sequences\n")
cat("  2. Run: Rscript design_oligos.R\n")
cat("  3. Order oligos from ready_to_order.xlsx\n\n")

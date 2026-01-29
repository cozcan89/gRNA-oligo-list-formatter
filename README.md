# gRNA Cloning Oligo Formatter

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R](https://img.shields.io/badge/R-%3E%3D3.6.0-blue.svg)](https://www.r-project.org/)
[![Python](https://img.shields.io/badge/Python-%3E%3D3.7-blue.svg)](https://www.python.org/)

A simple tool to format pre-designed CRISPR guide RNA (gRNA) sequences into ready-to-order sense and antisense oligonucleotides with appropriate overhangs for BsmBI-based cloning into lentiGuide-puro vector.

**Note:** This tool does NOT design gRNAs. It takes your already-designed 20bp gRNA target sequences and adds the correct overhangs for cloning.

🧬 **Available in both R and Python!**

---

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [How It Works](#how-it-works)
- [Example](#example)
- [File Descriptions](#file-descriptions)
- [Troubleshooting](#troubleshooting)
- [Citation](#citation)
- [Contributing](#contributing)
- [License](#license)

## Overview

This tool automates the process of formatting pre-designed gRNA target sequences into cloning-ready oligonucleotides. It adds appropriate 5' and 3' overhangs compatible with BsmBI-digested lentiGuide-puro vector.

**What this tool does:**
- Takes your pre-designed 20bp gRNA sequences
- Generates reverse complement sequences
- Adds appropriate cloning overhangs (cacc/caccg and aaac)
- Outputs ready-to-order sense and antisense oligonucleotide pairs

**What this tool does NOT do:**
- Design gRNA sequences (use tools like CHOPCHOP, Benchling, or CRISPick for gRNA design)
- Predict on-target or off-target effects
- Analyze PAM sequences

## Features

- Automatically adds appropriate overhangs for BsmBI-based cloning
- Handles both guide sequences that start with 'G' and those that don't
- Generates both sense (forward) and antisense (reverse) complement oligos
- Outputs ready-to-order oligo sequences in Excel format
- Batch processing of multiple gRNA sequences

## Requirements

### R Version
- R (>= 3.6.0)
- Required R packages:
  - `readxl`
  - `tidyverse`
  - `openxlsx`

### Python Version (Alternative)
- Python (>= 3.7)
- Required Python packages:
  - `pandas`
  - `openpyxl`

## Installation

### Install Required Packages

#### For R Version:
```r
install.packages(c("readxl", "tidyverse", "openxlsx"))
```

#### For Python Version:
```bash
pip install -r requirements.txt
# Or install packages individually:
pip install pandas openpyxl
```

### Clone this Repository

```bash
git clone https://github.com/yourusername/grna-cloning-oligo-formatter.git
cd grna-cloning-oligo-formatter
```

## Usage

### 1. Prepare Your Input File

**First**, design your gRNA sequences using your preferred gRNA design tool:
- [CHOPCHOP](http://chopchop.cbu.uib.no/)
- [Benchling CRISPR tool](https://www.benchling.com/)
- [CRISPick (Broad Institute)](https://portals.broadinstitute.org/gppx/crispick/public)
- [GPP sgRNA Designer](https://portals.broadinstitute.org/gpp/public/analysis-tools/sgrna-design)

**Then**, create an Excel file named `oligo_list.xlsx` with the following structure:

| name   | target_seq           |
|--------|---------------------|
| GENE1_1| GATGTGTGTCAAACTCTCGG |
| GENE1_2| GCCGGATGATCAGATCCCAA |
| GENE2_1| ATCGGCTGGACAGATGTCGG |

**Important:** 
- The Excel file must have columns named `name` and `target_seq`
- `target_seq` should contain your **already-designed** 20bp gRNA target sequences (without PAM)
- These sequences should come from a gRNA design tool, not random sequences
- Place this file in the same directory as the script

### 2. Run the Tool

#### Option A: Using R Script (Recommended for R users)

```bash
Rscript design_oligos.R
```

#### Option B: Using Python Script (Recommended for Python users)

```bash
python design_oligos.py
```

#### Option C: Using R Markdown

Open `guide_design_tool.Rmd` in RStudio and knit the document, or run:

```bash
R -e "rmarkdown::render('guide_design_tool.Rmd')"
```

### 3. Output

The tool generates `ready_to_order.xlsx` with the following format:

| oligo_name        | sequence                    |
|-------------------|----------------------------|
| GENE1_1-forward   | caccgTATGTGTGTCAAACTCTCGG    |
| GENE1_1-reverse   | aaacCCGAGAGTTTGACACACATAc    |

You can directly order these sequences from your oligo synthesis provider.

## How It Works

### Overhang Design Rules

The tool adds specific overhangs based on whether the gRNA sequence starts with 'G':

**For sequences starting with 'G':**
- Forward oligo: `cacc` + target_seq
- Reverse oligo: `aaac` + reverse_complement(target_seq)

**For sequences NOT starting with 'G':**
- Forward oligo: `caccg` + target_seq
- Reverse oligo: `aaac` + reverse_complement(target_seq) + `c`

These overhangs are designed to be compatible with BsmBI-digested lentiGuide-puro vector.

### Processing Steps

1. Reads input Excel file containing gRNA names and target sequences
2. Generates reverse complement of each target sequence
3. Adds appropriate 5' overhangs based on first nucleotide
4. Formats output for oligo ordering
5. Saves to Excel file

## Example

**Input:**
```
name: PFKP_1
target_seq: GATGTGTGTCAAACTCTCGG
```

**Output:**
```
PFKP_1-forward_oligo:  caccGATGTGTGTCAAACTCTCGG
PFKP_1-reverse_oligo:  aaacCCGAGAGTTTGACACACATc
```

## Cloning Protocol Notes

1. Anneal forward and reverse oligos to create double-stranded insert
2. Digest lentiGuide-puro with BsmBI
3. Ligate annealed oligos into digested vector
4. Transform into competent cells

## File Descriptions

- `design_oligos.R` - Main R script for batch processing
- `design_oligos.py` - Python version of the tool
- `guide_design_tool.Rmd` - R Markdown notebook with documentation
- `oligo_list.xlsx` - Example input file
- `ready_to_order_example.xlsx` - Example output file
- `requirements.txt` - Python package requirements
- `README.md` - This file
- `USAGE.md` - Detailed usage guide
- `QUICKSTART.md` - Quick start guide

## Troubleshooting

**Error: "cannot open file 'oligo_list.xlsx'"**
- Ensure your input file is named exactly `oligo_list.xlsx`
- Check that the file is in the same directory as the script

**Error: Package installation issues**
- Try installing packages individually
- Make sure you have write permissions for your R library

**Unexpected output sequences**
- Verify that your input sequences are 20bp long
- Check that sequences contain only A, T, G, C nucleotides
- Ensure the first sheet of your Excel file contains the data

## Citation

If you use this tool in your research, please cite:

```
Ozcan, S. C. (2023). gRNA Cloning Oligo Formatter. 
GitHub: https://github.com/cozcan89/gRNA-oligo-list-formatter
```

## License

MIT License - See LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Contact

For questions or issues, please open an issue on GitHub or contact [your-email@example.com]

## Acknowledgments

This tool was developed to streamline the process of formatting pre-designed gRNA sequences into cloning-ready oligonucleotides for CRISPR experiments.

**For gRNA design**, we recommend:
- CHOPCHOP - http://chopchop.cbu.uib.no/
- Benchling CRISPR - https://www.benchling.com/
- Broad Institute GPP tools - https://portals.broadinstitute.org/gpp/public/

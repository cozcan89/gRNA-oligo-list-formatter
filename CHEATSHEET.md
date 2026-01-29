# Quick Reference Cheatsheet

## About This Tool

**What it does:** Formats pre-designed gRNA sequences into cloning-ready oligos  
**What it does NOT do:** Design gRNAs (use CHOPCHOP, Benchling, or CRISPick for that)

## Installation

### R
```r
install.packages(c("readxl", "tidyverse", "openxlsx"))
```

### Python
```bash
pip install pandas openpyxl
```

## Usage

### R Script
```bash
# Basic
Rscript design_oligos.R

# Custom files
Rscript design_oligos.R my_input.xlsx my_output.xlsx
```

### Python Script
```bash
# Basic
python design_oligos.py

# Custom files
python design_oligos.py my_input.xlsx my_output.xlsx
```

### R Markdown
```bash
R -e "rmarkdown::render('guide_design_tool.Rmd')"
```

## Input Format

**Required columns in Excel file:**

| name | target_seq |
|------|------------|
| GENE_1 | 20bp pre-designed sequence |

- Exactly **20bp** (no PAM)
- Only **A, T, G, C**
- Column names: **name** and **target_seq**
- Sequences must be **pre-designed** using gRNA design tools

## Output Format

| oligo_name | sequence |
|------------|----------|
| GENE_1-forward | cacc[g]SEQUENCE |
| GENE_1-reverse | aaacREVCOMP[c] |

## Overhang Rules

**Sequence starts with G:**
- Forward: `cacc` + sequence
- Reverse: `aaac` + revcomp

**Sequence does NOT start with G:**
- Forward: `caccg` + sequence  
- Reverse: `aaac` + revcomp + `c`

## File Structure

```
oligo_list.xlsx          # Your input
design_oligos.R/.py      # Run this
ready_to_order.xlsx      # Your output
```

## Common Commands

```bash
# Setup
bash setup.sh

# Test
Rscript test_tool.R

# R version
Rscript design_oligos.R

# Python version
python design_oligos.py
```

## Troubleshooting

**Can't find file:**
```bash
# Check you're in the right directory
ls oligo_list.xlsx
```

**Package errors (R):**
```r
install.packages("packagename", dependencies=TRUE)
```

**Package errors (Python):**
```bash
pip install --upgrade packagename
```

## Cloning Quick Steps

1. **Anneal oligos**
   - Mix forward + reverse (1:1)
   - 95°C → 25°C slowly

2. **Digest vector**
   - BsmBI digest lentiGuide-puro
   - Gel purify

3. **Ligate**
   - Vector + annealed oligos
   - T4 ligase, RT 1hr

4. **Transform**
   - Competent cells
   - Sequence verify with U6 primer

## Primer for Sequencing
```
U6 Forward: GAGGGCCTATTTCCCATGAT
```

## Links

- README: Full documentation
- USAGE: Detailed protocols  
- QUICKSTART: 5-min guide
- GitHub: Report issues

## Example

**Input:**
```
name: MYC_1
target_seq: GCCCAGTGAGGATATCTGGA
```

**Output:**
```
MYC_1-forward:  caccgGCCCAGTGAGGATATCTGGA
MYC_1-reverse:  aaacTCCAGATATCCTCACTGGGCc
```

---
💡 **Tip:** Keep this file handy for quick reference!

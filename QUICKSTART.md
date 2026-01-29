# Quick Start Guide

Get started with the gRNA Cloning Oligo Formatter in 5 minutes!

**Important:** This tool formats pre-designed gRNA sequences. You need to design your gRNAs first using tools like CHOPCHOP, Benchling, or CRISPick.

## Step 1: Install R and Required Packages

### Install R
Download and install R from: https://cran.r-project.org/

### Install Required Packages
Open R or RStudio and run:
```r
install.packages(c("readxl", "tidyverse", "openxlsx"))
```

## Step 2: Download the Tool

### Option A: Clone from GitHub
```bash
git clone https://github.com/yourusername/crispr-grna-oligo-designer.git
cd crispr-grna-oligo-designer
```

### Option B: Download ZIP
1. Click the green "Code" button on GitHub
2. Select "Download ZIP"
3. Extract the files
4. Navigate to the folder in terminal/command prompt

## Step 3: Prepare Your Input File

**First, design your gRNAs** using one of these tools:
- [CHOPCHOP](http://chopchop.cbu.uib.no/)
- [Benchling](https://www.benchling.com/)
- [CRISPick](https://portals.broadinstitute.org/gppx/crispick/public)

Then create `oligo_list.xlsx` with two columns:

| name | target_seq |
|------|------------|
| MYC_1 | GCCCAGTGAGGATATCTGGA |
| MYC_2 | GTCCGAGCTAAAAGTCAGAG |

**Important:**
- Column names must be exactly `name` and `target_seq`
- Target sequences should be **pre-designed** using a gRNA design tool
- Sequences must be 20bp (no PAM)
- Use only A, T, G, C nucleotides

## Step 4: Run the Tool

### Windows
```cmd
Rscript design_oligos.R
```

### Mac/Linux
```bash
Rscript design_oligos.R
```

### Using RStudio
1. Open `design_oligos.R`
2. Click "Source" button

## Step 5: Get Your Oligos

Open `ready_to_order.xlsx` - it contains your ready-to-order sequences!

Example output:
```
oligo_name          sequence
MYC_1-forward      caccgGCCCAGTGAGGATATCTGGA
MYC_1-reverse      aaacTCCAGATATCCTCACTGGGCc
MYC_2-forward      caccgGTCCGAGCTAAAAGTCAGAG
MYC_2-reverse      aaacCTCTGACTTTTAGCTCGGACc
```

## Step 6: Order and Clone

1. **Order oligos** - Send the sequences to your oligo provider
2. **Anneal** - Mix forward and reverse at equimolar ratio, heat to 95°C, cool slowly
3. **Ligate** - Ligate into BsmBI-digested lentiGuide-puro
4. **Transform** - Transform into competent cells
5. **Verify** - Sequence-verify your clones

## Need Help?

- Check `USAGE.md` for detailed instructions
- See `README.md` for more information
- Open an issue on GitHub

## Pro Tips

✓ Use HPLC-purified oligos for best results  
✓ Process multiple guides at once to save time  
✓ Always sequence-verify your final constructs  
✓ Keep a record of your input and output files  

That's it! You're ready to format your pre-designed gRNA sequences into cloning-ready oligos!

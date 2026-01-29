# Usage Guide

## Important Note

**This tool formats pre-designed gRNA sequences - it does NOT design gRNAs.**

Before using this tool, design your gRNA sequences using:
- **CHOPCHOP**: http://chopchop.cbu.uib.no/
- **Benchling CRISPR**: https://www.benchling.com/
- **CRISPick (Broad)**: https://portals.broadinstitute.org/gppx/crispick/public
- **GPP sgRNA Designer**: https://portals.broadinstitute.org/gpp/public/analysis-tools/sgrna-design

This tool then adds the correct cloning overhangs to your sequences.

## Quick Start

1. **Prepare your input file** (`oligo_list.xlsx`)
2. **Run the script**: `Rscript design_oligos.R`
3. **Get your output** (`ready_to_order.xlsx`)

## Detailed Usage

### Input File Format

Create an Excel file with these columns:

| Column Name | Description | Example |
|-------------|-------------|---------|
| name | Guide identifier | GENE1_1 |
| target_seq | 20bp gRNA sequence (pre-designed) | GATGTGTGTCAAACTCTCGG |

**Important Notes:**
- Target sequences should be **already designed and validated** using a gRNA design tool
- Target sequences should be 20 nucleotides long
- Do NOT include the PAM sequence (NGG)
- Use only A, T, G, C nucleotides
- The file should be named `oligo_list.xlsx`

### Running the Tool

#### Method 1: Command Line (Recommended)

Basic usage with default filenames:
```bash
Rscript design_oligos.R
```

Custom input file:
```bash
Rscript design_oligos.R my_guides.xlsx
```

Custom input and output files:
```bash
Rscript design_oligos.R my_guides.xlsx my_output.xlsx
```

#### Method 2: R Console

```r
source("design_oligos.R")
design_oligos()

# Or with custom filenames
design_oligos(input_file = "my_guides.xlsx", output_file = "my_output.xlsx")
```

#### Method 3: R Markdown

```bash
# Generate HTML report
R -e "rmarkdown::render('guide_design_tool.Rmd')"

# Or open in RStudio and click "Knit"
```

### Understanding the Output

The output file contains oligo pairs ready for ordering:

```
oligo_name              sequence
GENE1_1-forward_oligo   caccGATGTGTGTCAAACTCTCGG
GENE1_1-reverse_oligo   aaacCCGAGAGTTTGACACACATc
```

**Key Points:**
- Each guide generates TWO oligos (forward and reverse)
- Oligos are already formatted with appropriate overhangs
- Order both oligos for each guide
- Sequences are ready to order "as-is" - no modifications needed

## Overhang Design Logic

### For sequences starting with 'G':

**Example: GATGTGTGTCAAACTCTCGG**

```
Forward: cacc + GATGTGTGTCAAACTCTCGG
         = caccGATGTGTGTCAAACTCTCGG

Reverse: aaac + CCGAGAGTTTGACACACAT (reverse complement)
         = aaacCCGAGAGTTTGACACACATc
```

### For sequences NOT starting with 'G':

**Example: ATCGGCTGGACAGATGTCGG**

```
Forward: caccg + ATCGGCTGGACAGATGTCGG
         = caccgATCGGCTGGACAGATGTCGG

Reverse: aaac + CCGACATCTGTCCAGCCGAT + c
         = aaacCCGACATCTGTCCAGCCGATc
```

**Why the difference?**
The U6 promoter in lentiGuide-puro initiates transcription at the first G. If your sequence doesn't start with G, we add one to ensure proper transcription.

## Cloning Protocol

### 1. Oligo Annealing

Materials needed:
- Forward oligo (100 μM stock)
- Reverse oligo (100 μM stock)
- 10X T4 Ligation Buffer
- Nuclease-free water

Protocol:
```
1. Mix in PCR tube:
   - 1 μL forward oligo (100 μM)
   - 1 μL reverse oligo (100 μM)
   - 1 μL 10X T4 Ligation Buffer
   - 7 μL nuclease-free water
   (Final: 10 μM duplex)

2. Anneal in thermocycler:
   - 95°C for 5 min
   - Ramp down to 25°C at 5°C/min
   - Hold at 4°C

3. Dilute annealed oligos 1:200 in water (50 nM working stock)
```

### 2. Vector Preparation

```
1. Digest 1 μg lentiGuide-puro with BsmBI:
   - 1 μg plasmid
   - 1 μL BsmBI (10 U/μL)
   - 2 μL 10X buffer
   - Water to 20 μL
   - Incubate 37°C for 1-2 hours

2. Gel purify or column purify digested vector

3. Optional: Treat with calf intestinal phosphatase (CIP)
```

### 3. Ligation

```
1. Set up ligation:
   - 50 ng BsmBI-digested vector
   - 1 μL annealed oligos (50 nM)
   - 1 μL T4 DNA Ligase (400 U/μL)
   - 2 μL 10X T4 Ligation Buffer
   - Water to 20 μL

2. Ligate at room temperature for 1 hour
   (or 16°C overnight)

3. Transform 2-5 μL into competent cells
```

### 4. Verification

- Pick colonies and perform colony PCR or miniprep
- Sequence with U6 forward primer: `GAGGGCCTATTTCCCATGAT`

## Troubleshooting

### Problem: Script can't find input file

**Solution:**
- Ensure `oligo_list.xlsx` is in the same directory as the script
- Check the filename spelling exactly
- Verify you're running the script from the correct directory

### Problem: Package installation fails

**Solution:**
```r
# Install packages one at a time
install.packages("readxl")
install.packages("tidyverse")
install.packages("openxlsx")

# If still failing, try with dependencies
install.packages("readxl", dependencies = TRUE)
```

### Problem: Error reading Excel file

**Solution:**
- Verify your Excel file has the correct column names: `name` and `target_seq`
- Check that you're using a valid Excel format (.xlsx)
- Try opening and re-saving the file in Excel

### Problem: Unexpected sequences in output

**Solution:**
- Verify input sequences are exactly 20bp
- Check for spaces or special characters in sequences
- Ensure sequences contain only A, T, G, C

### Problem: Low cloning efficiency

**Possible causes:**
- Incomplete vector digestion - digest longer or use fresh enzyme
- Oligos not properly annealed - verify annealing protocol
- Old or degraded oligos - order fresh oligos
- Vector not dephosphorylated - try adding CIP treatment

## Tips for Success

1. **Quality Control**: Always sequence-verify your constructs
2. **Oligo Quality**: Use HPLC or PAGE-purified oligos for best results
3. **Batch Processing**: Process multiple guides at once to save time
4. **Keep Records**: Save input and output files for future reference
5. **Positive Control**: Include a known-working guide in your cloning

## Example Workflow

```bash
# 1. Prepare your guide list
# Create oligo_list.xlsx with your target sequences

# 2. Run the design tool
Rscript design_oligos.R

# 3. Review output
# Open ready_to_order.xlsx

# 4. Order oligos from your preferred vendor
# Submit the sequences from ready_to_order.xlsx

# 5. When oligos arrive, proceed with cloning
# Follow the annealing and ligation protocol above
```

## Frequently Asked Questions

**Q: What if my sequence already starts with 'G'?**  
A: The tool handles this automatically - it will use the standard overhang without adding an extra G.

**Q: Can I use this for other vectors?**  
A: The overhangs are specific to lentiGuide-puro with BsmBI. For other vectors, you'll need to modify the overhang sequences in the script.

**Q: What's the purpose of the 'c' at the end of reverse oligos?**  
A: This ensures proper overhang compatibility when sequences don't start with G.

**Q: Do I need to order separate purification for the oligos?**  
A: Standard desalting is usually sufficient, but HPLC purification may improve cloning efficiency.

**Q: How many oligos can I process at once?**  
A: There's no hard limit - the tool can handle hundreds of sequences in a single run.

## Getting Help

If you encounter issues:
1. Check this usage guide
2. Review the troubleshooting section
3. Check existing GitHub issues
4. Open a new issue with details about your problem

## Additional Resources

- [Addgene: Guide to Using CRISPR](https://www.addgene.org/crispr/guide/)
- [lentiGuide-puro on Addgene](https://www.addgene.org/52963/)
- [CRISPR Design Tools](http://crispr.mit.edu/)

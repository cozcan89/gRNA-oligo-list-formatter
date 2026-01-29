# Documentation Index

Welcome to the gRNA Cloning Oligo Formatter documentation!

**What this tool does:** Formats your pre-designed gRNA sequences into cloning-ready oligonucleotides  
**What this tool does NOT do:** Design gRNAs (use CHOPCHOP, Benchling, or CRISPick for that)

## Quick Navigation

### 📚 Getting Started
- [README.md](README.md) - Main documentation and overview
- [QUICKSTART.md](QUICKSTART.md) - Get started in 5 minutes
- [setup.sh](setup.sh) - Automated setup script

### 📖 Usage Guides
- [USAGE.md](USAGE.md) - Detailed usage instructions with protocols
- [DIAGRAMS.md](DIAGRAMS.md) - Visual workflow diagrams

### 🔧 Tool Files
- [design_oligos.R](design_oligos.R) - R version (recommended for R users)
- [design_oligos.py](design_oligos.py) - Python version (recommended for Python users)
- [guide_design_tool.Rmd](guide_design_tool.Rmd) - R Markdown notebook version

### 📂 Example Files
- [oligo_list.xlsx](oligo_list.xlsx) - Example input file
- [ready_to_order_example.xlsx](ready_to_order_example.xlsx) - Example output file

### 🧪 Testing
- [test_tool.R](test_tool.R) - Automated test script

### 🤝 Contributing
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute
- [CHANGELOG.md](CHANGELOG.md) - Version history
- [LICENSE](LICENSE) - MIT License

### ⚙️ Configuration
- [requirements.txt](requirements.txt) - Python dependencies
- [.gitignore](.gitignore) - Git ignore rules

## Documentation by Topic

### Installation & Setup
1. Read [README.md](README.md) - Requirements section
2. Run [setup.sh](setup.sh) - Automated setup (Linux/Mac)
3. Or follow [QUICKSTART.md](QUICKSTART.md) for manual setup

### Basic Usage
1. Start with [QUICKSTART.md](QUICKSTART.md)
2. See [USAGE.md](USAGE.md) for examples
3. Check [DIAGRAMS.md](DIAGRAMS.md) for visual understanding

### Advanced Topics
1. [USAGE.md](USAGE.md) - Cloning protocols
2. [USAGE.md](USAGE.md) - Troubleshooting guide
3. [guide_design_tool.Rmd](guide_design_tool.Rmd) - Interactive analysis

### Development
1. [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
2. [test_tool.R](test_tool.R) - Testing procedures
3. [CHANGELOG.md](CHANGELOG.md) - Version history

## Choosing Your Version

### Use R Version If You:
- Are familiar with R/RStudio
- Want to use the R Markdown notebook
- Need integration with other R workflows
- Prefer the tidyverse ecosystem

**Files:** `design_oligos.R`, `guide_design_tool.Rmd`

### Use Python Version If You:
- Are familiar with Python
- Want lighter dependencies
- Need integration with Python workflows
- Prefer pandas for data manipulation

**File:** `design_oligos.py`

Both versions produce identical output!

## Common Workflows

### First-Time User
```
1. README.md (overview)
2. QUICKSTART.md (setup and first run)
3. USAGE.md (detailed instructions)
```

### Experienced User
```
1. Edit oligo_list.xlsx
2. Run: Rscript design_oligos.R
3. Order from ready_to_order.xlsx
```

### Troubleshooting
```
1. USAGE.md (troubleshooting section)
2. Open GitHub issue
3. Check existing issues
```

## File Organization

```
grna-cloning-oligo-formatter/
├── README.md                      # Main documentation
├── QUICKSTART.md                  # Quick start guide
├── USAGE.md                       # Detailed usage guide
├── DIAGRAMS.md                    # Visual diagrams
├── CONTRIBUTING.md                # Contributing guidelines
├── CHANGELOG.md                   # Version history
├── LICENSE                        # MIT License
│
├── design_oligos.R                # R script
├── design_oligos.py               # Python script
├── guide_design_tool.Rmd          # R Markdown
│
├── setup.sh                       # Setup script
├── test_tool.R                    # Test script
├── requirements.txt               # Python deps
│
├── oligo_list.xlsx                # Example input
└── ready_to_order_example.xlsx    # Example output
```

## Support & Help

- **Bug Reports:** Open an issue on GitHub
- **Questions:** Check USAGE.md or open an issue
- **Feature Requests:** Open an issue with enhancement tag
- **Contributing:** See CONTRIBUTING.md

## Quick Reference

### R Version
```bash
Rscript design_oligos.R [input.xlsx] [output.xlsx]
```

### Python Version
```bash
python design_oligos.py [input.xlsx] [output.xlsx]
```

### Test
```bash
Rscript test_tool.R
```

### Setup
```bash
bash setup.sh
```

---

**Tip:** Start with [QUICKSTART.md](QUICKSTART.md) if you're new, or jump straight to running the tool if you're experienced!

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-28

### Added
- Initial public release
- Renamed to "gRNA Cloning Oligo Formatter" to clarify tool purpose
- Standalone R script (`design_oligos.R`) for command-line usage
- Python version (`design_oligos.py`) for Python users
- R Markdown notebook (`guide_design_tool.Rmd`) for interactive analysis
- Comprehensive documentation emphasizing this tool formats pre-designed gRNAs
- Links to gRNA design tools (CHOPCHOP, Benchling, CRISPick)
- Detailed USAGE.md guide with cloning protocols
- Example input and output files
- Test script (`test_tool.R`) for validation
- MIT License
- Contributing guidelines
- .gitignore for R/Python projects

### Features
- Automatic overhang design for BsmBI-based cloning into lentiGuide-puro
- Support for sequences starting with or without 'G'
- Batch processing of multiple pre-designed guide sequences
- Excel input/output format
- Detailed console output with statistics
- Error handling and validation

### Documentation
- Clear messaging that tool formats pre-designed gRNAs, does not design them
- References to popular gRNA design tools for users
- Comprehensive usage examples

## [0.1.0] - 2023-07-09

### Initial Development
- Basic R Markdown script for oligo design
- Core functionality for reverse complement generation
- Overhang addition logic
- Excel file processing

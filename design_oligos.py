#!/usr/bin/env python3
"""
gRNA Cloning Oligo Formatter - Python Version
Formats pre-designed gRNA sequences into cloning-ready oligonucleotides
with appropriate overhangs for BsmBI-based cloning into lentiGuide-puro

NOTE: This tool does NOT design gRNAs. Use gRNA design tools like
CHOPCHOP, Benchling, or CRISPick to design your target sequences first.

Author: Can Ozcan
Date: 2023-07-09
Python Port: 2026-01-28
"""

import pandas as pd
import sys
from pathlib import Path


def reverse_complement(seq):
    """Generate reverse complement of DNA sequence"""
    complement = {'A': 'T', 'T': 'A', 'G': 'C', 'C': 'G'}
    return ''.join(complement.get(base, base) for base in reversed(seq))


def design_oligos(input_file='oligo_list.xlsx', output_file='ready_to_order.xlsx'):
    """
    Main function to design CRISPR gRNA oligos
    
    Parameters:
    -----------
    input_file : str
        Path to input Excel file with columns 'name' and 'target_seq'
    output_file : str
        Path to output Excel file
    """
    
    print("=" * 50)
    print("gRNA Cloning Oligo Formatter - Python Version")
    print("=" * 50)
    print()
    
    # Define overhangs
    forw_overhang = "cacc"
    forw_overhang_g = "caccg"
    rev_overhang = "aaac"
    rev_overhang_2 = "c"
    
    # Check if input file exists
    if not Path(input_file).exists():
        print(f"Error: Input file '{input_file}' not found!")
        sys.exit(1)
    
    print(f"Reading input file: {input_file}")
    
    # Read input file
    try:
        df = pd.read_excel(input_file)
    except Exception as e:
        print(f"Error reading file: {e}")
        sys.exit(1)
    
    # Validate columns
    if 'name' not in df.columns or 'target_seq' not in df.columns:
        print("Error: Input file must contain 'name' and 'target_seq' columns")
        sys.exit(1)
    
    print(f"Processing {len(df)} guide sequences...")
    print()
    
    # Process sequences
    results = []
    
    for idx, row in df.iterrows():
        name = row['name']
        target_seq = row['target_seq'].upper()
        
        # Generate reverse complement
        rev_comp = reverse_complement(target_seq)
        
        # Design forward oligo
        if target_seq.startswith('G'):
            forward_oligo = forw_overhang + target_seq
            reverse_oligo = rev_overhang + rev_comp
        else:
            forward_oligo = forw_overhang_g + target_seq
            reverse_oligo = rev_overhang + rev_comp + rev_overhang_2
        
        # Add to results
        results.append({
            'oligo_name': f"{name}-forward_oligo",
            'sequence': forward_oligo
        })
        results.append({
            'oligo_name': f"{name}-reverse_oligo",
            'sequence': reverse_oligo
        })
    
    # Create output dataframe
    output_df = pd.DataFrame(results)
    
    # Clean oligo names (remove _oligo suffix for cleaner names)
    output_df['oligo_name'] = output_df['oligo_name'].str.replace('_oligo', '')
    
    # Write output
    print(f"Writing output to: {output_file}")
    output_df.to_excel(output_file, index=False)
    
    # Print summary
    print()
    print("=" * 50)
    print("Processing complete!")
    print("=" * 50)
    print()
    print("Summary:")
    print(f"- Input sequences: {len(df)}")
    print(f"- Output oligos: {len(output_df)}")
    
    # Count sequences by starting nucleotide
    starts_with_g = df['target_seq'].str.upper().str.startswith('G').sum()
    print(f"- Sequences starting with G: {starts_with_g}")
    print(f"- Sequences NOT starting with G: {len(df) - starts_with_g}")
    
    print()
    print("Output file saved successfully!")
    print(f"File location: {Path(output_file).absolute()}")
    
    # Preview
    print()
    print("First 3 oligo pairs:")
    print(output_df.head(6).to_string(index=False))
    
    return output_df


def main():
    """Command line interface"""
    if len(sys.argv) == 1:
        # Use default filenames
        design_oligos()
    elif len(sys.argv) == 2:
        # Input file specified
        design_oligos(input_file=sys.argv[1])
    elif len(sys.argv) >= 3:
        # Input and output files specified
        design_oligos(input_file=sys.argv[1], output_file=sys.argv[2])
    else:
        print("Usage: python design_oligos.py [input_file] [output_file]")
        sys.exit(1)


if __name__ == "__main__":
    main()

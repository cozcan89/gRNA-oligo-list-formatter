#!/bin/bash

# Setup script for gRNA Cloning Oligo Formatter
# This script checks for dependencies and helps set up the environment

echo "========================================"
echo "gRNA Cloning Oligo Formatter - Setup"
echo "========================================"
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for R
echo "Checking for R..."
if command_exists Rscript; then
    R_VERSION=$(Rscript --version 2>&1 | head -n 1)
    echo "✓ R is installed: $R_VERSION"
    
    # Check R packages
    echo ""
    echo "Checking R packages..."
    Rscript -e "
    required <- c('readxl', 'tidyverse', 'openxlsx')
    installed <- installed.packages()[,'Package']
    missing <- required[!required %in% installed]
    
    if (length(missing) > 0) {
        cat('Missing R packages:', paste(missing, collapse=', '), '\n')
        cat('Installing missing packages...\n')
        install.packages(missing, repos='https://cloud.r-project.org/')
        cat('✓ R packages installed successfully\n')
    } else {
        cat('✓ All required R packages are installed\n')
    }
    "
else
    echo "✗ R is not installed"
    echo "  Please install R from: https://cran.r-project.org/"
fi

echo ""

# Check for Python
echo "Checking for Python..."
if command_exists python3; then
    PYTHON_VERSION=$(python3 --version)
    echo "✓ Python is installed: $PYTHON_VERSION"
    
    # Check Python packages
    echo ""
    echo "Checking Python packages..."
    
    if command_exists pip3; then
        echo "Installing Python requirements..."
        pip3 install -r requirements.txt --quiet
        echo "✓ Python packages installed successfully"
    else
        echo "✗ pip3 is not installed"
        echo "  Please install pip3 to use the Python version"
    fi
elif command_exists python; then
    PYTHON_VERSION=$(python --version)
    echo "✓ Python is installed: $PYTHON_VERSION"
    
    if command_exists pip; then
        echo "Installing Python requirements..."
        pip install -r requirements.txt --quiet
        echo "✓ Python packages installed successfully"
    else
        echo "✗ pip is not installed"
        echo "  Please install pip to use the Python version"
    fi
else
    echo "✗ Python is not installed"
    echo "  Please install Python from: https://www.python.org/"
fi

echo ""
echo "========================================"
echo "Setup Summary"
echo "========================================"
echo ""

# Create a summary
if command_exists Rscript; then
    echo "R Version: READY ✓"
    echo "  Run with: Rscript design_oligos.R"
else
    echo "R Version: NOT AVAILABLE"
fi

echo ""

if command_exists python3 || command_exists python; then
    echo "Python Version: READY ✓"
    echo "  Run with: python design_oligos.py"
else
    echo "Python Version: NOT AVAILABLE"
fi

echo ""
echo "Example files:"
echo "  Input: oligo_list.xlsx"
echo "  Output: ready_to_order.xlsx"
echo ""

echo "Next steps:"
echo "1. Edit oligo_list.xlsx with your guide sequences"
echo "2. Run the tool (R or Python version)"
echo "3. Order oligos from ready_to_order.xlsx"
echo ""

echo "For more help:"
echo "  - See README.md for full documentation"
echo "  - See QUICKSTART.md for quick start guide"
echo "  - See USAGE.md for detailed usage"
echo ""

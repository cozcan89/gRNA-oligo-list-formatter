# ⚠️ Important: What This Tool Does and Does NOT Do

## ✅ What This Tool DOES:

This tool **formats pre-designed gRNA sequences** into cloning-ready oligonucleotides:

1. Takes your **already-designed** 20bp gRNA target sequences
2. Generates reverse complement sequences
3. Adds appropriate BsmBI-compatible overhangs (cacc/caccg and aaac)
4. Outputs ready-to-order sense and antisense oligo pairs in Excel format

## ❌ What This Tool Does NOT Do:

This tool **does NOT**:

- ❌ Design gRNA sequences for you
- ❌ Find target sites in your gene of interest
- ❌ Predict on-target or off-target effects
- ❌ Score or rank gRNA sequences
- ❌ Check for PAM sequences
- ❌ Validate gRNA quality or specificity

## 🧬 Where to Design Your gRNAs

**Before using this tool**, design your gRNA sequences using one of these tools:

### Recommended gRNA Design Tools:

1. **CHOPCHOP** (Free, web-based)
   - URL: http://chopchop.cbu.uib.no/
   - Features: Multiple organisms, off-target prediction, batch mode
   
2. **Benchling CRISPR** (Free for academics)
   - URL: https://www.benchling.com/
   - Features: Integrated design suite, off-target analysis
   
3. **CRISPick** (Broad Institute)
   - URL: https://portals.broadinstitute.org/gppx/crispick/public
   - Features: High-quality scoring, extensive validation
   
4. **GPP sgRNA Designer** (Broad Institute)
   - URL: https://portals.broadinstitute.org/gpp/public/analysis-tools/sgrna-design
   - Features: Published algorithm, well-validated

5. **CRISPOR** (Free, web-based)
   - URL: http://crispor.tefor.net/
   - Features: Many organisms, extensive off-target analysis

6. **IDT CRISPR Design Tool** (Free)
   - URL: https://www.idtdna.com/site/order/designtool/index/CRISPR_CUSTOM
   - Features: Integrated with oligo ordering

## 📋 Typical Workflow:

```
Step 1: Design gRNAs
        ↓ (Use CHOPCHOP, Benchling, etc.)
        
Step 2: Select best gRNA sequences
        ↓ (Based on scores, off-targets, etc.)
        
Step 3: Format for cloning
        ↓ (Use THIS tool)
        
Step 4: Order oligos
        ↓ (From IDT, Sigma, etc.)
        
Step 5: Clone and validate
```

## 🎯 When to Use This Tool:

Use this tool **only after** you have:

- ✅ Selected your target gene/region
- ✅ Designed gRNA sequences using a design tool
- ✅ Validated gRNA quality (on-target score, off-target effects)
- ✅ Selected your final gRNA sequence(s)
- ✅ Have 20bp sequences ready to format for cloning

## 💡 Example:

**WRONG workflow:**
```
❌ "I want to knock out TP53" 
   → Use this tool
```

**CORRECT workflow:**
```
✅ "I want to knock out TP53" 
   → Design gRNAs using CHOPCHOP
   → Select best sequence: GATGGGATTGGGGTTTTCCC
   → Use this tool to format with overhangs
   → Order oligos: caccGATGGGATTGGGGTTTTCCC and aaacGGGAAAACCCCAATCCCATc
```

## 📚 Further Reading:

- **gRNA Design Best Practices**: https://www.addgene.org/crispr/guide/
- **CRISPR Design Considerations**: https://www.nature.com/articles/nmeth.3543
- **Off-target Effects**: https://www.nature.com/articles/nbt.2647

---

**Remember:** Good CRISPR experiments start with good gRNA design. This tool helps you format your designs for cloning, but cannot replace the design step!

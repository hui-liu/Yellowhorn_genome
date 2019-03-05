# Counting heterozygous genotypes per sample in a VCF file
# HET_SNPs/Total_SNPs
import cyvcf2
import numpy as np
import sys

vcf = cyvcf2.VCF(sys.argv[1])
HET_SNPs = np.zeros(len(vcf.samples), dtype = int)
sample_SNPs = np.zeros(len(vcf.samples), dtype = int)
Total_SNPs_counts = 0

for variant in vcf:
    if variant.is_indel: continue
    Total_SNPs_counts += 1
    # gt_types is array of 0,1,2,3==HOM_REF, HET, UNKNOWN, HOM_ALT
    HET_SNPs[variant.gt_types == 1] += 1
    sample_SNPs[variant.gt_types != 2] += 1

# report
HET_SNPs_counts = {i[0]:i[1] for i in zip(vcf.samples, HET_SNPs)}
sample_SNPs_counts = {i[0]:i[1] for i in zip(vcf.samples, sample_SNPs)}
OUT = open(sys.argv[2], 'w')
OUT.write("sample" + "\t" + "HET_SNPs" + "\t" + "sample_SNPs" + "\t" + "Total_SNPs" + "\t" + "Heterozygosity" + "\n")
for s in vcf.samples:
    OUT.write("\t".join([s, str(HET_SNPs_counts[s]), str(sample_SNPs_counts[s]), str(Total_SNPs_counts), 
              str(round(HET_SNPs_counts[s] / float(Total_SNPs_counts), 2))]) + "\n")

OUT.close()

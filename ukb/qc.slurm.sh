#!/bin/bash
#SBATCH --account=p33_norment
#SBATCH --time=8:00:00
#SBATCH --mem-per-cpu=8GB
#SBATCH --cpus-per-task=32
#SBATCH --array 1-22

source /cluster/bin/jobsetup
module purge

source ${HOME}/.bashrc
source ${HOME}/cluster/bin/activate

CHR=${SLURM_ARRAY_TASK_ID}

QC=/cluster/projects/p33/users/alexeas/ukb/geno
MISC=/cluster/projects/p33/users/alexeas/ukb/misc
BGEN=/cluster/projects/p33/groups/imaging/ukbio/genetics/bgen

if true; then
    # Step 1. Conversion from bgen and basic filters

    # Arguments:
    SNP_LIST=${MISC}/snps_info8_chr${CHR}.txt
    SAMPLE_LIST=${MISC}/id_white.txt
    OUT=${QC}/chr${CHR}.white.info8.geno05.hwe10.maf001

    # plink2 applies variant filters after selecting samples with --keep, so --maf and --geno filters are applied to ancestry-specific subsample (see "Order of operations" in plink2)
    plink2 --bgen ${BGEN}/ukb_imp_chr${CHR}_v3.bgen ref-first --sample ${BGEN}/ukb27412_imp_chr${CHR}_v3_s487395.sample \
        --keep ${SAMPLE_LIST} --extract ${SNP_LIST} --geno 0.05 --hwe 1e-10 midp --maf 0.001  \
        --make-pgen --threads 32 --out ${OUT}
fi

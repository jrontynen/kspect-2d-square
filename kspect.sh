#!/bin/sh
#SBATCH --time=0-00:40:00 --mem-per-cpu=800
#SBATCH -o out/jobe1-%a.out
#SBATCH --array=1-200

cp run_kspect.m kspect.m cheval.m Struve* $TMPDIR
rm ./out/oute1-$SLURM_ARRAY_TASK_ID.mat
cd $TMPDIR
mkdir $TMPDIR/out
trap "mv -f $TMPDIR/out/* $WRKDIR/matlab/pr2/out/; exit" TERM EXIT

module load matlab
matlab -nojvm -r "run_kspect($SLURM_ARRAY_TASK_ID,200,200)"
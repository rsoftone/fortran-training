#!/bin/bash
SRCFILE="${1}.f90"
EXENAME="${1}"
MKLVER="2019.3.199"
module load intel-compiler/"${MKLVER}" intel-mkl/"${MKLVER}"
ifort "${SRCFILE}" -i8 -I${MKLROOT}/include/intel64/ilp64 -mkl=parallel ${MKLROOT}/lib/intel64/libmkl_blas95_ilp64.a ${MKLROOT}/lib/intel64/libmkl_lapack95_ilp64.a -liomp5 -lpthread -lm -ldl -o "${EXENAME}" && ./"${EXENAME}"



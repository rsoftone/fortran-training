#!/bin/bash
SRCFILE="${1}.f90"
EXENAME="${1}"
gfortran -o2 -Wall "${SRCFILE}" -o "${EXENAME}" -L/usr/lib -llapack -lblas && ./"${EXENAME}"


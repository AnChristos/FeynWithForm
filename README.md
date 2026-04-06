# FORM Particle Physics

Simple examples of Feynman amplitudes using **FORM 5.0**

## Structure
- `/Notebooks`: Interactive Jupyter environments.
- `/scripts`: Raw FORM 5.0 files generated from notebooks.

## FORM
- Repository https://github.com/form-dev/form
- Releases https://github.com/form-dev/form/releases
- Manual https://form-dev.github.io/form-docs/stable/manual/

## Requirements
- We assume form is available (a command ``form'' exists)
- Python
    - jupyterlab
    - numpy
    - matplotlib 

## Description of pipeline
- We want to be able to run ``form``. Ideally from inside the notebook.
- Assume a notebook ``name.ipynb``
    - We import the utils in the first cell
    - At the start of second cell  we use ``%%pyForm name``.
    We then put the actual ``form`` code in the cell
    - Running the cell we  get a ``name.frm`` and ``name.out`` 
    in the scripts folder.
    - We the use python to get the line with result 
    and do further manipulations.

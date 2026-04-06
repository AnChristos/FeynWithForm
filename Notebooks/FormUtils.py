import os
import subprocess
import re
from IPython.core.magic import register_cell_magic

# Get the current directory 
notebook_dir = os.getcwd()
# Go up one level to the project root and into /scripts
script_dir = os.path.abspath(os.path.join(notebook_dir, '..', 'scripts'))
# Create the director if it doesn't exist
os.makedirs(script_dir, exist_ok=True)


@register_cell_magic
def pyForm(line, cell):
    filename = line.strip() if line else "temp"
    frm_path = os.path.join(script_dir, f"{filename}.frm")
    out_path = os.path.join(script_dir, f"{filename}.out")

    # Save the input script
    with open(frm_path, 'w') as f:
        f.write(cell)

    # Run FORM 
    result = subprocess.run(['form', frm_path], capture_output=True, text=True)

    # Check Return Code (RC) for safety
    if result.returncode != 0:
        error_msg = result.stderr if result.stderr else result.stdout
        print(f"--- FORM ERROR (RC {result.returncode}) ---\n", error_msg)
        return None

    # Save the output to use later
    with open(out_path, 'w') as f:
        f.write(result.stdout)

    print(result.stdout)


def get_form_expr(filename="temp", var_name="dSigma"):
    """
    Reads the .out file from the scripts directory and extracts 
     the expression for the given variable.
    """
    out_path = os.path.join(script_dir, f"{filename}.out")

    if not os.path.exists(out_path):
        print(f"Error: {out_path} not found.")
        return None

    with open(out_path, 'r') as f:
        content = f.read()

    # target the final indented output: var_name = ... ;
    pattern = rf'\n\s+{var_name}\s*=\s*(.*?);'
    # re.DOTALL capture expressions spanning multiple lines
    match = re.search(pattern, content, re.DOTALL)

    if match:
        # Remove newlines and extra spaces for SymPy/Python compatibility
        clean_expr = match.group(1).replace('\n', '').replace(' ', '')
        return clean_expr

    print(f"Error: Could not find variable '{var_name}' in {filename}.out")
    return None


def capture_physics_expr(filename, var_name):
    """
    Retrieves the FORM output and cleans it for Python eval().
    """
    raw_str = get_form_expr(filename, var_name)
    if not raw_str:
        return None
    # Remove newlines and extra spaces
    clean_str = " ".join(raw_str.split())
    # Convert FORM power syntax
    py_expr = clean_str.replace('^', '**')
    return py_expr

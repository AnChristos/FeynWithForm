import os
import subprocess
import re
from IPython.core.magic import register_cell_magic


# Get the directory where the Notebook is currently running
notebook_dir = os.getcwd()
# Point to the scripts folder
script_dir = os.path.join(notebook_dir, "scripts")
# Create the directory if it's missing
if not os.path.exists(script_dir):
    os.makedirs(script_dir)


@register_cell_magic
def pyForm(line, cell):
    """
    Magic to run FORM from a cell.
    Saves and runs scripts within the local 'scripts' subdirectory.
    """
    filename = line.strip() if line else "temp"
    frm_path = os.path.join(script_dir, f"{filename}.frm")

    # Save the input script
    with open(frm_path, "w") as f:
        f.write(cell)

    # Run FORM.
    result = subprocess.run(
        ["form", frm_path], capture_output=True, text=True, cwd=script_dir
    )

    if result.returncode != 0:
        error_msg = result.stderr if result.stderr else result.stdout
        print(f"--- FORM ERROR (RC {result.returncode}) ---\n", error_msg)
        return None

    print(result.stdout)


def capture_physics_expr(filename="tmp.txt"):
    """
    Read saved FORM output and return it.
    """
    try:
        with open(filename, "r") as f:
            content = f.read()
            content = content.replace("\n", "").replace(" ", "")

            content = content.replace(";_+=", "+")
            content = content.replace("++", "+").replace("+-", "-").replace("-+", "-")
            content = content.rstrip(";")
            return content

    except FileNotFoundError:
        print(f"Error: {filename} not found.")
        return None

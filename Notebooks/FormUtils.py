import os
import subprocess
from IPython.core.magic import register_cell_magic

# Setup Path Logic (Relative to the Notebooks folder)
# Project root is one level up
notebook_dir = os.getcwd()
project_root = os.path.abspath(os.path.join(notebook_dir, ".."))

# 2. Define Directories
script_dir = os.path.join(project_root, "Scripts")
result_dir = os.path.join(project_root, "Results")

# Define the library folders FORM should search in.
search_paths = [
    os.path.join(project_root, "FullTraceLib"),
]

# 3. Create missing directories automatically
for folder in [script_dir, result_dir] + search_paths:
    if not os.path.exists(folder):
        os.makedirs(folder)

@register_cell_magic
def pyForm(line, cell):
    """
    Jupyter Magic to run FORM scripts.
    Usage: 
    %%pyForm FileName
    """
    filename = line.strip() if line else "temp"
    frm_path = os.path.join(script_dir, f"{filename}.frm")

    # Save the Jupyter cell content to a .frm file in /Scripts
    with open(frm_path, "w") as f:
        f.write(cell)

    # Construct the FORM command with -p flags for all search paths
    form_cmd = ["form"]
    for path in search_paths:
        form_cmd.extend(["-p", path])
    
    # Add the path to the script itself
    form_cmd.append(frm_path)

    # Execute FORM inside the Scripts directory
    result = subprocess.run(
        form_cmd, 
        capture_output=True, 
        text=True, 
        cwd=script_dir
    )

    # Handle the output
    if result.returncode != 0:
        error_msg = result.stderr if result.stderr else result.stdout
        print(f"--- FORM ERROR (Return Code {result.returncode}) ---\n", error_msg)
    else:
        print(result.stdout)

def capture_physics_expr(filename="tmp.txt"):
    """
    Reads a text file from /Scripts and cleans the FORM output.
    """
    file_path = os.path.join(result_dir, filename)
    try:
        with open(file_path, "r") as f:
            content = f.read()
            # Standard cleaning logic
            content = content.replace("\n", "").replace(" ", "")
            content = content.replace(";_+=", "+").replace("++", "+")
            content = content.replace("+-", "-").replace("-+", "-")
            return content.rstrip(";")
    except FileNotFoundError:
        print(f"Error: {file_path} not found. Ensure your FORM script saves to this name.")
        return None
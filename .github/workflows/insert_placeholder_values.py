try:
    import subprocess

    version = (
        subprocess.check_output(["git", "describe", "--abbrev=0", "--tags"])
        .strip()
        .decode("utf-8")
    )
except Exception as e:
    print("Could not get version tag. Defaulting to version 0")
    version = "0"

# Write the version file
with open("pdb2pqr/_version.py", "w") as f:
    f.write(f'__version__ = "{version}"\n')

#!/usr/bin/env python3
"""
Script to generate raw GitHub links for all resource files.
"""
import os
import glob
from pathlib import Path

# GitHub repository info
GITHUB_USER = "LithStudios"
GITHUB_REPO = "ls_configs"
GITHUB_BRANCH = "master"  # Default branch
BASE_RAW_URL = f"https://raw.githubusercontent.com/{GITHUB_USER}/{GITHUB_REPO}/{GITHUB_BRANCH}"

def get_all_resources():
    """Get all resource directories (ls_* folders)."""
    resources = sorted([d for d in glob.glob("ls_*") if os.path.isdir(d)])
    return resources

def get_resource_files(resource_dir):
    """Get all files for a resource including config and editable files."""
    files = []
    
    # Check for config.lua
    config_file = os.path.join(resource_dir, "config.lua")
    if os.path.exists(config_file):
        files.append(config_file)
    
    # Check for client directory
    client_dir = os.path.join(resource_dir, "client")
    if os.path.exists(client_dir):
        # Check for files directly in client/
        for filename in sorted(os.listdir(client_dir)):
            filepath = os.path.join(client_dir, filename)
            if os.path.isfile(filepath):
                files.append(filepath)
        
        # Check for client editables (both "editable" and "editables")
        for dirname in ["editable", "editables"]:
            editables_dir = os.path.join(client_dir, dirname)
            if os.path.exists(editables_dir):
                for root, dirs, filenames in os.walk(editables_dir):
                    for filename in sorted(filenames):
                        filepath = os.path.join(root, filename)
                        files.append(filepath)
    
    # Check for server directory
    server_dir = os.path.join(resource_dir, "server")
    if os.path.exists(server_dir):
        # Check for files directly in server/
        for filename in sorted(os.listdir(server_dir)):
            filepath = os.path.join(server_dir, filename)
            if os.path.isfile(filepath):
                files.append(filepath)
        
        # Check for server editables (both "editable" and "editables")
        for dirname in ["editable", "editables"]:
            editables_dir = os.path.join(server_dir, dirname)
            if os.path.exists(editables_dir):
                for root, dirs, filenames in os.walk(editables_dir):
                    for filename in sorted(filenames):
                        filepath = os.path.join(root, filename)
                        files.append(filepath)
    
    return files

def generate_raw_link(filepath):
    """Generate raw GitHub link for a file."""
    # Convert backslashes to forward slashes and ensure proper path format
    normalized_path = filepath.replace("\\", "/")
    return f"{BASE_RAW_URL}/{normalized_path}"

def generate_markdown_output():
    """Generate markdown file with all raw links."""
    output_lines = []
    output_lines.append("# Raw GitHub Links for LS Scripts Resources\n")
    output_lines.append("This file contains raw GitHub links for all configuration and editable files in the repository.\n")
    
    resources = get_all_resources()
    
    for resource in resources:
        output_lines.append(f"\n## {resource}\n")
        files = get_resource_files(resource)
        
        if not files:
            output_lines.append("*No configuration or editable files found.*\n")
            continue
        
        for file in files:
            raw_link = generate_raw_link(file)
            # Get relative filename for display
            rel_file = file.replace(resource + os.sep, "").replace(resource + "/", "")
            output_lines.append(f"- **{rel_file}**  \n  {raw_link}\n")
    
    return "".join(output_lines)

def main():
    """Main function to generate the markdown file."""
    print("Scanning resources...")
    
    markdown_content = generate_markdown_output()
    
    # Write to file
    output_file = "RESOURCE_LINKS.md"
    with open(output_file, "w") as f:
        f.write(markdown_content)
    
    print(f"✓ Generated {output_file}")
    
    # Print summary
    resources = get_all_resources()
    total_files = 0
    for resource in resources:
        files = get_resource_files(resource)
        total_files += len(files)
    
    print(f"✓ Processed {len(resources)} resources")
    print(f"✓ Generated {total_files} raw links")

if __name__ == "__main__":
    main()

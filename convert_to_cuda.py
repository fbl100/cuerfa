import re

def process_file(filepath):
    # Regular expression with multiline and dotall flags
    function_pattern = re.compile(
        r'^(double|float|void|int|char|long|short|unsigned).*?\(.*?\)\s*;?\s*$',
        re.MULTILINE | re.DOTALL
    )

    with open(filepath, 'r') as file:
        content = file.read()

    # Find all matches in the file content
    matches = function_pattern.finditer(content)

    # Modify the content to add __device__ before each function definition
    modified_content = ""
    last_pos = 0

    for match in matches:
        start, end = match.span()
        modified_content += content[last_pos:start]  # Add content before the match
        modified_content += "__device__ " + content[start:end]  # Add __device__ before the function
        last_pos = end

    modified_content += content[last_pos:]  # Add the rest of the content after the last match

    # Write the modified content back to the file
    with open(filepath, 'w') as file:
        file.write(modified_content)

    print(f"Processed: {filepath}")

# Example usage:
# process_file('path_to_your_file.cu')

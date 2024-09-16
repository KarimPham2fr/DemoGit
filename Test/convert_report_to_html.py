import sys
import os

def clean_report(input_file):
    temp_file = input_file + ".tmp"

    # Clean the report data
    with open(input_file, 'r') as infile, open(temp_file, 'w') as outfile:
        for line in infile:
            if line.startswith("test/src/"):
                outfile.write(line)

    # Debug print to check if temp_file was created and written correctly
    if os.path.exists(temp_file) and os.path.getsize(temp_file) > 0:
        # Replace the original file with the cleaned file
        os.replace(temp_file, input_file)
    else:
        if os.path.exists(temp_file):
            os.remove(temp_file)  # Clean up temp file if something went wrong

def parse_report(report_file):
    data = []
    with open(report_file, 'r') as file:
        for line in file:
            if line.strip():  # Skip empty lines
                if line.startswith("Test/"):  # Data line
                    parts = line.strip().split(':')
                    if len(parts) >= 4:
                        data.append(parts)
                # Skip lines that start with "FAIL" or "PASS" or contain "Tests"
    return data

def write_to_html(data, output_file):
    with open(output_file, 'w') as file:
        file.write("<html>\n")
        file.write("<head>\n")
        file.write("<title>Test Report</title>\n")
        file.write("<style>\n")
        file.write("body { font-family: 'Times New Roman', serif; text-align: center; background-color: #f4f4f4; color: #333; }\n")
        file.write("table { width: 80%; margin: auto; border-collapse: collapse; background-color: #ffffff; text-align: left; }\n")
        file.write("table, th, td { border: 1px solid #ddd; }\n")
        file.write("th, td { padding: 10px; font-family: 'Cambria Math', serif; }\n")  # Use Cambria Math for table content
        file.write("th { background-color: #4CAF50; color: white; text-align: left; }\n")
        file.write("tr:nth-child(even) { background-color: #f9f9f9; }\n")
        file.write("tr:hover { background-color: #e2e2e2; }\n")
        file.write("td.pass { color: #4CAF50; }\n")
        file.write("td.fail { color: #f44336; }\n")
        file.write(".summary { text-align: left; color: #ff6600; font-size: 16px; margin: 20px auto; width: 80%; }\n")
        file.write("</style>\n")
        file.write("</head>\n")
        file.write("<body>\n")
        file.write("<h2>TESTING REPORT</h2>\n")
        file.write("<table>\n")
        file.write("<tr><th>File</th><th>Line</th><th>Test case</th><th>Result</th><th>Detail</th></tr>\n")

        for row in data:
            file.write("<tr>")
            for i, cell in enumerate(row):
                if i == 3:  # Assuming Result is in the 4th column
                    if cell == 'PASS':
                        file.write(f"<td class='pass'>{cell}</td>")
                    elif cell == 'FAIL':
                        file.write(f"<td class='fail'>{cell}</td>")
                else:
                    file.write(f"<td>{cell}</td>")
            file.write("</tr>\n")

        file.write("</table>\n")
        file.write("</body>\n")
        file.write("</html>\n")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 convert_report_to_html.py <input_file>")
        sys.exit(1)

    input_file = sys.argv[1]

    # Check if input file exists
    if not os.path.isfile(input_file):
        print(f"File '{input_file}' does not exist.")
        sys.exit(1)

    clean_report(input_file)
    data = parse_report(input_file)
    output_file = input_file.replace('.txt', '.html')
    write_to_html(data, output_file)
    print(f"HTML REPORT GENERATED: {output_file}")

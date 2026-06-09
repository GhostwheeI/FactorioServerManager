import sys

def check_balanced(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    errors = []

    # Check parentheses
    open_parens = content.count('(')
    close_parens = content.count(')')
    if open_parens != close_parens:
        errors.append(f"Unbalanced parentheses: {open_parens} open, {close_parens} close.")

    # Check curly braces
    open_braces = content.count('{')
    close_braces = content.count('}')
    if open_braces != close_braces:
        errors.append(f"Unbalanced curly braces: {open_braces} open, {close_braces} close.")

    # Check quotes (basic even count check, ignoring escapes for simplicity)
    single_quotes = content.count("'")
    if single_quotes % 2 != 0:
        errors.append(f"Odd number of single quotes: {single_quotes}.")

    double_quotes = content.count('"')
    if double_quotes % 2 != 0:
        errors.append(f"Odd number of double quotes: {double_quotes}.")

    if errors:
        print(f"[{filepath}] Syntax errors found:")
        for error in errors:
            print(f"  - {error}")
        return False
    else:
        print(f"[{filepath}] Basic syntax checks passed.")
        return True

if __name__ == "__main__":
    files_to_check = ['FactorioServerManager.ps1', 'example_batch.bat']
    all_passed = True
    for file in files_to_check:
        if not check_balanced(file):
            all_passed = False

    if all_passed:
        sys.exit(0)
    else:
        sys.exit(1)

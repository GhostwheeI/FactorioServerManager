import sys

def check_balanced_quotes_and_parens(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Check for balanced double quotes
    double_quotes_count = content.count('"')
    if double_quotes_count % 2 != 0:
        print(f"[ERROR] {filepath}: Unbalanced double quotes found (Total count: {double_quotes_count}).")
        return False

    # Check for balanced parentheses
    open_parens = content.count('(')
    close_parens = content.count(')')
    if open_parens != close_parens:
        print(f"[ERROR] {filepath}: Unbalanced parentheses found (Open: {open_parens}, Close: {close_parens}).")
        return False

    # Check for balanced square brackets
    open_brackets = content.count('[')
    close_brackets = content.count(']')
    if open_brackets != close_brackets:
        print(f"[ERROR] {filepath}: Unbalanced square brackets found (Open: {open_brackets}, Close: {close_brackets}).")
        return False

    # Check for balanced curly braces
    open_braces = content.count('{')
    close_braces = content.count('}')
    if open_braces != close_braces:
        print(f"[ERROR] {filepath}: Unbalanced curly braces found (Open: {open_braces}, Close: {close_braces}).")
        return False

    print(f"[PASS] {filepath}: Basic syntax checks passed.")
    return True

if __name__ == '__main__':
    success = True
    for file in ['FactorioServerManager.ps1', 'example_batch.bat']:
        if not check_balanced_quotes_and_parens(file):
            success = False

    if not success:
        sys.exit(1)
    sys.exit(0)

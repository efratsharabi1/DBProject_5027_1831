import re

INPUT_FILE = "schema.sql"
OUTPUT_FILE = "erd_description.txt"


def read_sql_file(file_path):

    with open(file_path, "r", encoding="utf-8") as file:
        return file.read()


def extract_tables(sql_text):

    tables = {}

    pattern = r"CREATE TABLE\s+(\w+)\s*\((.*?)\);"

    matches = re.findall(
        pattern,
        sql_text,
        re.DOTALL | re.IGNORECASE
    )

    for table_name, content in matches:

        columns = []
        primary_keys = []
        foreign_keys = []

        lines = content.splitlines()

        for line in lines:

            line = line.strip().rstrip(",")

            if not line:
                continue

            # PRIMARY KEY inside column
            if "PRIMARY KEY" in line.upper() \
                    and not line.upper().startswith("PRIMARY KEY"):

                column_name = line.split()[0]

                primary_keys.append(column_name)

            # PRIMARY KEY composite
            elif line.upper().startswith("PRIMARY KEY"):

                pk_match = re.search(r"\((.*?)\)", line)

                if pk_match:

                    keys = pk_match.group(1).split(",")

                    for key in keys:
                        primary_keys.append(key.strip())

            # FOREIGN KEY
            if line.upper().startswith("FOREIGN KEY"):

                fk_match = re.search(
                    r"FOREIGN KEY\s*\((.*?)\)\s*REFERENCES\s*(\w+)\s*\((.*?)\)",
                    line,
                    re.IGNORECASE
                )

                if fk_match:

                    foreign_keys.append({
                        "fk_column": fk_match.group(1),
                        "ref_table": fk_match.group(2),
                        "ref_column": fk_match.group(3)
                    })

            # REFERENCES inline
            elif "REFERENCES" in line.upper():

                ref_match = re.search(
                    r"(\w+).*REFERENCES\s+(\w+)\((\w+)\)",
                    line,
                    re.IGNORECASE
                )

                if ref_match:

                    foreign_keys.append({
                        "fk_column": ref_match.group(1),
                        "ref_table": ref_match.group(2),
                        "ref_column": ref_match.group(3)
                    })

            # regular attribute
            if not line.upper().startswith("FOREIGN KEY") \
                    and not line.upper().startswith("PRIMARY KEY"):

                parts = line.split()

                if len(parts) >= 2:

                    column_name = parts[0]
                    column_type = parts[1]

                    columns.append({
                        "name": column_name,
                        "type": column_type
                    })

        tables[table_name] = {
            "columns": columns,
            "primary_keys": primary_keys,
            "foreign_keys": foreign_keys
        }

    return tables


def create_relationships(tables):

    relationships = []

    for table_name, table_data in tables.items():

        for fk in table_data["foreign_keys"]:

            relationships.append({
                "from_table": fk["ref_table"],
                "to_table": table_name,
                "from_column": fk["ref_column"],
                "to_column": fk["fk_column"],
                "cardinality": "1:N"
            })

    return relationships


def write_output(tables, relationships):

    with open(OUTPUT_FILE, "w", encoding="utf-8") as file:

        file.write("ERD DESCRIPTION\n")
        file.write("=" * 60 + "\n\n")

        file.write("ENTITIES\n")
        file.write("=" * 60 + "\n\n")

        for table_name, table_data in tables.items():

            file.write(f"ENTITY: {table_name}\n")
            file.write("-" * 40 + "\n")

            # PRIMARY KEYS
            file.write("PRIMARY KEYS:\n")

            for pk in table_data["primary_keys"]:
                file.write(f"  - {pk}\n")

            # ATTRIBUTES
            file.write("\nATTRIBUTES:\n")

            for column in table_data["columns"]:

                file.write(
                    f"  - {column['name']} ({column['type']})\n"
                )

            # FOREIGN KEYS
            if table_data["foreign_keys"]:

                file.write("\nFOREIGN KEYS:\n")

                for fk in table_data["foreign_keys"]:

                    file.write(
                        f"  - {fk['fk_column']} "
                        f"REFERENCES "
                        f"{fk['ref_table']}({fk['ref_column']})\n"
                    )

            file.write("\n\n")

        file.write("=" * 60 + "\n")
        file.write("RELATIONSHIPS\n")
        file.write("=" * 60 + "\n\n")

        for rel in relationships:

            file.write(
                f"{rel['from_table']}({rel['from_column']}) "
                f"--- {rel['cardinality']} ---> "
                f"{rel['to_table']}({rel['to_column']})\n"
            )

    print(f"Created file: {OUTPUT_FILE}")


def main():

    sql_text = read_sql_file(INPUT_FILE)

    tables = extract_tables(sql_text)

    relationships = create_relationships(tables)

    write_output(tables, relationships)


if __name__ == "__main__":
    main()

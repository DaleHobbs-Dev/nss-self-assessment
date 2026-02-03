"""Example Code to demonstrate Python syntax."""

mydict = {"a": 1, "b": 2, "c": 3}

if "b" in mydict:
    print("Key 'b' found in dictionary with value:", mydict["b"])
else:
    print("Key 'b' not found in dictionary.")

for key, value in mydict.items():
    print(f"Key: {key}, Value: {value}")


# Example of a Person Class
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def greet(self):
        return f"Hello, my name is {self.name} and I am {self.age} years old."


# Instantiate an object of the Person class
person1 = Person("Alice", 30)
print(person1.greet())

receipt_items = [
    {"receipt_id": 1, "product_name": "Notebook", "quantity": 2, "line_total": 10.00},
    {"receipt_id": 1, "product_name": "Pen", "quantity": 5, "line_total": 7.50},
    {"receipt_id": 2, "product_name": "Backpack", "quantity": 1, "line_total": 45.00},
]


def group_items_by_receipt(items):
    """Group items by their receipt_id."""
    # Initialize an empty dictionary to hold grouped items
    new_dict = {}

    # Iterate through each item in the list
    for item in items:
        # Extract the receipt_id from the item
        receipt_id = item["receipt_id"]

        # Create a new dictionary without the receipt_id
        clean_item = {
            "product_name": item["product_name"],
            "quantity": item["quantity"],
            "line_total": item["line_total"],
        }

    # Append the clean item to the list corresponding to its receipt_id
    new_dict.setdefault(receipt_id, []).append(clean_item)

    return new_dict


print(group_items_by_receipt(receipt_items))

ignoreThis = """
Rationale for using a dictionary of lists to group items by receipt_id:
1. Efficient Lookup: A dictionary allows for O(1) average time complexity for lookups, making it quick to access all items for a specific receipt_id.
2. Grouping Related Data: Using a list as the value for each receipt_id allows for easy grouping of multiple items under the same receipt, which is essential for receipts that can contain multiple products.
3. One-to-Many Relationship: A dictionary of lists models the one-to-many relationship between a receipt and its items naturally.
4. Avoids Repeated Scanning: This structure avoids the need to repeatedly scan the entire list of items to find those belonging to a particular receipt.
5. Flexibility: It allows for easy addition of new items to a receipt without needing to restructure the data.
"""


def get_receipt_items(conn, receipt_id):
    """Fetch items for a specific receipt_id from the database."""
    cursor = conn.cursor()
    query = """
    SELECT p.name AS product_name, p.category, ri.quantity, ri.line_total
    FROM Receipt r
    JOIN ReceiptItem ri ON r.id = ri.receipt_id
    JOIN Product p ON ri.product_id = p.id
    WHERE r.id = ?
    ORDER BY ri.line_total DESC;
    """
    cursor.execute(query, (receipt_id,))
    return cursor.fetchall()

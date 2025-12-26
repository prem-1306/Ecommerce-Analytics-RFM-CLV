
DATA IMPORT STRATEGY – E-COMMERCE ANALYTICS PROJECT

This project follows a realistic hybrid data loading approach.

1) MySQL Import Wizard (GUI):
The following transactional tables were bulk-loaded using
MySQL Import Wizard for faster ingestion and schema alignment:

- customers
- orders
- products
- payments

2) Programmatic Load using Python (Pandas + SQLAlchemy):
The following tables were inserted into MySQL using Python
to handle large volumes and analytical transformations:

- order_items  (inserted using to_sql with chunksize)
- rfm           (replaced using to_sql after RFM computation)

3) Power BI Direct CSV Import:
The following analytical tables were generated in Python
and directly consumed in Power BI using Text/CSV option:

- clv_by_customer_cleaned.csv
- clv_projected_by_customer.csv

This hybrid approach reflects real-world analytics workflows,
balancing performance, flexibility, and tooling efficiency.



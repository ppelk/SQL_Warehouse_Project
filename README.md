# SQL Data Warehouse Project using Olist E-Commerce Dataset

This Project demonstrates a data warehousing solution that adheres to the Medallion architecture.

## Project Requirements

### Building the Data Warehouse
#### Objective
Develop a modern data warehouse in SQL server to consolidate sales data, enabling analytical reporting and informed decision-making. Demonstrate advanced SQL writing skills, understanding of data manipulation conventions, best practices understanding and project documentation skills. 

### Specifications
#### Data Sources
Brazilian E-Commerce Public Dataset by Olist. This data set consists of real online store sales data from Brazil's largest online retail website. Data contains information across 100k orders, customers, sellers, products, locations etc. in .csv format.

#### Data Quality
Preprocess and clean the data according to the medallion architecture. In the gold layer, implement a data model according to star schema (dim_customer, dim_order, fact_order, fact_order_item, dim_date). Ensure necessary data quality and adherence to business logic: completeness and uniqueness, business logic and referential integrity.

#### Data Manipulation
Refine values into end-user-friendly format. Derive new variables from existing ones.

#### Scope
Data loading, processing according to medallion architecture and transforming. Analytics left out of the scope due to performance requirements. 

#### Documentation
Demonstrate the data structures and processes within the project following models: Relation Database model, Star Schema and Data Flow across the Medallion Architecture.

# Data Pipeline Diagram
<img width="753" height="355" alt="image" src="https://github.com/user-attachments/assets/cc7b0e35-8363-4e51-b37c-0a86a8869b4d" />

# Bronze Layer Relation Database Model
<img width="1370" height="1224" alt="image" src="https://github.com/user-attachments/assets/ac61fa0d-0357-48a7-b65c-20099c8e3b5d" />

# Star Schema
<img width="1387" height="1421" alt="image" src="https://github.com/user-attachments/assets/7d765082-27be-4b20-ba87-3fc194b0e40d" />

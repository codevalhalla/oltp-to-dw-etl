# OLTP to DW ETL Pipeline

## Project Description
This project implements an **ETL (Extract, Transform, Load) pipeline** to synchronize data from an OLTP (Online Transaction Processing) Oracle database to a Data Warehouse (DW) Oracle database.  
The pipeline handles:

- **Extracting** data from OLTP tables (`store`, `city`, `state`, `country`)  
- **Transforming** and joining relevant fields for DW dimension tables  
- **Loading** new records and updating existing records in the DW (`store_dimension`)  
- **Logging** both inserted and updated rows for auditing purposes  

This project is designed for **learning, testing, and small-scale data integration scenarios**.

---

## Project Structure

```bash
oltp-to-dw-etl/
├── LICENSE
├── logs/
│ ├── logfile_inserted.txt
│ └── logfile_updated.csv
├── notebooks/
│ └── etl_analysis.ipynb
├── README.md
├── requirements.txt
├── scripts/
│ └── etl_upsert.py
└── sql/
├── create_dw_schema.sql
├── create_oltp_schema.sql
└── initial_data_inserts.sql
```

- **logs/** → Stores ETL log files (`logfile_inserted.txt` and `logfile_updated.csv`).  
- **notebooks/** → Jupyter notebooks for analysis or testing ETL outputs.  
- **scripts/** → Python ETL scripts (`etl_upsert.py`).  
- **sql/** → SQL scripts for creating OLTP/DW schemas and inserting initial data.  
- **requirements.txt** → Python dependencies.  
- **README.md** → Project documentation.

---

## Prerequisites

- Python 3.x  
- Oracle Client installed and configured  
- Oracle Database with OLTP and DW schemas  
- Python packages: `pandas`, `sqlalchemy`, `oracledb`  

Install Python dependencies:

```bash
pip install -r requirements.txt
```
## Setup Instructions

### Create OLTP and DW schemas
Run the SQL scripts in the `sql/` folder:

```sql
-- Connect as SYSDBA
@sql/create_oltp_schema.sql
@sql/create_dw_schema.sql
@sql/initial_data_inserts.sql
```
## Update Database Connection Strings

Update the connection strings in `scripts/etl_upsert.py` if necessary:

```python
connection_string_oltp = "oracle+oracledb://oltp:oracle@<HOST>:1521/?service_name=<SERVICE>"
connection_string_dw   = "oracle+oracledb://dw_database:oracle@<HOST>:1521/?service_name=<SERVICE>"
```
## Usage

Run the ETL script:

```bash
python3 scripts/etl_upsert.py
```

The script will upsert data from OLTP → DW.

Logs of inserted and updated rows are saved in `logs/` and also in DW tables (`log_inserted`, `log_updated`).

---

## ETL Process Flow

1. **Extract:** Pull data from OLTP tables using `pandas.read_sql()`.  
2. **Transform:** Merge `store`, `city`, `state`, `country` tables and prepare DW format.  
3. **Load:**  
   - Insert **new rows** into DW (`store_dimension`)  
   - Update **existing rows** in DW and log previous values  

---
## Author

Purushothama D.

## License

This project is licensed under the [MIT License](LICENSE).




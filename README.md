
# Bank Loan Analysis Dashboard
## Project Overview
A comprehensive PowerBI dashboard that analyzes bank loan applications and performance metrics. The dashboard processes and visualizes data for 3,796 loan applications with a total funded amount of $44.9M, providing valuable insights for loan portfolio management.

## Data Validation
 The dashboard metrics are validated through comprehensive SQL queries against the bank_loan_data table. Key validation queries include:
### Core Metrics Validation
        -- Total Applications
        SELECT COUNT(id) as total_loan_applications FROM bank_loan_data;

        -- Funded Amount
        SELECT SUM(loan_amount) as total_funded_amount FROM bank_loan_data;

        -- Average DTI
        SELECT ROUND(AVG(dti)*100,2) as avg_dti FROM bank_loan_data;

### Loan Performance Analysis

        -- Good Loans Percentage
        SELECT (COUNT(CASE 
                WHEN loan_status='Fully Paid' OR loan_status='Current' 
                THEN id END))*100/COUNT(id) as good_loan_percentage
        FROM bank_loan_data;

        -- Monthly Trends

        SELECT MONTH(issue_date) as month_number,
         DATENAME(month,issue_date) as Month_name,
         COUNT(id) as Total_loan_applications, 
         SUM(loan_amount) as Total_funded_amount
         FROM bank_loan_data
         GROUP BY month(issue_date), datename(month,issue_date);
### Dimensional Analysis
        -- State-wise Distribution

        SELECT address_state as State_Name,
        COUNT(id) as Total_loan_applications,
        SUM(loan_amount) as Total_funded_amount
        FROM bank_loan_data
        GROUP BY address_state;

        -- Purpose Analysis
        SELECT purpose as loan_purpose,
         COUNT(id) as loan_applications,
        (loan_amount) as Total_funded_amount
        FROM bank_loan_data
        GROUP BY purpose;
# Snapshot of Dashboard

![Screenshot 2024-12-31 073329](https://github.com/user-attachments/assets/a8ea3ed3-71da-4f45-a526-6e052934f8f2)

![Screenshot 2024-12-31 073347](https://github.com/user-attachments/assets/aa1dd8ef-b3e7-4740-a726-0d6a1fbfc771)

![Screenshot 2024-12-31 073408](https://github.com/user-attachments/assets/c1afdcd7-863c-4ec9-8f27-33886f5ed35d)

# Dashboard Features
## 1. Time Series Analysis
- Monthly trend visualization of loan applications
- Interactive timeline with drill-down capabilities
- Month-over-Month growth tracking
## 2. Geographic Distribution

- US state-wise loan application heat map
- Regional concentration analysis
- Interactive state filtering

## 3.Loan Characteristics
Term Distribution
- 36 months: 69.3%
- 60 months: 30.7%

## 4. Employment Analysis
Detailed breakdown by employee length:
- 10+ years: 8.9K applications
- <1 year to 7 years: Segmented distribution
- Correlation between employment length and loan approval

## 5. Loan Purpose Categories

- Debt consolidation (primary purpose)
- Credit card refinancing
- Home improvement
- Major purchases
- Small business
- Other categories (car, wedding, medical)


## Technical Implementation

- Built with Microsoft PowerBI
- SQL data validation and verification
- Custom DAX measures
- Dynamic visualizations
- Responsive design

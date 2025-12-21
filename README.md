# Zudio-Business-Intelligence-and-Predictive-Analytics
# Project Overview:
This project presents an end-to-end Retail Business Intelligence (BI) solution built using Excel, SQL Server, Power BI, and DAX. The objective is to analyze Zudio’s retail sales data to uncover insights related to sales performance, customer behavior, product profitability, store performance, and future demand forecasting.

The project transforms a raw retail dataset into a structured Fact–Dimension model, validates it using SQL, and visualizes insights through interactive Power BI dashboards to support data-driven business decisions.

# Project Objectives:
- Analyze overall sales and profit performance across time11 periods.
- Understand customer behavior, retention, and segmentation.
- Identify top-selling and profitable product categories.
- Evaluate store and regional performance.
- Forecast future sales trends to support demand planning.
- Provide actionable business recommendations.

# Tools & Technologies Used:
- Microsoft Excel – Data cleaning, transformation, and restructuring
- SQL Server – Data modelling, validation, and business queries
- Power BI – Dashboard creation and data visualization
- DAX – KPI calculations, time intelligence, and analytical measures

# Dataset Description:
- Source: Kaggle (Retail Clothing Sales Dataset)
- Records: ~10,000 sales transactions
- Original Columns: 29 (raw dataset)
- Time Period: 1 year
- Business Areas Covered: Sales, Customers, Products, Stores

# Data Model:
 A Star Schema was implemented consisting of:
- FactSales – Transaction-level sales data
- DimCustomer – Customer demographic details
- DimProduct – Product and pricing information
- DimStore – Store location and operational data
- DimDate – Date table for time-based analysis

# Dashboards Developed:
- Retail Sales Performance Overview
- Customer Behavior & Segmentation
- Product & Inventory Insights
- Sales Forecasting & Demand Planning

- Each dashboard includes KPIs, charts, slicers, and insights designed to answer key business questions.

# Key KPIs & Metrics:
- Total Sales, Total Profit, Total Orders
- Average Order Value (AOV)
- Month-over-Month (MoM) Growth & Trend
- Customer Retention Rate & Repeat Rate
- Stock Turnover & Stock Gap
- Forecasted Sales

# Key Insights:
- Peak sales observed during festive months (October–November)
- Strong contribution from Women and Kids product categories
- High-performing regions and stores identified for benchmarking
- Low-performing stores highlighted for improvement
- Forecast indicates upcoming growth periods and seasonal slowdowns

# Business Recommendations:
- Optimize inventory for high-demand stores and categories
- Improve customer retention through targeted marketing campaigns
- Plan inventory and staffing ahead of seasonal peaks
- Adopt performance-based stock allocation
- Focus on profitable and trending products to maximize revenue

# Future Enhancements:
- Automate data refresh using Power BI Gateway
- Implement advanced forecasting models (ARIMA / Prophet)
- Add Customer Lifetime Value (CLV) analysis
- Perform RFM-based customer segmentation
- Analyze impact of discounts and promotions

# Repository Structure
📁 Data
   - ├── FactSales.csv
   - ├── DimCustomer.csv
   - ├── DimProduct.csv
   - ├── DimStore.csv

📁 PowerBI
   ├── Zudio_Retail_Sales_Dashboard.pbix

📁 Report
   ├── Final_Report.pdf

👤 Author -
Khan Abu Hashim

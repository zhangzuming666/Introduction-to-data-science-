# Stock Prediction using Financial Indicators (INF6027)
This study analyzes financial data from U.S. companies spanning from 2014 to 2018, focusing on identifying key financial indicators that influence a company's Net Income. Net Income, a key profitability metric, reflects a company's ability to generate profit after all expenses, including taxes, have been deducted. Understanding the relationship between financial indicators such as Revenue, EBITDA, Total Assets, and Total Liabilities can provide valuable insights for business strategy, financial analysis, and investment decisions. The dataset used in this study contains various financial indicators, making it a valuable resource for assessing the factors that contribute to Net Income across multiple companies

Research Questions:
1.What financial indicators, such as Revenue, EBITDA, Total Assets, and Total Liabilities, most strongly correlate with Net Income for companies between 2014 and 2018?
2.How do these financial metrics influence Net Income across different companies in the dataset?
3.Can a regression model be developed to predict Net Income based on these key financial indicators, and how accurate is the model?

Key Findings:
Key Predictors: EBITDA and Revenue are the strongest predictors of Net Income, with EBITDA having the most significant impact.
Trends: The Quick Ratio fluctuated, especially in 2015-2016, while the Debt-to-Equity Ratio remained stable.
Predictive Model: The regression model explains Net Income well (R² = 0.7712), but the high RMSE suggests room for improvement.

Dataset：
The dataset used in this study consists of financial data for U.S. companies from 2014 to 2018, with key variables such as Revenue, EBITDA, Total Assets, Total Liabilities, and Net Income. The data was sourced from Kaggle and includes financial records for over 22,000 companies across the five-year period.
Dataset source: https://www.kaggle.com/datasets/cnic92/200-financial-indicators-of-us-stocks-20142018

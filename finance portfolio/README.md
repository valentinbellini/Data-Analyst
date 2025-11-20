# Google Sheets Finance Portfolio Tracker

![Dashboard](./imgs/Dashboard.jpg)


This repository contains a  **Google Sheets** template designed to help you track, analyze, and manage your financial investment portfolio. It is tailored for investors who utilize both local (Argentine) and international assets, featuring automatic real-time data fetching for key instruments.

* **Multi-Asset Tracking:** By now support Stocks and CEDEARs but is prepared for Crypto, Bonds, ETFs.
* **Real-Time Data:** Integrates with Google Finance and custom functions to pull live prices and market data.
* **Performance Metrics:** Calculates returns, cost basis, and current valuation.
* **Currency Conversion:** Handles assets denominated in different currencies (e.g., Argentine Pesos (ARS) and US Dollars (USD)).

## 🇦🇷 Understanding Local vs. International Equities: Stocks vs. CEDEARs

Since this portfolio tracker is designed with an Argentine market focus, it uses two main terms that international users might find unfamiliar: **Stocks** and **CEDEARs**.

### 1. Stocks (Acciones)

In the context of the Argentine market, **Stocks** (or *Acciones*) generally refer to the equities of companies that are based in Argentina and are traded directly on the local stock exchange (e.g., the shares of Argentine companies like YPF or Telecom).

* **What they are:** Ownership shares in a domestic (Argentine) company.
* **How they are traded:** Usually bought and sold in **Argentine Pesos (ARS)** on the local exchange.

### 2. CEDEARs (Certificados de Depósito Argentinos)

**CEDEARs** (which stands for *Certificados de Depósito Argentinos* or Argentine Depositary Certificates) are essentially the Argentine version of a **Depositary Receipt** (like American Depositary Receipts - ADRs - in the US).

They are an instrument that allows local Argentine investors to buy and sell fractional ownership of **international stocks (e.g., Apple, Google, Coca-Cola)** through the local Argentine stock exchange, and trade them in **Argentine Pesos (ARS)** or sometimes **US Dollars (USD)**.

* **What they are:** Certificates representing shares of foreign companies.
* **Why they exist:** They provide Argentine investors with an easy, local way to invest in global companies without needing a foreign brokerage account or sending money abroad.
* **Key Distinction:** When you buy a CEDEAR, you are buying a certificate representing an underlying foreign stock, not the foreign stock itself. Their price is influenced by both the underlying stock's price in its foreign market and the local exchange rate conditions.


## How to Use the Tracker

1.  **Download:** Download the Google Sheet file from the link provided in this repository (or make a copy if it's a direct link).
2.  **Input Data:** Navigate to the **"Operations"** tab and input your buy/sell transactions, specifying the asset type (Stock, CEDEAR, ETF, etc.), ticker, quantity, and price.
3.  **Check Ticker Symbols:** Ensure you are using the correct ticker symbols as recognized by Google Finance (for international assets) and the local exchange (for Argentine assets/CEDEARs).
4.  **Analyze:** View the **"Portfolio Summary"** tab for real-time performance and allocation breakdowns.

![Dashboard](./imgs/importingData.jpg)

---

## Disclaimer

This tool is for **informational and tracking purposes only**. It does not constitute financial advice. Investment performance can vary, and past performance is not indicative of future results. Always consult with a qualified financial professional before making investment decisions.

*Google sheet*: https://docs.google.com/spreadsheets/d/1Hm7UMhplC6ESYZvERvCNYMNtAegGjPb1rVl3nAZj8RI/edit?usp=sharing

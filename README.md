# ChaInVoice
Blockchain backed Invoice System

# Create the Following SmartContracts 

||ContractName||Contract Functions||  
### Goals 
1.  *Governance Contract* 
2. Controller Contract which exposes public functions that invokes other contracts 
3. RegisterSupplier  
4. RaisePurchaseOrder  
5. RaiseInvoice  
### Supplier Validation Contract  
1. Invoked by Governance 
2. Validates Supplier using Oracle 
### Supplier Registry Contract  
1. Invoked by Governance to insert a valid supplier  
### Purchase Order Validation Contract  
1. Invoked by Governance to validate a Purchase Order  
2. Invoked by Governance to update PO status 
### Purchase order Registry Contract  
1. Invoked by Governance to insert a PO to registry  
2. Invoked by Suppliers to get the Purchase Orders 
### Invoice Validation Contract 
1. Invoked by Governance to validate an incoming RaiseInvoice request  
### Invoice Registry Contract 
3. Invoked by Governance to insert an invoice to registry  




# ChaInVoice
Blockchain backed Invoice System


# Goals
# Create the Following SmartContracts

||ContractName||Contract Functions||
Governance Contract
Controller Contract which exposes public functions that invokes other contracts
RegisterSupplier
RaisePurchaseOrder
RaiseInvoice
Supplier Validation Contract
Invoked by Governance
Validates Supplier using Oracle
Supplier Registry Contract
Invoked by Governance to insert a valid supplier
Purchase Order Validation Contract
Invoked by Governance to validate a Purchase Order
Invoked by Governance to update PO status
Purchase order Registry Contract
Invoked by Governance to insert a PO to registry
Invoked by Suppliers to get the Purchase Orders
Invoice Validation Contract
Invoked by Governance to validate an incoming RaiseInvoice request
Invoice Registry Contract
Invoked by Governance to insert an invoice to registry




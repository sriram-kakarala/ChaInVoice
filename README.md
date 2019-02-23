# ChaInVoice
Blockchain backed Invoice System

# Create the Following SmartContracts 


## Goals 

### ChainInvoice Governance Contract
Controller Contract which exposes public functions that invokes other contracts 
  ##### Constructor/Init
    a. Yes
    b. Parameters: Address - This indicates that this contract and it's sub-contracts belong to this Manufacturer. Used for validation wherever manufacturer validation needs to be 
    c. Stored As: private address member
    d. View: Viewable as a read only function
  #####  Members
    a. self_Address: A pointer to the giverning body.
    b. enum register_seller_errors {ALREADY_REGISTERED,IN_REVIEW,ADDED}
    c. enum raise_invoice_errors {WRONG_PO_ADDRESS,DUPLICATE_INVOICE,INVOICE_PROCESSED}
    D. enum raise_PO_errors {TODO}
  #####  Functions
    a. RegisterSeller
      Modifiers: None
      Parameters: seller_address
      Rules: seller_address != self.address && !seller_address.in(Sellers_Address_List), that is a manufcaturer cannot register itself as a supplier/seller.
      Return: True/False
      Emit: Transaction Log
    b. RaisePurchaseOrder
      Modifiers: Only Buyer/Manufacturer can raise
      Parameters: seller_address, po_details
      Rule: invoker.address == self.address && seller_address.in(Sellers_Address_List)
      Return: Created PO Address
      Emit: Transaction Log
    c. RaiseInvoice
      Modifiers: TODO
      Parameters: sellers_address, po_address
      Rule: sellers_address.in(Suppliers_Address_List) && po_address.in(PO_ADDRESS_LIST) && po_address.seller_address == sellers_address
      Return: True/Fasle - Eventually a Receipt/Confirmation
      Emit: Transaction Log
     d. getGoverningBody()
     Modifiers: None
     Returns: Self.Address
     

### Supplier Validation Contract  
Invoked by ChainInVoice Governance Contract to validate Supplier
  #####  Functions
    a. validateSeller(address)
      Modifier: _require(invoker.address == chaininvoice.getGoiverningBody())_
      Rules: if(address.notIn(Supplier_Address_List)) && Oracle.isValidSupplier(Address)
      Return: True
  
### Supplier Registry Contract  
1. Invoked by Governance to insert a valid supplier  
  #####  Struct
    a. SupplierAddress
    b. SupplierStatus
    c. SupplierName
  #####  Members
    a. Supplier_Address_List<Address>
  #####  Functions
    a. getSupplierAddress_List()
    b. isValidSupplier(supplier_address) return Supplier_Address_List.contains(supplier_address);
    c. addSupplier(supplier_address)
      Modifiers: _require(invoker.address == chaingovernance.getGoverningBody())
      Rules:
      Action: Supplier_Address_List.add(supplier_address)
      Return: True/False
  

############################## TODO #############################

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
### PurcahseOrderRegistry Contract
  Functions
    a.




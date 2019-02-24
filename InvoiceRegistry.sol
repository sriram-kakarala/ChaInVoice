pragma solidity >=0.4.22 <0.6.0;

import "./PurchaseOrderRegistry.sol";

contract  InvoiceRegistry{
    
    struct invoice {
        uint256 invoiceNum;
        uint256 poNum;
        address manufacturerAddress;
        address supplierAddress;
    }
    
    mapping(uint256 => invoice) invoiceMap;
    invoice[] invoices;
    uint256 invoiceNumber=1;
    
    function createInvoice(uint256 _invoiceNum, uint256 _poNum,address _manufacturer_address, address _supplierAddress)
    public returns (uint256) {
        
        require(_manufacturer_address != address(0));
        require(_supplierAddress != address(0));
        require(_poNum != 0);
        require(_invoiceNum != 0);
        
        uint256 currinvoiceNumber = invoiceNumber;
        invoiceMap[invoiceNumber] = invoice(_invoiceNum,_poNum, _manufacturer_address, _supplierAddress);
        invoices.push(invoiceMap[invoiceNumber]);
        invoiceNumber++;
        return currinvoiceNumber;
    }
    
    function getAllInvoices(address _supplier_address) public view returns (uint256[]) {
        uint256[] memory poNumbers = new uint256[](invoices.length);
        
        for (uint i = 0; i < invoices.length; i++) {
            invoice memory aInvoice = invoices[i];
            if(aInvoice.supplierAddress == _supplier_address) {
                poNumbers[i] = aInvoice.invoiceNum;
            }
        }
        
        return (poNumbers);
    }
    
}

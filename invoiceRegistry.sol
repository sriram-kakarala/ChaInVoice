pragma solidity >=0.4.22 <0.6.0;

import "./PurchaseOrderRegistry.sol";

contract  invoiceRegistry{
    
    struct invoice {
        uint256 invoiceNumber;
        uint256 piNum;
        address manufacturerAddress;
        address supplierAddress;
    }
    
    mapping(uint256 => invoice) invoiceMap;
    invoice[] invoices;
    uint256 invoiceNumber=1;
    
    function createInvoice(address _manufacturer_address, address _supplierAddress, uint256 _piNum)
    public returns (uint256) {
        
        require(_manufacturer_address != address(0));
        require(_supplierAddress != address(0));
        require(_piNum != 0);
        
        
        uint256 currinvoiceNumber = invoiceNumber;
        invoiceMap[invoiceNumber] = invoice(invoiceNumber, _piNum, _manufacturer_address, _supplierAddress);
        invoices.push(invoiceMap[invoiceNumber]);
        invoiceNumber++;
        return currinvoiceNumber;
    }
    
    
}

pragma solidity >=0.4.22 <0.6.0;

contract  PurchaseOrderRegistry{
    
    struct PurchaseOrder {
        uint256 piNumber;
        address manufacturerAddress;
        address supplierAddress;
    }
    
    mapping(uint256 => PurchaseOrder) purchaseOrderMap;
    PurchaseOrder []  purchaseOrders;
    uint256 piNum = 1;
    
    function createPurchaseOrder(address _manufacturer_address, address _supplierAddress)
    public {
        
        require(_manufacturer_address != address(0));
        require(_supplierAddress != address(0));
        
        purchaseOrderMap[piNum] = PurchaseOrder(piNum,_manufacturer_address);
        purchaseOrders.push(purchaseOrderMap[piNum]);
        piNum++;
    }
    
    // TODO: Add a function to get All PO for a manufacturer
}

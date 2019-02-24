pragma solidity >=0.4.22 <0.6.0;
import "./InvoiceGovernance.sol";
import "./SupplierRegistry.sol";
contract  PurchaseOrderRegistry is InvoiceGovernance{
    
    struct PurchaseOrder {
        uint256 piNumber;
        address manufacturerAddress;
        address supplierAddress;
    }
    
    mapping(uint256 => PurchaseOrder) purchaseOrderMap;
    PurchaseOrder []  purchaseOrders;
    uint256 piNum = 1;
    
    function createPurchaseOrder(address _manufacturer_address, address _supplierAddress)
    public returns (uint256) {
        
        require(_manufacturer_address != address(0));
        require(_supplierAddress != address(0));
        
        uint256 currPiNumber = piNum;
        purchaseOrderMap[piNum] = PurchaseOrder(piNum, _manufacturer_address, _supplierAddress);
        purchaseOrders.push(purchaseOrderMap[piNum]);
        piNum++;
        return currPiNumber;
    }
    
    // TODO: Add a function to get All PO for a manufacturer
    function getAllPOS(address _manufacturer_address) public view returns (address[] memory) {
        // TODO: Length of this need to be picked up dynamically
        address[] memory addresses = new address[](purchaseOrders.length);
        
        for (uint i = 0; i < purchaseOrders.length; i++) {
            PurchaseOrder memory aPurchase = purchaseOrders[i];
            if(aPurchase.manufacturerAddress == _manufacturer_address) {
                addresses[i] = aPurchase.supplierAddress;
            }
        }
        
        return (addresses);
    }
}

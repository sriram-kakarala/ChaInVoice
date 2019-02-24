pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

import "./SupplierRegistry.sol";
import "./PurchaseOrderRegistry.sol";


contract InvoiceGovernance {
    
    struct Manufacturer {
        address ownerPublicKey;
        string  name;
        address supplierRegistry;
        address purchaseOrderRegistry;
    }
    
    
    mapping(address => Manufacturer) private theManufacturersMap;
    Manufacturer[] private theManufacturersList;
    uint nonce = 0;
    
     /**
     * isGoverningBody: Checks if the caller address is in the list of manufacturers
     * 
     */
    modifier isGoverningBody() {
        require(theManufacturersMap[msg.sender].ownerPublicKey != address(0));
        _;
    }
    
    /**
     * A public constructor, allowing this contract to be executed with an address 
     * & name of manufacturer. This means anybody can register itself as a manufacturer
     * 
     */
    function registerManufacturer(address ownerPublicKey, string memory name) payable public returns (uint index) {
        require(ownerPublicKey != address(0));
        bytes memory strAsBytes = bytes(name);
        require(strAsBytes.length > 0);
        require(theManufacturersMap[ownerPublicKey].ownerPublicKey == address(0));
        
        theManufacturersMap[ownerPublicKey]  = Manufacturer(ownerPublicKey, name, 
                                                    new SupplierRegistry(), new PurchaseOrderRegistry());
        theManufacturersList.push(theManufacturersMap[ownerPublicKey]);
        return theManufacturersList.length;
    }
    
    
    
    /**
     * getGoverningBody: returns the address and name of a Manufacturer. 
     * Since in solidity we cannot return structs as yet, we return the tuple
     */
    function getCurrentManufacturer() public view isGoverningBody returns (address, string memory) {
        return (theManufacturersMap[msg.sender].ownerPublicKey, theManufacturersMap[msg.sender].name);
    }
    
    /**
     * getGoverningBody: returns the address and name of a Manufacturer. 
     * Since in solidity we cannot return structs as yet, we return the tuple
     */
    function getAllManufacturers() public view returns (address[] memory) {
        address[] memory addresses = new address[](theManufacturersList.length);
        
        for (uint i = 0; i < theManufacturersList.length; i++) {
            Manufacturer memory aManufcaturer = theManufacturersList[i];
            addresses[i] = aManufcaturer.ownerPublicKey;
        }
        
        return (addresses);
    }
    
    function registerSupplier(address seller_address, string memory seller_name) 
                payable public isGoverningBody returns (bool) {
                    
        Manufacturer theManufcaturer = theManufacturersMap[msg.sender];
        SupplierRegistry register = SupplierRegistry(theManufcaturer.supplierRegistry);
        register.addSupplier(msg.sender, seller_address, seller_name);
        return true;
    }
    
     function getSuppliers() 
                 public view isGoverningBody returns (address[] suppliers) {
        Manufacturer theManufcaturer = theManufacturersMap[msg.sender];
        SupplierRegistry register = SupplierRegistry(theManufcaturer.supplierRegistry);
        return register.getAllSuppliersForAManufacturer(msg.sender);
    }
    
    function createPurcahseOrder() 
                payable public isGoverningBody returns (uint256) {
                    
        Manufacturer theManufcaturer = theManufacturersMap[msg.sender];
        PurchaseOrderRegistry poRegister = PurchaseOrderRegistry(theManufcaturer.purchaseOrderRegistry);
        address[] memory listOfSuppliers = getSuppliers();
        uint randomSupplier = rand(0, listOfSuppliers.length);
        address aRandomSupplier = listOfSuppliers[randomSupplier];
        
        return poRegister.createPurchaseOrder(msg.sender, aRandomSupplier);
    }
    
    function getAllPurchaseorders() public view isGoverningBody returns (uint256 []) {
        Manufacturer theManufcaturer = theManufacturersMap[msg.sender];
        PurchaseOrderRegistry poRegister = PurchaseOrderRegistry(theManufcaturer.purchaseOrderRegistry);
        return poRegister.getAllPOS(msg.sender);
    }
    
    function rand(uint min, uint max) public returns (uint){
        nonce++;
        return uint(sha3(nonce))%(min+max)-min;
    }
    
}

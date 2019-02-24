pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

import "./SupplierRegistry.sol";
import "./PurchaseOrderRegistry.sol";
import "./InvoiceRegistry.sol";


contract InvoiceGovernanceContract {
    
    struct Manufacturer {
        address ownerPublicKey;
        string  name;
        address supplierRegistry;
        address purchaseOrderRegistry;
        address invoiceRegistry;
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
                                                    address(new SupplierRegistry()), 
                                                    address(new PurchaseOrderRegistry()), 
                                                    address(new InvoiceRegistry()));
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
                    
        Manufacturer memory theManufcaturer = theManufacturersMap[msg.sender];
        SupplierRegistry register = SupplierRegistry(theManufcaturer.supplierRegistry);
        register.addSupplier(msg.sender, seller_address, seller_name);
        return true;
    }
    
     function getSuppliers() 
                 public view isGoverningBody returns (address[] memory suppliers) {
        Manufacturer memory theManufcaturer = theManufacturersMap[msg.sender];
        SupplierRegistry register = SupplierRegistry(theManufcaturer.supplierRegistry);
        return register.getAllSuppliersForAManufacturer(msg.sender);
    }
    
    function createPurchaseOrder() 
                payable public isGoverningBody returns (uint256) {
                    
        Manufacturer memory theManufcaturer = theManufacturersMap[msg.sender];
        PurchaseOrderRegistry poRegister = PurchaseOrderRegistry(theManufcaturer.purchaseOrderRegistry);
        address[] memory listOfSuppliers = getSuppliers();
        uint randomSupplier = rand(listOfSuppliers.length);
        address aRandomSupplier = listOfSuppliers[randomSupplier];
        
        return poRegister.createPurchaseOrder(msg.sender, aRandomSupplier);
    }
    
    function getAllPurchaseorders() public view isGoverningBody returns (uint256[] memory) {
        Manufacturer memory theManufcaturer = theManufacturersMap[msg.sender];
        PurchaseOrderRegistry poRegister = PurchaseOrderRegistry(theManufcaturer.purchaseOrderRegistry);
        return poRegister.getAllPOS(msg.sender);
    }
    
    function rand(uint max) private view returns (uint){
        uint randomnumber = uint(keccak256(abi.encodePacked(now, msg.sender, nonce))) % max;
        return randomnumber;
    }
    
    function raiseInvoice(address manufacturer_address, 
                address seller_address, uint256 po_number, uint256 invoiceNumber) public payable returns (uint256) {
       
       Manufacturer memory theManufcaturer = theManufacturersMap[manufacturer_address];
       SupplierRegistry register = SupplierRegistry(theManufcaturer.supplierRegistry);
       bool isValidSupplier = register.isAValidSupplier(seller_address);
       
       if(isValidSupplier) {
            PurchaseOrderRegistry poRegister = PurchaseOrderRegistry(theManufcaturer.purchaseOrderRegistry);
            bool isPoValid = poRegister.isValidPoForSupplier(po_number, seller_address);
            if(isPoValid) {
                InvoiceRegistry invoiceRegistry = InvoiceRegistry(theManufcaturer.invoiceRegistry);
                return invoiceRegistry.createInvoice(invoiceNumber, po_number, manufacturer_address, seller_address);
            }
       }
       
       return 0;
   }
    
}

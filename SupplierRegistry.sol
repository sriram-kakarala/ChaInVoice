pragma solidity >=0.4.22 <0.6.0;

contract  SupplierRegistry{
    
/**    
 * a. getSupplierAddress_List()
 * b.--> isValidSupplier(supplier_address) return Supplier_Address_List.contains(supplier_address);
 * c. addSupplier(supplier_address)
 * Modifiers:--> _require(invoker.address == chaingovernance.getGoverningBody())
 * Rules:
 * Action: -->Supplier_Address_List.add(supplier_address)
 * Return: True/False 
 */
    struct Supplier{
        address supplierAddress;
        address manufacturerAddress;
        string supplierName;
    }
    
    mapping(address => Supplier) supplierMap;
    Supplier []  suppliers;
    
    function addSupplier(address _manufacturer_address, address _supplierAddress,
        string memory _supplierName)public{
        
        require(_supplierAddress != address(0));
        bytes memory strAsBytes = bytes(_supplierName);
        require(strAsBytes.length > 0);
        require(supplierMap[_supplierAddress].supplierAddress == address(0));
        
        /*supplierMap[_supplierAddress] = Supplier(_supplierAddress, _manufacturer_address, 
        _supplierName);*/
        suppliers.push(Supplier(_supplierAddress, _manufacturer_address, 
        _supplierName));
        
    }
    
    function getSupplier(address supplier_address)public view returns(address, address,string memory){
        
        Supplier memory supplier = supplierMap[supplier_address];
        return(supplier.supplierAddress, supplier.manufacturerAddress,
                supplier.supplierName);
        
    }
    
    function getAllSuppliersForAManufacturer(address _manufacturer_address) public view returns (address[] memory) {
        // TODO: Length of this need to be picked up dynamically
        
        uint length = 0;
        if(suppliers.length > 0) {
            length = suppliers.length;
        }
        address[] memory addresses = new address[](length);
        
        for (uint i = 0; i < suppliers.length; i++) {
            Supplier memory aSupplier = suppliers[i];
            if(aSupplier.manufacturerAddress == _manufacturer_address) {
                addresses[i] = aSupplier.supplierAddress;
            }
        }
        
        return (addresses);
    }
    
    function isAValidSupplier(address _seller_address) public view returns (bool) {
       
       for (uint i = 0; i < suppliers.length; i++) {
           Supplier memory aSupplier = suppliers[i];
           if(aSupplier.supplierAddress == _seller_address) {
              return true;
           }
       }
       
       return false;
   }
}

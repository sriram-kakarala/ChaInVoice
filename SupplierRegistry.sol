pragma solidity ^0.5.1;

contract  SupplierRegistry{
    
/**    a. getSupplierAddress_List()
b.--> isValidSupplier(supplier_address) return Supplier_Address_List.contains(supplier_address);
c. addSupplier(supplier_address)
  Modifiers:--> _require(invoker.address == chaingovernance.getGoverningBody())
  Rules:
  Action: -->Supplier_Address_List.add(supplier_address)
  Return: True/False */
    struct Supplier{
        address supplierAddress;
        uint256 supplierStatus;
        string supplierName;
    }
    
    Supplier []  supplier;
    
    function addSupplier(address _supplierAddress,
        uint256 _supplierStatus,string memory _supplierName)public{
        
        supplier.push(Supplier(_supplierAddress,_supplierStatus,_supplierName));
        
    }
     function getSupplier(uint256 id)public view returns(address,uint256,string memory){
        
        return(supplier[id].supplierAddress,supplier[id].supplierStatus,
                supplier[id].supplierName
                );
        
    }
    function isValidSupplier()public{
        
    }
}

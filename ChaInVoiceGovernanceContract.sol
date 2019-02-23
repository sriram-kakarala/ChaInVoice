pragma solidity >=0.4.22 <0.6.0;

contract ChaInVoiceGovernanceContract {
    
    struct Manufacturer {
        address owner;
        string  name;
    }
    
    Manufacturer private theManufacturer;
    
    constructor(address owner, string name) public {
        require(owner != 0x00);
        bytes memory strAsBytes = bytes(name);
        require(strAsBytes.length > 0);
        
        theManufacturer = Manufacturer(owner, name);
    }
    
    modifier isGoverningBody {
        require(msg.sender == theManufacturer.owner);
        _;
    }
    
    function getGoverningBody() public view returns (address) {
        return theManufacturer.owner;
    }
    
    function registerSeller(address seller_address, string seller_name) 
                public view isGoverningBody returns (bool) {
        seller_address = theManufacturer.owner;
        seller_name = theManufacturer.name;
        return true;
    }
    
    
}

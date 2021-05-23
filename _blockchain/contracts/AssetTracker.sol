pragma solidity 0.8.4;

contract AssetTracker {
  string uuid;

  struct Asset {

    string name;
    string description;
    bool init;
    string manufacturer;

  }

  function setId(string calldata serial) public {
    uuid = serial;
  }

  function getId() public view returns(string memory){
    return uuid;
  }

  mapping(string => Asset) private assetStore;
  mapping(address => mapping(string => bool)) private walletStore;

  event AssetCreate(address account, string uuid, string manufacturer);
  event RejectCreate(address account, string uuid, string message);
  event AssetTranfer(address from, string uuid);
  event RejectTranfer(address from, string uuid, string message);

  /* 
  
  Outward visible function to create an asset
  
  @Params
    name: Asset Name
    description: Asset description
    manufacturer: Unique public key of the manufacturer
  
  */

  function createAsset(string calldata name, string calldata description, string calldata manufacturer) public {
    if(assetStore[uuid].init) {
      emit RejectCreate(msg.sender, uuid, "Asset already exists");
    }

    assetStore[uuid] = Asset(name, description, true, manufacturer);
    walletStore[msg.sender][uuid] = true;
    emit AssetCreate(msg.sender, uuid, manufacturer);

  }

  function transferAsset(string calldata reciever, string calldata serial) public {

  }
}
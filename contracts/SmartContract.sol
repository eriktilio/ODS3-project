// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22;
pragma experimental ABIEncoderV2;

/**
 * @title SmartContract
 * @dev Store & retrieve value in a variable
 */

contract SmartContract {
    uint256 amount = address(this).balance;

    struct Product {
        address owner;
        address payable farmer;
        string name;
        uint256 price;
        string typeItem;
        string description;
        bool available;
    }

    struct Order {
        uint256 productId;
        Product product;
        address buyer;
        address payable seller;
        string deliveryPlace;
        bool delivered;
    }

    Product[] productList;
    Order[] orders;

    event RegisteredProduct(address sender, bool confirmed);
    event RegisteredOrder(address buyer, address seller, bool confirmed);
    event UpdatedOrder();

    // PRODUCTS
    function setProduct(
        address payable _farmer,
        string memory _name,
        uint256 _price,
        string memory _typeItem,
        string memory _description
    ) public {
        productList.push(
            Product({
                owner: msg.sender,
                farmer: _farmer,
                name: _name,
                price: _price,
                typeItem: _typeItem,
                description: _description,
                available: true
            })
        );
        emit RegisteredProduct(msg.sender, true);
    }

    function getProduct(uint256 _index)
        public
        view
        returns (
            address,
            address,
            string memory,
            uint256,
            string memory,
            string memory
        )
    {
        Product memory product = productList[_index];
        return (
            product.owner,
            product.farmer,
            product.name,
            product.price,
            product.typeItem,
            product.description
        );
    }

    function getAllProducts() external view returns (Product[] memory) {
        return productList;
    }

    function setProductOwner(address newOwner, uint256 index) private {
        productList[index].owner = newOwner;
    }

    function setOrder(
        uint256 _productId,
        Product memory _product,
        address _buyer,
        address payable _seller,
        string memory _deliveryPlace
    ) public {
        orders.push(
            Order({
                productId: _productId,
                product: _product,
                buyer: _buyer,
                seller: _seller,
                deliveryPlace: _deliveryPlace,
                delivered: false
            })
        );

        emit RegisteredOrder(_buyer, _seller, true);
    }

    function getOrders() public view returns (Order[] memory) {
        return orders;
    }

    function getOrder(uint256 _productId)
        public
        view
        returns (Order memory order)
    {
        for (uint256 index = 0; index < orders.length; index++) {
            if (orders[index].productId == _productId) {
                return orders[index];
            }
        }
    }

    function setDelivery(uint256 _index) public {
        orders[_index].delivered = true;
    }

    function buyProduct(uint256 _index, string memory _deliveryPlace)
        public
        payable
    {
        Product memory product = productList[_index];
        require(product.price == msg.value);
        amount += msg.value;
        product.available = false;
        setOrder(_index, product, msg.sender, product.farmer, _deliveryPlace);
    }

    function confirmedPurchase(uint256 _index) public payable {
        Product memory product = productList[_index];
        Order memory order = getOrder(_index);
        require(msg.sender == order.buyer);
        setProductOwner(order.buyer, _index);
        amount -= product.price;
        order.seller.transfer(product.price);
        setDelivery(_index);
        emit UpdatedOrder();
    }
}

  GNU nano 7.2                                  src/DeepBalanceGuard.sol                                           
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITrap {
    function collect() external view  returns (bytes memory);
    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory);
}

contract DeepBalanceGuard is ITrap {
    address public constant target = 0xDB34AAaA0a0495Dc47C4898391d4D9cF6957d0F1;
    uint256 public constant thresholdPercent = 2;
    uint256 public constant maxStallBlocks = 10;

    uint256 public lastUpdatedBlock;

    constructor() {
        lastUpdatedBlock = block.number;
    }

    function collect() external view override returns (bytes memory) {
        return abi.encode(target.balance, block.number);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length < 2) return (false, "Insufficient data");

        (uint256 currentBalance, uint256 currentBlock) = abi.decode(data[0], (uint256, uint256));
        (uint256 prevBalance, uint256 prevBlock) = abi.decode(data[1], (uint256, uint256));

        // 1. проверка на падение баланса
        uint256 diff = currentBalance > prevBalance ? currentBalance - prevBalance : prevBalance - currentBalance;
        uint256 pct = (diff * 100) / prevBalance;

        if (pct >= 2) {
            return (true, abi.encode("Balance deviation >= 2%"));
        }

        // 2. проверка на превышение блоков без обновлений
        if (currentBlock - prevBlock > 10) {
            return (true, abi.encode("Trap may be stale (>10 blocks)"));
        }

        return (false, "");
    }
}

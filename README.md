## 0 : SetUp ▶

```bash
git clone "https://github.com/niluk-256/Quill-CTF-foundry.git"

forge install
forge  test   --match-contract {contract} -vvvv


```

---

## 1 : Road Closed ☑

“We keep out the wrong people – by letting anyone in.”
<br>

<li>Objective of CTF </li>

```
Become the owner of the contract
Change the value of hacked to true
```

test Method 1 with EOA

```bash
forge test  --match-contract RoadAttackerSimple -vvv
forge test  --match-contract RoadAttackerSimple -vvvv

```

test Method 2 Contract

```bash
forge test  --match-contract RoadAttackerWithContract -vvvv
```

Even though there is ` isContract` .we can bypasss it because when we execute our logic inside of the constructor(Attacker contract) the code size is zero it won't be included in the runtime code.

## 2 : Confidential Hash ☑

<br>

<li>Objective of CTF </li>

```
Find the keccak256 hash of aliceHash and bobHash.
```

test Exploit

```bash

forge test  --match-contract ConfidentialHashExploit  -vvv
forge test  --match-contract ConfidentialHashExploit  -vvvv

```

```
Never store sensitive information in
contract because anyone access it from the storage.
```

#### Learning Resources

[How to read ethereum contract storage](https://medium.com/@dariusdev/how-to-read-ethereum-contract-storage-44252c8af925)

[Resource2 ](https://medium.com/coinmonks/hacking-secrets-in-ethereum-smart-contracts-646c638c395c)

## 3 : VIP Bank ☑

“This Bank is only for its VIP Customers.”

<br>

<li>Objective of CTF </li>

```
At any cost, lock the VIP user balance forever into the contract.
```

test Exploit

```bash
forge test  --match-contract VIPBankExploit  -vvvv
```

#### Learning Resources

[Resource1 - Alchemy-SelfDestruct](https://www.alchemy.com/overviews/selfdestruct-solidity)

## 9 : WETH10 ❌

---

<br/>

#### please open a PR on the repo if you wish to contribute💙 .

#### Please only publish solutions for retired the challenges check here👇

[quillCTF challenges](https://quillctf.super.site/challenges)

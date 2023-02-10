## 1 : Road Closed

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

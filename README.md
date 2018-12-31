<h1 align="center">以太坊DAPP实现</h1>

<h3 align="right">16340282 袁之浩</h3>

#### 题目

一个基于区块链的P2P网络贷款平台，放贷人在平台上发布信息，贷款人选择最适合自己的贷款，并提出申请，放贷人审核贷款人的资料信息确定是否贷款，贷款人的信息和每一笔贷款都会被写入区块链中，保证了记录可查，而且不需要第三方中介。

#### 背景和依据

前段时间的借贷宝风波将互联网贷款推上了风口浪尖，贷款门槛低，暴力催收等问题让网络贷款蒙上了一层阴影，而通过区块链技术，则可以实现一个较好的贷款环境。

从市场角度看，基于区块链技术的P2P平台满足了市场对于直接融资的刚性需求。真正的直接融资降低了融资成本，实现风险定价市场化，优化了社会资源匹配。基于区块链技术的P2P无需建立可信第三方，节点上每一个账本都会记录每一次借贷，无法伪造，无法篡改，并且解决了多头借贷的问题。

从技术角度看，做出一个P2P区块链平台的技术准备已经成熟。基于以太坊基础上的智能合约，可以完成借款人征信加密、发布借款信息、投资人转账、利息流转等所有关键节点需求，无需建立可信的第三方。以太坊是个图灵完备的生态圈，P2P公司在此基础上建立DAPP，技术实现难度极低。

区块链贷款最大程度的避免了平台的道德和运营风险，交易完全透明可查，监管部门可以轻易地对信息的真实性做验证，并且让利于民，是一个很有前景的发展方向。

#### 实现

合约层loan.sol

实现了贷款平台的基本逻辑，贷款人和放贷人信息的保存，交易的执行，以及数据的获取。

交互层loan.js

通过web3.js接口实现合约的初始化和接口的调用，并将其封装为js函数

UI层

前端使用vue框架，进行数据的展示和与合约的交互

#### 运行

> truffle compile
>
> truffle migrate --reset --network ganache

![1545828831170](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1545828831170.png)

> npm install
>
> npm run dev

![1545828902521](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1545828902521.png)

#### 使用

首页可以查看自己的合约地址，账户余额和放贷人。

![1545829840760](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1545829840760.png)

点击添加按钮可以添加放贷人

![1545829689511](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1545829689511.png)

点击borrow按钮可以向放贷人借钱

![1545829907831](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1545829907831.png)

借钱成功，可以看到自己的余额增加了，放贷人的可放贷余额减少了

![1545829970787](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1545829970787.png)


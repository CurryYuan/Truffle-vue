<template>
  <div class="dashboard">
    <h1>{{ msg }}</h1>
    <div>
      <p>Your address: {{ address }}</p>
      <p>Your balacne: {{ balance }}</p>
      <p>Current lenders number: {{ lendersNum }}</p>
    </div>
    <Button type="primary" @click="addLender">addLender</Button>
    <card style="width:50%;margin:20px auto">
      <p slot="title">Lenders</p>
      <ul>
        <li v-for="item in lendersList" v-bind:key="item.address">
          <Card>
            <p slot="title">name: {{item.name}}</p>
            <p>balance: {{item.balance}}</p>
            <Button @click="openBorrow(item)">borrow</Button>
          </Card>
        </li>
      </ul>
    </card>
    <Modal v-model="showAddLender" title="Add Lender">
      <Form :model="addForm" ref="addForm" :label-width="100">
        <FormItem label="name:">
          <Input v-model="addForm.name"/>
        </FormItem>
        <FormItem label="balance:">
          <Input v-model="addForm.balance"/>
        </FormItem>
        <FormItem label="address:">
          <Input v-model="addForm.address"/>
        </FormItem>
      </Form>
      <div slot="footer">
        <Button type="text" @click="doCancel">取消</Button>
        <Button type="primary" @click="doLenderAdd">确认</Button>
      </div>
    </Modal>
    <Modal v-model="showBorrow" title="Borrow" :closable="false">
      <p>Borrow from {{borrowItem.address}}</p>
      <p>please enter the money you want to borrow:</p>
      <Input type="text" v-model="borrowMoney" placeholder="Enter money" style="margin:10px"/>
      <div slot="footer">
        <Button type="text" @click="doBorrowCancel">取消</Button>
        <Button type="primary" @click="lendMoney">确认</Button>
      </div>
    </Modal>
  </div>
</template>

<script>
import Loan from "@/js/loan";

export default {
  name: "dashboard",
  data() {
    return {
      msg: "Welcome to Loans platform",
      address: undefined,
      balance: 0,
      lendersNum: 0,
      lendersList: [],
      showAddLender: false,
      showBorrow: false,
      borrowMoney: '',
      addForm: {},
      borrowItem: {}
    };
  },
  beforeCreate: function() {
    Loan.init().then(() => {
      this.address = window.web3.eth.accounts[0];
      this.getLendersList();
      this.getBalance();
    });
  },
  methods: {
    addLender: function() {
      this.showAddLender = true;
    },
    doLenderAdd: function() {
      let data = this.addForm;
      Loan.addLender(this.addForm).then(res => {
        this.doCancel();
        this.getLendersList();
        this.$Message.success('add lender success');
      }).catch(err=>{
          console.log(err)
        this.$Message.error('add lender failed');
      });
    },
    doCancel: function() {
      this.showAddLender = false;
      this.$refs.addForm.resetFields();
      this.addForm = {};
    },
    doBorrowCancel: function() {
      this.showBorrow = false;
      this.borrowItem = {};
      this.borrowMoney='';
    },
    getLendersList: function() {
      Loan.getLendersNum()
        .then(res => {
          this.lendersNum = res.toNumber();
          return Promise.resolve(res);
        })
        .then(res => {
          this.lendersList = [];
          for (let i = 0; i < res; ++i) {
            Loan.getLender(i).then(res => {
              this.lendersList.push(res);
            });
          }
        });
    },
    getLendersNum: function(e) {
      Loan.getLendersNum().then(res => {
        this.lendersNum = res.toNumber();
      });
    },
    getBalance: function() {
      Loan.getBalance().then(res=>{
        this.balance=res.toNumber();
      });
    },
    openBorrow: function(item) {
      this.borrowItem=item;
      this.showBorrow=true;
    },
    lendMoney: function() {
      let data={};
      data.address=this.borrowItem.address;
      data.borrowMoney=this.borrowMoney;
      Loan.lendMoney(data).then(res=>{
        this.getBalance();
        this.getLendersList();
        this.doBorrowCancel();
        this.$Message.success('borrow success');
      }).catch(err=>{
        this.$Message.error('borrow failed');
      })
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1 {
  margin-bottom: 40px;
}
p {
  font-size: 16px;
}
ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>

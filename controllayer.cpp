#include "controllayer.h"

void ControlLayer::connectServer(){
    socket->abort();
    socket = new QTcpSocket(this);
    socket->abort();
    socket->connectToHost("192.168.191.2",6666);
    connect(socket,SIGNAL(connected()),this,SLOT(writeMesg()));
    connect(socket,SIGNAL(readyRead()),this,SLOT(readMesg()));
}
void ControlLayer::writeMesg(){
    QByteArray reqdatabytearray = serializer.serialize(this->reqdatavarlist);
    socket->write(reqdatabytearray,reqdatabytearray.size());
    qDebug()<<"writeMesg:"<<QString(reqdatabytearray);
}
void ControlLayer::readMesg(){
    QByteArray recdatabytearray =socket->readAll();
//    theclassmodel->setTheclassVarCount(this->theclassvarcount);
    delete theclassmodel;
    theclassmodel=new TheClassModel(0,this->theclassvarcount);
    QVariantList templist= this->parser.parse(recdatabytearray).toList();
    QVariantList theclass;
    for(int i=0;i<templist.size();i++){
        theclass<<templist[i];
        if((i+1)%this->theclassvarcount==0){
            theclassmodel->addTheClass(theclass);
            theclass.clear();
        }
    }
    qDebug()<<"readMesgRowCount:"<<theclassmodel->rowCount();
    qDebug()<<"readMesg:";
    for(int i=0;i<theclassmodel->rowCount();i++){
        qDebug()<<theclassmodel->rowDatas(i);
    }
    switch(this->requestype){
        //登陆相关控制层
        case rt_login:
            emit loginFinish((LoginState)theclassmodel->rowColData(0,0).toInt(),theclassmodel->rowColData(0,1).toInt());
            break;
        //人事管理相关控制层
        case rt_listAllWorker:
            emit allWorkers(theclassmodel);
            break;
        case rt_getWorkerDetail:
            emit workerDetail(theclassmodel->rowDatas(0));
            break;
        case rt_saveWorker:
            emit workerSaved(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_deleteWorker:
            emit workerDeleted(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_addWorker:
            emit workerAdded(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_getSupplierList:
            emit supplierList(theclassmodel);
            break;
        case rt_getSupplierDetail:
            emit supplierDetail(theclassmodel->rowDatas(0));
            break;
        case rt_saveSupplier:
            emit supplierSaved(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_deleteSupplier:
            emit supplierDeleted(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_addSupplier:
            emit supplierAdded(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_changePositionState:
            emit positionChanged(theclassmodel->rowColData(0,0).toBool());
            break;
        //销售相关控制层
        case rt_getSaleStatistic:
            emit saleStatistic(theclassmodel->colDatas(0),theclassmodel->colDatas(1));
            break;
        case rt_getSaleCatagoryStatistic:
            emit saleCatagoryStatistic(theclassmodel->colDatas(0),theclassmodel->colDatas(1));
            break;
        case rt_getSaleRecords:
            emit saleRecords(theclassmodel);
            break;
        case rt_getSaleRecords2:
            emit saleRecords(theclassmodel);
            break;
        case rt_getAllRecords:
            emit allSaleRecords(theclassmodel);
            break;
        case rt_addSaleRecord:
            emit saleRecordAdded(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_getProductName:
            emit productName(theclassmodel->rowColData(0,1).toString(),theclassmodel->rowColData(0,4).toDouble());
            break;
        //库存相关控制层
        case rt_getRepertoryStatistic:
            emit repertoryStatistic(theclassmodel->colDatas(0),theclassmodel->colDatas(1));
            break;
        case rt_getAllProducts:
            emit allProducts(theclassmodel);
            break;
        case rt_saveProduct:
            emit productSaved(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_deleteProduct:
            emit productDeleted(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_addProduct:
            emit productAdded(theclassmodel->rowColData(0,0).toBool());
            break;
        //进货相关控制
        case rt_getStockPlans:
            emit stockPlans(theclassmodel);
            break;
        case rt_getSupplierNames:
            emit supplierNames(theclassmodel->colDatas(3),theclassmodel->colDatas(0));
            break;
        case rt_savePlan:
            emit planSaved(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_addPlan:
            emit planAdded(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_deletePlan:
            emit planDeleted(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_changePlanState:
            emit planStateChanged(theclassmodel->rowColData(0,0).toBool());
            break;
        //系统管理相关控制层
        case rt_getStuffMainInfo:
            emit stuffMainInfo(theclassmodel);
            break;
        case rt_saveStuffMainInfo:
            emit stuffMainInfoSaved(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_getAllUsers:
            emit allUsers(theclassmodel);
            break;
        case rt_saveUser:
            emit userSaved(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_addUser:
            emit userAdded(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_deleteUser:
            emit userDeleted(theclassmodel->rowColData(0,0).toBool());
            break;
        case rt_getOneUser:
            QVariantList emitlist=theclassmodel->rowDatas(0);
            emitlist[0]=QVariant(QString("%1").arg(emitlist[0].toInt()));
            emit oneUser(emitlist);
            break;
//        default:
//            emit loadModelFinished(theclassmodel);
//            break;

    }
}
//登陆相关控制层
void ControlLayer::login(int workernum, QString password) {
    this->requestype=rt_login;
    this->reqdatavarlist.clear();
    this->workernum=workernum;
    this->reqdatavarlist<<this->requestype<<workernum<<password;
    this->theclassvarcount=2;//loginstate,workertype
    this->connectServer();

    if (workernum <= 31 && password == "123") {
        emit loginFinish(LoginState::SUCCESS,workernum);
    }
}
//人事管理相关控制层
void  ControlLayer::listAllWorker() {
    this->requestype=RequestType::rt_listAllWorker;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=7;//id(int),name,tel(string),address,isPosition(bool),email,sex(bool)
    qDebug()<<"listAllWorker";
    this->connectServer();
}
void ControlLayer::getSupplierList(){
    this->requestype=RequestType::rt_getSupplierList;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=6;//suppliername,phone,pic,id,addr,descrip
    this->connectServer();
}
void ControlLayer::getSupplierDetail(int id){
    this->requestype=RequestType::rt_getSupplierDetail;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<id;
    this->theclassvarcount=6;//suppliername,phone,pic,id,addr,descrip
    this->connectServer();
}
void ControlLayer::getWorkerDetail(int id){
    this->requestype=RequestType::rt_getWorkerDetail;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<id;
    this->theclassvarcount=7;//name,telephone,gender,employee_id,address,email,group_id
    this->connectServer();
}
void ControlLayer::saveWorker(QVariantList data){//id(int) name tel(string) address isPosition(bool)  email sex(bool)
    this->requestype=RequestType::rt_saveWorker;
    this->reqdatavarlist.clear();
    QVariantList sendsupplierinfo;
    sendsupplierinfo<<data[0]<<-1<<data[6]<<data[1]<<data[2]<<data[3]<<data[5]<<data[4];
    //id,athority=-1,sex,name,tel,address,email,isPosition
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    qDebug()<<"saveWorker:"<<data;
    this->connectServer();
}
void ControlLayer::deleteWorker(int id){
    this->requestype=RequestType::rt_deleteWorker;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<id;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::addWorker(QVariantList data){//name tel address isPosition email sex(bool)
    this->requestype=RequestType::rt_addWorker;
    this->reqdatavarlist.clear();
    QVariantList sendsupplierinfo;
    sendsupplierinfo<<data[5]<<data[0]<<data[1]<<data[2]<<data[4]<<data[3];
    //authority,sex,name,tel,address,email,isPosition
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    qDebug()<<"addWorker:"<<data;
    this->connectServer();
}
void ControlLayer::saveSupplier(QVariantList supplierinfo){//suppliername,phone,pic,id,addr,descrip
    this->requestype=RequestType::rt_saveSupplier;
    this->reqdatavarlist.clear();
    QVariantList sendsupplierinfo;
    sendsupplierinfo<<supplierinfo[3]<<supplierinfo[0]<<supplierinfo[4]<<supplierinfo[1]<<supplierinfo[5]<<supplierinfo[2];
    //id,suppliername,addr,phone,descrip,pic
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    qDebug()<<"saveSupplier:"<<supplierinfo;
    this->connectServer();
}
void ControlLayer::deleteSupplier(int id){
    this->requestype=RequestType::rt_deleteSupplier;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<id;
    this->theclassvarcount=1;//ok
    qDebug()<<"deleteSupplierid:"<<id;
    this->connectServer();
}
void ControlLayer::addSupplier(QVariantList data){//suppliername,phone,pic,addr,descrip
    this->requestype=RequestType::rt_addSupplier;
    this->reqdatavarlist.clear();
    QVariantList sendsupplierinfo;
    sendsupplierinfo<<data[0]<<data[3]<<data[1]<<data[4]<<data[2];
    //suppliername,addr,phone,descrip,pic
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::changePositionState(int userId, bool isPosition){
    this->requestype=RequestType::rt_changePositionState;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<userId<<isPosition;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
//销售相关控制层
void  ControlLayer::getSaleStatistic(){
    this->requestype=RequestType::rt_getSaleStatistic;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=2;//年月，销售额
    this->connectServer();
}
void  ControlLayer::getSaleCatagoryStatistic(QDate startYMD,QDate endYMD){
    this->requestype=RequestType::rt_getSaleCatagoryStatistic;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<startYMD<<endYMD;
    this->theclassvarcount=2;//商品类别，库存
    this->connectServer();
}
void ControlLayer::getSaleRecords(QDate startYMD, QDate endYMD){
    this->requestype=RequestType::rt_getSaleRecords;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<startYMD<<endYMD;
    this->theclassvarcount=5;//记录id，商品id，数量，销售额，时间
    this->connectServer();
}
void ControlLayer::getSaleRecords(int product_id, QDate from_date, QDate end_date){
    this->requestype=RequestType::rt_getSaleRecords2;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<product_id<<from_date<<end_date;
    this->theclassvarcount=5;//product_id product_name price num sale_time(string)
    this->connectServer();
}
void ControlLayer::getAllRecords(){
    this->requestype=RequestType::rt_getAllRecords;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<"1970-01-01"<<QDate::currentDate();
    this->theclassvarcount=5;//product_id product_name price num sale_time(string)
    this->connectServer();
}
void ControlLayer::addSaleRecord(QVariantList record){//product_id price(double) num(int)
    this->requestype=RequestType::rt_addSaleRecord;
    this->reqdatavarlist.clear();
    QVariantList sendsupplierinfo;
    sendsupplierinfo<<record[0]<<record[2]<<record[2].toInt()*record[1].toDouble();
    //product_id,num,totalprice
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::getProductName(int product_id){
    this->requestype=RequestType::rt_getProductName;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<product_id;
    this->theclassvarcount=7;//productname
    this->connectServer();
}
//库存相关控制层
void ControlLayer::getRepertoryStatistic(){
    this->requestype=RequestType::rt_getRepertoryStatistic;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=2;//商品类别，库存量
    this->connectServer();
}
void ControlLayer::getAllProducts(){
    this->requestype=RequestType::rt_getAllProducts;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=7;//id(int) name catagory(string) num price info image(string)
    this->connectServer();
}
void ControlLayer::saveProduct(QVariantList data){ //id(int) name catagory(string) num price info image(string)
    this->requestype=RequestType::rt_saveProduct;
    this->reqdatavarlist.clear();
    QVariantList sendsupplierinfo;
    sendsupplierinfo<<data[0]<<data[4]<<data[1]<<data[6]<<data[5]<<data[3]<<data[2];
    //id,price,name,picture,description,num,kind
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::deleteProduct(int id){
    this->requestype=RequestType::rt_deleteProduct;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<id;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::addProduct(QVariantList data){  //name catagory(string) num price info image(string)
    this->requestype=RequestType::rt_addProduct;
    this->reqdatavarlist.clear();
    QVariantList sendsupplierinfo;
    sendsupplierinfo<<data[3]<<data[0]<<data[5]<<data[4]<<data[2]<<data[1];
    //price,name,picture,description,num,kind
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
//进货相关控制层
void ControlLayer::getStockPlans(){
    this->requestype=RequestType::rt_getStockPlans;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=11;//purchase_id，product_id，plan_employee_id，purchase_employee_id，
                            //supplier_name，purchase_date，quantity，money_amount，is_finish，comment,product_name
    this->connectServer();
}
void ControlLayer::getSupplierNames(){
    this->requestype=RequestType::rt_getSupplierNames;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=6;//SupplierId,SupplierNames
    this->connectServer();
}
void ControlLayer::savePlan(QVariantList theplan){//purchase_id，product_id，supplier_id，purchase_date，
                                                   //quantity，money_amount，comment
    this->requestype=RequestType::rt_savePlan;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<theplan;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::addPlan(QVariantList theplan){//product_id，supplier_id，purchase_date，
                                                //quantity，money_amount，is_finish，comment
    this->requestype=RequestType::rt_addPlan;
    this->reqdatavarlist.clear();

    QVariantList sendsupplierinfo;
    int doplanworkerid=-1;
    if(theplan[5].toBool()){doplanworkerid=this->workernum;}
    sendsupplierinfo<<theplan[0]<<this->workernum<<doplanworkerid<<theplan[1]<<theplan[2]<<theplan[3]<<theplan[4]<<theplan[5]<<theplan[6];
    //product_id,makeplanworkerid,doplanworkerid,supplier_id，purchase_date,quantity，money_amount，is_finish，comment
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::deletePlan(int planId){
    this->requestype=RequestType::rt_deletePlan;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<planId;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::changePlanState(int planId, bool isFinish){
    this->requestype=RequestType::rt_changePlanState;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<planId<<this->workernum<<isFinish;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
//系统管理相关控制层
void ControlLayer::getStuffMainInfo(){
    this->requestype=RequestType::rt_getStuffMainInfo;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=3;//id(int) name password(string)
    this->connectServer();
}
void ControlLayer::saveStuffMainInfo(QVariantList info){  //id(int) password(string)
    this->requestype=RequestType::rt_saveStuffMainInfo;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<info;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::getAllUsers(){
    this->requestype=RequestType::rt_getAllUsers;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=7;//id(int) name tel(string) address authority(int) email sex(bool)
    this->connectServer();
}
void ControlLayer::saveUser(QVariantList user){ //id(int) name tel(string) address authority(int) email sex(bool)
    this->requestype=RequestType::rt_saveUser;
    this->reqdatavarlist.clear();
    QVariantList sendsupplierinfo;
    sendsupplierinfo<<user[0]<<user[4]<<user[6]<<user[1]<<user[2]<<user[3]<<user[5];
    //id,athority,sex,name,tel,address,email
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::addUser(QVariantList user){  //id,name tel(string) address authority(int) email sex(bool)
    this->requestype=RequestType::rt_addUser;
    this->reqdatavarlist.clear();
    QVariantList sendsupplierinfo;
    sendsupplierinfo<<user[0]<<user[4]<<user[6]<<user[1]<<user[2]<<user[3]<<user[5];
    //id,athority,sex,name,tel,address,email
    this->reqdatavarlist<<this->requestype<<sendsupplierinfo;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::deleteUser(int user_id){
    this->requestype=RequestType::rt_deleteUser;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<user_id;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::getOneUser(int user_id){
    this->requestype=RequestType::rt_getOneUser;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<user_id;
    this->theclassvarcount=7;//id(int) name tel(string) address authority(int) email sex(bool)
    this->connectServer();
}

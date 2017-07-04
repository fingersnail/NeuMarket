#include "controllayer.h"

void ControlLayer::connectServer(){
    socket->abort();
    socket = new QTcpSocket(this);
    socket->abort();
    socket->connectToHost("127.0.0.1",6666);
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
    qDebug()<<"readMesg.rowDatas(0):"<<theclassmodel->rowDatas(0);
    switch(this->requestype){
        //登陆相关控制层
        case rt_login:
            emit loginFinish((LoginState)theclassmodel->rowColData(0,0).toInt(),theclassmodel->rowColData(0,1).toInt());
            break;
        //人事管理相关控制层
        case rt_listAllWorker:
            emit listAllWorker(theclassmodel->colDatas(0),theclassmodel->colDatas(1));
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
        //库存相关控制层
        case rt_getRepertoryStatistic:
            emit repertoryStatistic(theclassmodel->colDatas(0),theclassmodel->colDatas(1));
            break;
        //进货相关控制
        case rt_getStockPlans:
            emit stockPlans(theclassmodel);
            break;
        case rt_getSupplierNames:
            emit supplierNames(theclassmodel->colDatas(0),theclassmodel->colDatas(1));
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
        default:
            emit loadModelFinished(theclassmodel);
            break;
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
}
//人事管理相关控制层
void  ControlLayer::listAllWorker() {
    this->requestype=RequestType::rt_listAllWorker;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=7;//employee_id,group_id,gender,name,telephone,address,email
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
void ControlLayer::saveSupplier(QVariantList supplierinfo){//suppliername,phone,pic,id,addr,descrip
    this->requestype=RequestType::rt_saveSupplier;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<supplierinfo;
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
    this->reqdatavarlist<<this->requestype<<data;
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
//库存相关控制层
void ControlLayer::getRepertoryStatistic(){
    this->requestype=RequestType::rt_getRepertoryStatistic;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=2;//商品类别，库存量
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
    this->theclassvarcount=2;//SupplierId,SupplierNames
    this->connectServer();
}
void ControlLayer::savePlan(QVariantList theplan){//purchase_id，product_id，supplier_id，purchase_date，
                                                   //quantity，money_amount，comment
    this->requestype=RequestType::rt_savePlan;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype;
    this->theclassvarcount=1;//ok
    this->connectServer();
}
void ControlLayer::addPlan(QVariantList theplan){//product_id，supplier_id，purchase_date，
                                                //quantity，money_amount，is_finish，comment
    this->requestype=RequestType::rt_addPlan;
    this->reqdatavarlist.clear();
    this->reqdatavarlist<<this->requestype<<theplan<<this->workernum;
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
    this->reqdatavarlist<<this->requestype<<planId<<isFinish<<this->workernum;
    this->theclassvarcount=1;//ok
    this->connectServer();
}

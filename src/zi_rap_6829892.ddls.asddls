@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAP READ ONLY'
define root view entity ZI_RAP_6829892 
  as select from z6829892_eina as InfoRec
  
  inner join z6829892_lfa1 as Vendor
      on InfoRec.lifnr = Vendor.lifnr
      
    inner join z6829892_makt as MatDesc
      on InfoRec.matnr = MatDesc.matnr
{
    @UI.lineItem: [{ position: 10, label: 'Info Record' }]
    key InfoRec.infnr as PurchasingInfoRecord,
    
    @UI.lineItem: [{ position: 20, label: 'Vendor No.' }]
    key Vendor.lifnr  as VendorNumber,
    
    @UI.lineItem: [{ position: 30, label: 'Material No.' }]
    key InfoRec.matnr as MaterialNumber,

    @UI.lineItem: [{ position: 40, label: 'Vendor Name' }]
    Vendor.name1  as VendorName,
    
    @UI.lineItem: [{ position: 50, label: 'City' }]
    Vendor.ort01  as City,

    @UI.lineItem: [{ position: 60, label: 'Material Group' }]
    InfoRec.matkl as MaterialGroup,
    
    @UI.lineItem: [{ position: 70, label: 'Points' }]
    InfoRec.anzpu as NumberOfPoints,

    @UI.lineItem: [{ position: 80, label: 'Material Description' }]
    MatDesc.maktx as MaterialDescription
}
where MatDesc.spras = $session.system_language

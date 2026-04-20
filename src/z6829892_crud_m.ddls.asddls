@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Managed CRUD View for Vendor'

@UI.headerInfo: {
  typeName: 'Vendor',
  typeNamePlural: 'Vendors',
  title: { type: #STANDARD, value: 'lifnr' }
}

define root view entity Z6829892_CRUD_M
  as select from z6829892_lfa1
{
      @UI.facet: [{ id: 'VendorData', purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, label: 'Vendor Details', position: 10 }]
 
      
      @UI.lineItem: [{ position: 10, label: 'Vendor Number' }]
      @UI.identification: [{ position: 10, label: 'Vendor Number' }]
      @UI.selectionField: [{ position: 10 }]
      @EndUserText.label: 'Vendor Number'
  key lifnr,

      @UI.lineItem: [{ position: 20, label: 'Vendor Name' }]
      @UI.identification: [{ position: 20, label: 'Vendor Name' }]
      @UI.selectionField: [{ position: 20 }]
      @EndUserText.label: 'Vendor Name'
      name1,

      @UI.lineItem: [{ position: 30, label: 'Country Key' }]
      @UI.identification: [{ position: 30, label: 'Country Key' }]
      @EndUserText.label: 'Country Key'
      land1,

      @UI.lineItem: [{ position: 40, label: 'City' }]
      @UI.identification: [{ position: 40, label: 'City' }]
      @EndUserText.label: 'City'
      ort01,
      
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at
}

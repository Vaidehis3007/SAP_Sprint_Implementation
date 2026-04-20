@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Root'
@UI.headerInfo: { typeName: 'Header', typeNamePlural: 'Headers' }

define root view entity ZI_026_STON_HEADER
  as select from Z026_HEADER_STON
  composition [0..*] of ZI_026_STON_CHILD as _Carrier
{
  @UI.facet: [ {
    id:              'idCarrier',
    purpose:         #STANDARD,
    type:            #LINEITEM_REFERENCE,
    label:           'Carrier Multi Inline Edit',
    position:        10,
    targetElement:   '_Carrier'
  } ]
  
  key singleton_id as SingletonID,
  
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  last_changed_at as LastChangedAt,
  
  _Carrier
}

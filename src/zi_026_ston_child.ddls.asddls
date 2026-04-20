@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Carrier Root View'

@UI.headerInfo: { typeName: 'Carrier', typeNamePlural: 'Carriers' }

define view entity ZI_026_STON_CHILD
  as select from Z026_CHILD_STON
  association to parent ZI_026_STON_HEADER as _Singleton on $projection.SingletonID = _Singleton.SingletonID
{

 
    @UI.facet: [ { id: 'idCarrier', type: #IDENTIFICATION_REFERENCE, label: 'Carrier Details', position: 10 } ]

   @UI.hidden: true
    key singleton_id as SingletonID,
@UI: { lineItem:       [ { position: 10, label: 'Airline ID' } ],
           identification: [ { position: 10, label: 'Airline ID' } ], 
           selectionField: [ { position: 10 } ] }
    key carrid as AirlineID,

    @UI: { lineItem:       [ { position: 20, label: 'Airline Name' } ],
           identification: [ { position: 20, label: 'Airline Name' } ] } 
    carrname as AirlineName,

    @UI: { lineItem:       [ { position: 30, label: 'Currency Code' } ],
           identification: [ { position: 30, label: 'Currency Code' } ] } 
    currency_code as CurrencyCode,
    
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    last_changed_at as LastChangedAt,
    
    _Singleton

}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SERVICE EMAIL ROOT VIEW'
@UI.headerInfo: { typeName: 'Service', typeNamePlural: 'Services' }
define root view entity ZI_026_SERVICE_EMAIL as select from z026_email_table
{
    @UI.facet: [ { id: 'idService', type: #IDENTIFICATION_REFERENCE, label: 'Service Details', position: 10 } ]

    @UI: { lineItem: [ { position: 10, label: 'Service Number' } ],
           identification: [ { position: 10 } ],
           selectionField: [ { position: 10 } ] }
   
    key srv_num as ServiceNumber,

    @UI: { lineItem: [ { position: 20, label: 'Service Name' } ],
           identification: [ { position: 20 } ] }
    srv_name as ServiceName,

    @UI: { lineItem: [ { position: 30, label: 'Start Date' } ],
           identification: [ { position: 30 } ] }
    start_date as StartDate,

    @UI: { lineItem: [ { position: 40, label: 'End Date' } ],
           identification: [ { position: 40 } ] }
    end_date as EndDate,

    @Semantics.amount.currencyCode: 'Currency'
    @UI: { lineItem: [ { position: 50, label: 'Amount' },
                       { type: #FOR_ACTION, dataAction: 'sendEmail', label: 'Email' } ],
           identification: [ { position: 50 } ] }
    amount as Amount,

    currency as Currency
}

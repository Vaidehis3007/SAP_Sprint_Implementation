CLASS zcl_026_data_email DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_026_data_email IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lt_services TYPE TABLE OF z026_email_table.

    " 1. Clear existing data so we don't get 'Duplicate Key' errors
    DELETE FROM z026_email_table.

    " 2. Build your sample service data
    lt_services = VALUE #(
      ( srv_num    = 'SRV_100'
        srv_name   = 'Human Resource Bot'
        start_date = '20261102'
        end_date   = '20271230'
        amount     = '3450.00'
        currency   = 'INR' )

      ( srv_num    = 'SRV_101'
        srv_name   = 'Customer Support Email'
        start_date = '20260318'
        end_date   = '20261231'
        amount     = '141.50'
        currency   = 'USD' )

      ( srv_num    = 'SRV_102'
        srv_name   = 'Newsletter Automation Bot'
        start_date = '20260730'
        end_date   = '20271109'
        amount     = '569.00'
        currency   = 'EUR' )
    ).

    " 3. Insert into your database table
    INSERT z026_email_table FROM TABLE @lt_services.

    " 4. Output results to the console
    IF sy-subrc = 0.
      out->write( |SUCCESS: { lines( lt_services ) } Service records inserted into z026_email_table!| ).
    ELSE.
      out->write( 'Error occurred during data insertion.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.

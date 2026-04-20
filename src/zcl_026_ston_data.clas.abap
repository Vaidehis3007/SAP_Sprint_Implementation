CLASS zcl_026_ston_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_026_ston_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lt_carriers TYPE TABLE OF z026_child_ston.
    DATA: ls_singleton TYPE z026_header_ston.
    DATA: lv_timestamp TYPE timestampl.

    " 1. Get current timestamp
    GET TIME STAMP FIELD lv_timestamp.

    " 2. Clear all existing data and drafts so we have a clean slate
    DELETE FROM z026_header_ston.
    DELETE FROM z026_hston_d.
    DELETE FROM z026_child_ston.
    DELETE FROM z026_cston_d.

    " 3. INSERT THE SINGLETON PARENT ROW (ID = 1)
    ls_singleton-singleton_id = 1.
    ls_singleton-last_changed_at = lv_timestamp.
    INSERT z026_header_ston FROM @ls_singleton.

    " 4. Build the carrier data (Notice every row is linked to singleton_id = 1)
    lt_carriers = VALUE #(
      ( singleton_id = 1 carrid = 'EK' carrname = 'Emirates'           currency_code = 'AED' last_changed_at = lv_timestamp )
( singleton_id = 1 carrid = 'SQ' carrname = 'Singapore Airlines'  currency_code = 'SGD' last_changed_at = lv_timestamp )
( singleton_id = 1 carrid = 'LH' carrname = 'Lufthansa'           currency_code = 'EUR' last_changed_at = lv_timestamp )
( singleton_id = 1 carrid = 'QR' carrname = 'Qatar Airways'       currency_code = 'QAR' last_changed_at = lv_timestamp )
( singleton_id = 1 carrid = 'NH' carrname = 'All Nippon Airways'  currency_code = 'JPY' last_changed_at = lv_timestamp )
( singleton_id = 1 carrid = 'CX' carrname = 'Cathay Pacific'      currency_code = 'HKD' last_changed_at = lv_timestamp )
( singleton_id = 1 carrid = 'QF' carrname = 'Qantas Airways'      currency_code = 'AUD' last_changed_at = lv_timestamp )
).

    " 5. Insert the carriers
    INSERT z026_child_ston FROM TABLE @lt_carriers.

    " 6. Output success message
    IF sy-subrc = 0.
      out->write( 'Successfully inserted the Singleton Header and Carrier records!' ).
    ELSE.
      out->write( 'Error inserting data.' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.



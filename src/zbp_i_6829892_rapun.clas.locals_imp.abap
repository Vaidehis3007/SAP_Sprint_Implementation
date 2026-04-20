CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA: ins TYPE TABLE OF z6829892_lfa1, " Holds rows to Create
                upd TYPE TABLE OF z6829892_lfa1, " Holds rows to Update
                del TYPE TABLE OF z6829892_lfa1. " Holds rows to Delete
ENDCLASS.
CLASS lcl_buffer IMPLEMENTATION.
ENDCLASS.

CLASS lhc_Vendor DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Vendor RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Vendor RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Vendor.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Vendor.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Vendor.

    METHODS read FOR READ
      IMPORTING keys FOR READ Vendor RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Vendor.

ENDCLASS.

CLASS lhc_Vendor IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD get_instance_authorizations.
    " Tell the Fiori app it's okay to show the Edit and Delete buttons
    LOOP AT keys INTO DATA(k).
      APPEND VALUE #( lifnr = k-lifnr
                      %update = if_abap_behv=>auth-allowed
                      %delete = if_abap_behv=>auth-allowed ) TO result.
    ENDLOOP.
  ENDMETHOD.

  METHOD create.
    " Grab whatever I typed on the Create screen and shove it into the 'ins' buffer
    LOOP AT entities INTO DATA(e).
      APPEND VALUE #( lifnr           = e-lifnr
                      name1           = e-name1
                      land1           = e-land1
                      ort01           = e-ort01
                      last_changed_at = utclong_current( )
                    ) TO lcl_buffer=>ins.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    LOOP AT entities INTO DATA(e).
      " Read the existing database row first so we don't accidentally wipe other columns blank
      SELECT SINGLE * FROM z6829892_lfa1 WHERE lifnr = @e-lifnr INTO @DATA(db_data).
      IF sy-subrc = 0.

        " The %control flag checks if we actually changed this specific box on the screen
        IF e-%control-name1 = if_abap_behv=>mk-on. db_data-name1 = e-name1. ENDIF.
        IF e-%control-land1 = if_abap_behv=>mk-on. db_data-land1 = e-land1. ENDIF.
        IF e-%control-ort01 = if_abap_behv=>mk-on. db_data-ort01 = e-ort01. ENDIF.

        db_data-last_changed_at = utclong_current( ).

        " Push the updated row to the 'upd' buffer
        APPEND db_data TO lcl_buffer=>upd.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    " Grab the Vendor number clicked on and push it to the 'del' buffer
    LOOP AT keys INTO DATA(k).
      APPEND VALUE #( lifnr = k-lifnr ) TO lcl_buffer=>del.
    ENDLOOP.
  ENDMETHOD.

  METHOD lock.
    " Leaving this empty is fine, but deleting it causes a crash.
  ENDMETHOD.

  METHOD read.
    " Fiori uses this to check the ETag (last_changed_at) before saving.
    LOOP AT keys INTO DATA(k).
      SELECT SINGLE * FROM z6829892_lfa1 WHERE lifnr = @k-lifnr INTO @DATA(db_data).
      IF sy-subrc = 0.
        APPEND VALUE #( lifnr           = db_data-lifnr
                        name1           = db_data-name1
                        land1           = db_data-land1
                        ort01           = db_data-ort01
                        last_changed_at = db_data-last_changed_at ) TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

* ======================================================================
* 3. THE SAVER (Save Phase - Hits the Database)
* ======================================================================
CLASS lsc_ZI_6829892_RAPUN DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS finalize REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save REDEFINITION.
    METHODS cleanup REDEFINITION.
    METHODS cleanup_finalize REDEFINITION.
ENDCLASS.

CLASS lsc_ZI_6829892_RAPUN IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

  METHOD save.
    " If insert buffer has data, INSERT it into the real table.
    IF lcl_buffer=>ins IS NOT INITIAL.
      INSERT z6829892_lfa1 FROM TABLE @lcl_buffer=>ins.
    ENDIF.

    " If update buffer has data, UPDATE the real table.
    IF lcl_buffer=>upd IS NOT INITIAL.
      UPDATE z6829892_lfa1 FROM TABLE @lcl_buffer=>upd.
    ENDIF.

    " If delete buffer has data, loop through and DELETE from the real table.
    IF lcl_buffer=>del IS NOT INITIAL.
      LOOP AT lcl_buffer=>del INTO DATA(d).
        DELETE FROM z6829892_lfa1 WHERE lifnr = @d-lifnr.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
    " Wipe temp storage clean after saving
    CLEAR: lcl_buffer=>ins, lcl_buffer=>upd, lcl_buffer=>del.
  ENDMETHOD.

ENDCLASS.

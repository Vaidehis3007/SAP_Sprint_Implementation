CLASS lhc_Service DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Service RESULT result.

    METHODS sendEmail FOR MODIFY
      IMPORTING keys FOR ACTION Service~sendEmail RESULT result.
ENDCLASS.

CLASS lhc_Service IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD sendEmail.
    " 1. Get the data for the selected row
    READ ENTITIES OF ZI_026_SERVICE_EMAIL IN LOCAL MODE
      ENTITY Service
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_services).

    LOOP AT lt_services INTO DATA(ls_service).
      " 2. Get the Email ID typed by the user in the popup
      DATA(lv_email) = keys[ sy-tabix ]-%param-email_address.

      " 3. Send Email using the NEW ABAP Cloud API
      TRY.
          DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).

          lo_mail->set_sender( 'noreply@capgemini.com' ).
          lo_mail->add_recipient( iv_address = CONV #( lv_email ) ).

          lo_mail->set_subject( 'Service Details' ).
          lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
                               iv_content      = |Service Number: { ls_service-ServiceNumber } \n Service Name: { ls_service-ServiceName }|
                               iv_content_type = 'text/plain' ) ).

          lo_mail->send( ).

        CATCH cx_bcs_mail INTO DATA(lx_mail_error).
        CATCH cx_root INTO DATA(lx_error).
      ENDTRY.

      " 4. Return result to UI
      APPEND VALUE #( %tky = ls_service-%tky %param = ls_service ) TO result.

      " 5. Trigger the Green Success Message in Fiori
      APPEND VALUE #( %tky = ls_service-%tky
                      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                    text     = 'Email action processed by ABAP Cloud.' )
                    ) TO reported-service.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

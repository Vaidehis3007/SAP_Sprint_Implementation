CLASS zcl_026_proxy_consume DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_026_proxy_consume IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Your generated proxy table type
    DATA: lt_products TYPE TABLE OF  Z026_PROXY_NORTHWIND=>tys_product.

    TRY.
        " 1. Point to the Destination you created in BTP Cockpit
        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://services.odata.org' ).

        " 2. Create the HTTP Client
        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        " 3. Initialize the Proxy using the NEW /IWBEP/ framework
        DATA(lo_client_proxy) = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
            EXPORTING
              is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                  proxy_model_id      = 'Z026_PROXY_NORTHWIND'
                                                  proxy_model_version = '0001' )
              io_http_client           = lo_http_client
              iv_relative_service_root = '/V2/Northwind/Northwind.svc' ).

        " 4. Prepare the Request for the "Products" table
       DATA(lo_request) = lo_client_proxy->create_resource_for_entity_set( 'PRODUCTS' )->create_request_for_read( ).

        " 5. Execute and fetch data
        DATA(lo_response) = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = lt_products ).

        " 6. Print the results to the Eclipse Console
        out->write( |SUCCESS! Fetched { lines( lt_products ) } products from the internet:| ).
        out->write( |---------------------------------------------------| ).

        LOOP AT lt_products INTO DATA(ls_product) FROM 1 TO 10.
          out->write( |Product ID: { ls_product-product_id } - Name: { ls_product-product_name }| ).
        ENDLOOP.

      CATCH cx_root INTO DATA(lx_err).
        out->write( |Connection Error: { lx_err->get_text( ) }| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

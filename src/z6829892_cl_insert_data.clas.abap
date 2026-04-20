CLASS z6829892_cl_insert_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS z6829892_cl_insert_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: ls_lfa1 TYPE z6829892_lfa1,
          ls_eina TYPE z6829892_eina,
          ls_makt TYPE z6829892_makt.

    DELETE FROM z6829892_lfa1.
    DELETE FROM z6829892_eina.
    DELETE FROM z6829892_makt.

    " ==========================================
    " LFA1 - Vendor Master (General Section)
    " ==========================================
    ls_lfa1-mandt = sy-mandt.

    ls_lfa1-lifnr = '0000001000'.
    ls_lfa1-land1 = 'DE'.
    ls_lfa1-name1 = 'C.E.B. BERLIN'.
    ls_lfa1-ort01 = 'Berlin'.
    INSERT z6829892_lfa1 FROM @ls_lfa1.

    ls_lfa1-lifnr = '0000001001'.
    ls_lfa1-land1 = 'DE'.
    ls_lfa1-name1 = 'Müller KG'.
    ls_lfa1-ort01 = 'Rosenheim'.
    INSERT z6829892_lfa1 FROM @ls_lfa1.

    ls_lfa1-lifnr = '0000001002'.
    ls_lfa1-land1 = 'US'.
    ls_lfa1-name1 = 'Gusswerk US'.
    ls_lfa1-ort01 = 'HARBOR CITY'.
    INSERT z6829892_lfa1 FROM @ls_lfa1.

    " ==========================================
    " EINA - Purchasing Info Record General
    " ==========================================
    CLEAR ls_eina.
    ls_eina-mandt = sy-mandt.

    " Vendor 1000
    ls_eina-lifnr = '0000001000'.
    ls_eina-infnr = '5300000002'. ls_eina-matnr = '1300-350'. ls_eina-matkl = '00101'. ls_eina-anzpu = 100. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300000003'. ls_eina-matnr = '1300-351'. ls_eina-matkl = '00101'. ls_eina-anzpu = 200. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300000004'. ls_eina-matnr = '1300-352'. ls_eina-matkl = '00102'. ls_eina-anzpu = 300. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300000005'. ls_eina-matnr = '1300-360'. ls_eina-matkl = '00102'. ls_eina-anzpu = 400. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300000006'. ls_eina-matnr = '1300-361'. ls_eina-matkl = '00103'. ls_eina-anzpu = 500. INSERT z6829892_eina FROM @ls_eina.

    " Vendor 1001
    ls_eina-lifnr = '0000001001'.
    ls_eina-infnr = '5300001171'. ls_eina-matnr = '40-110C'.  ls_eina-matkl = '00101'. ls_eina-anzpu = 100. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300001172'. ls_eina-matnr = '40-110F'.  ls_eina-matkl = '00101'. ls_eina-anzpu = 200. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300001173'. ls_eina-matnr = '40-110R'.  ls_eina-matkl = '00102'. ls_eina-anzpu = 300. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300001174'. ls_eina-matnr = '40-110Y'.  ls_eina-matkl = '00102'. ls_eina-anzpu = 400. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300001182'. ls_eina-matnr = '40-220C'.  ls_eina-matkl = '00103'. ls_eina-anzpu = 500. INSERT z6829892_eina FROM @ls_eina.

    " Vendor 1002
    ls_eina-lifnr = '0000001002'.
    ls_eina-infnr = '5300001364'. ls_eina-matnr = 'SK-200'.   ls_eina-matkl = '00101'. ls_eina-anzpu = 100. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300001365'. ls_eina-matnr = 'SK-300'.   ls_eina-matkl = '00101'. ls_eina-anzpu = 200. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300001366'. ls_eina-matnr = 'SK-400'.   ls_eina-matkl = '00102'. ls_eina-anzpu = 300. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300001367'. ls_eina-matnr = 'SK-500'.   ls_eina-matkl = '00102'. ls_eina-anzpu = 400. INSERT z6829892_eina FROM @ls_eina.
    ls_eina-infnr = '5300001368'. ls_eina-matnr = 'SK-600'.   ls_eina-matkl = '00103'. ls_eina-anzpu = 500. INSERT z6829892_eina FROM @ls_eina.

    " ==========================================
    " MAKT - Material Description
    " ==========================================
    CLEAR ls_makt.
    ls_makt-mandt = sy-mandt.
    ls_makt-spras = 'E'.

    ls_makt-matnr = '1300-350'. ls_makt-maktx = 'HD GLAD BOY Standard seat'.            INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = '1300-351'. ls_makt-maktx = 'HD GLAD BOY seat deluxe leather solo'. INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = '1300-352'. ls_makt-maktx = 'HD GLAD BOY seat leather pillow-look'. INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = '1300-360'. ls_makt-maktx = 'HD windshield compact'.                INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = '1300-361'. ls_makt-maktx = 'HD Kingsize windshield'.               INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = '1300-370'. ls_makt-maktx = 'HD Leather saddle bag--fringed'.       INSERT z6829892_makt FROM @ls_makt.

    ls_makt-matnr = '40-110C'.  ls_makt-maktx = '40 W clear ,220-235V e27 MIG Carto.n'. INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = '40-110F'.  ls_makt-maktx = '220-235V 40-watt frosted e27 MIG box'. INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = '40-110R'.  ls_makt-maktx = '220-235V 40-watt red e27 MIG box'.     INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = '40-110Y'.  ls_makt-maktx = '220-235V 40-watt yellow e27 MIG box'.  INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = '40-220C'.  ls_makt-maktx = '40 W clear 220-235V e27 MIG Carton'.   INSERT z6829892_makt FROM @ls_makt.

    ls_makt-matnr = 'SK-200'.   ls_makt-maktx = 'Doors'.                                INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = 'SK-300'.   ls_makt-maktx = 'Mechanical equipment for person elevator'. INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = 'SK-400'.   ls_makt-maktx = 'Rope for cabin mechanism'.             INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = 'SK-500'.   ls_makt-maktx = 'Person elevator mechanism'.            INSERT z6829892_makt FROM @ls_makt.
    ls_makt-matnr = 'SK-600'.   ls_makt-maktx = 'Cubicle electronics control'.          INSERT z6829892_makt FROM @ls_makt.

    COMMIT WORK.

    out->write( 'All Data Inserted Successfully into LFA1, EINA, and MAKT' ).

  ENDMETHOD.

ENDCLASS.

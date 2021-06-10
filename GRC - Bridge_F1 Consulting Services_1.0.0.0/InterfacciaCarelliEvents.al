codeunit 50150 "Interfaccia Carelli"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnAfterChangeStatusOnProdOrder', '', false, false)]
    local procedure InsertLinesOnAfterRelease()
    var
        InterfacciaCarelli: Record "Interfaccia carelli";
        InterfacciaCarelli2: Record "Interfaccia carelli";
        InputDate: Date;
        NrOdp: Text;
        StrOrdine: Text;
        IntAnno: Integer;
        StrAnno: Text;
        FinalAnno: Text;
        LineNo: Integer;
        Bin: Record Bin;
        UnitaStockkeeping: Record "Stockkeeping Unit";
        ProdOrderLine: Record "Prod. Order Line";
        ProductionOrder: Record "Production Order";
    begin
        InterfacciaCarelli.Init();
        InterfacciaCarelli.Validate("Nr. Odp", ProductionOrder."No.");
        StrOrdine := Format(InterfacciaCarelli."Nr. Odp");
        InterfacciaCarelli."Nr. Odp" := StrOrdine.Substring(6, 4);

        InputDate := DT2Date(ProductionOrder.SystemModifiedAt);
        IntAnno := Date2DMY(InputDate, 3);
        StrAnno := Format(IntAnno);
        FinalAnno := DelStr(StrAnno, 1, 2);
        InterfacciaCarelli.Validate(Anno, FinalAnno);

        ProdOrderLine.Reset();
        ProdOrderLine.SetRange(Status, ProductionOrder.Status::Released);
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdOrderLine.Findset() then
            repeat
                InterfacciaCarelli."Qta da pesare" := ProdOrderLine.Quantity;
                InterfacciaCarelli."Codice prodotto" := ProdOrderLine."Item No.";

                //>01062021 AM added Operatore as user who created the order
                InterfacciaCarelli.Operatore := Format(ProdOrderLine.SystemCreatedBy);
                //<01062021 AM

                UnitaStockkeeping.Reset();
                UnitaStockkeeping.SetRange("Item No.", ProdOrderLine."Item No.");
                UnitaStockkeeping.SetRange("Variant Code", ProdOrderLine."Variant Code");
                UnitaStockkeeping.SetFilter("Location Code", 'LA');
                if UnitaStockkeeping.FindSet() then begin
                    InterfacciaCarelli."Ubicazione materia" := UnitaStockkeeping."Shelf No.";
                    InterfacciaCarelli.Fase := '30';
                end else begin
                    InterfacciaCarelli.Fase := '30';
                end;

                if Bin.Get(UnitaStockkeeping."Location Code", UnitaStockkeeping."Shelf No.") then
                    InterfacciaCarelli."Posizione Cremagliera" := Bin."Posizione di carico";

                InterfacciaCarelli.Insert();
                LineNo += 10000;
            until ProdOrderLine.Next() = 0;
        LineNo += 10000;
        InterfacciaCarelli2.Init();
        InterfacciaCarelli2.Validate(Anno, FinalAnno);
        InterfacciaCarelli2.Validate("Nr. Odp", StrOrdine.Substring(6, 4));
        InterfacciaCarelli2.Validate("Posizione Cremagliera", 9999);
        InterfacciaCarelli2.Insert();
    end;

    //to analise
    procedure ScanBarCode()
    var
        BarcodeScanner: Record "Barcode Encode Settings";
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
    begin

    end;
}
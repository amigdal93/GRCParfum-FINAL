page 50150 "Interfaccia carelli"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Interfaccia carelli";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Anno; Rec.Anno)
                {
                    ApplicationArea = All;
                }
                field("Nr. Odp"; Rec."Nr. Odp")
                {
                    ApplicationArea = All;
                }
                field(Carrello; Rec.Carrello)
                {
                    ApplicationArea = All;
                }
                field("Nome recipiente"; Rec."Nome recipiente")
                {
                    ApplicationArea = All;
                }
                field(Frazionamento; Rec.Frazionamento)
                {
                    ApplicationArea = All;
                }
                field(Fase; Rec.Fase)
                {
                    ApplicationArea = All;
                }
                field("Posizione Ctremagliera"; Rec."Posizione Cremagliera")
                {
                    ApplicationArea = All;
                }
                field("Ubicazione materia"; Rec."Ubicazione materia")
                {
                    ApplicationArea = All;
                }
                field("Qta da pesare"; Rec."Qta da pesare")
                {
                    ApplicationArea = All;
                }
                field("Qta pesata"; Rec."Qta pesata")
                {
                    ApplicationArea = All;
                }
                field(Lotto; Rec.Lotto)
                {
                    ApplicationArea = All;
                }
                field(SottoLotto; Rec.SottoLotto)
                {
                    ApplicationArea = All;
                }
                field("Cambio Loto"; Rec."Cambio Loto")
                {
                    ApplicationArea = All;
                }
                field("Qta da cambio lotto"; Rec."Qta da cambio lotto")
                {
                    ApplicationArea = All;
                }
                field("Codice prodotto"; Rec."Codice prodotto")
                {
                    ApplicationArea = All;
                }
                field("Descrizione prodotto"; Rec."Descrizione prodotto")
                {
                    ApplicationArea = All;
                }
                field(Verificato; Rec.Verificato)
                {
                    ApplicationArea = All;
                }
                field("Data ultima manutenzione"; Rec."Data ultima manutenzione")
                {
                    ApplicationArea = All;
                }
                field("Ora ultima manutenzione"; Rec."Ora ultima manutenzione")
                {
                    ApplicationArea = All;
                }
                field(Operatore; Rec.Operatore)
                {
                    ApplicationArea = All;
                }
                field("Terminalino usato"; Rec."Terminalino usato")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Scan barcode")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    InterfacciaCarelli: Codeunit "Interfaccia Carelli";
                begin
                    InterfacciaCarelli.ScanBarCode();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Data ultima manutenzione" := DT2Date(Rec.SystemCreatedAt);
        Rec."Ora ultima manutenzione" := DT2Time(Rec.SystemCreatedAt);
        Rec.Modify();
    end;
}
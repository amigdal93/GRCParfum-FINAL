table 50150 "Interfaccia carelli"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Anno; Text[10])
        {
        }
        field(2; "Nr. Odp"; Code[20])
        {
        }
        field(3; Carrello; Code[4])
        {
        }
        field(4; "Nome recipiente"; Code[3])
        {
        }
        field(5; Frazionamento; Enum Frazionamento)
        {
        }
        field(6; Fase; Code[20])
        {
            TableRelation = "Work Center"."No.";
        }
        field(7; "Posizione Cremagliera"; Integer)
        {
        }
        field(8; "Ubicazione materia"; Code[10])
        {
        }
        field(9; "Qta da pesare"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            BlankZero = true;
        }
        field(10; "Qta pesata"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            InitValue = 0;
        }
        field(11; "Codice prodotto"; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                CalcFields("Descrizione prodotto");
            end;
        }
        field(12; "Descrizione prodotto"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Codice prodotto")));
        }
        field(13; Verificato; Boolean)
        {
            InitValue = false;
        }
        field(14; "Data ultima manutenzione"; Date)
        {
        }
        field(15; "Ora ultima manutenzione"; Time)
        {
        }
        field(16; Lotto; Integer)
        {
        }
        field(17; SottoLotto; Integer)
        {
            InitValue = 0;
        }
        field(18; "Cambio Loto"; Boolean)
        {
        }
        field(19; "Qta da cambio lotto"; Integer)
        {
            InitValue = 0;
        }
        field(20; Operatore; Guid)
        {
        }
        field(21; "Terminalino usato"; Code[10])
        {
        }

    }

    keys
    {
        key(PK; "Nr. Odp", "Posizione Cremagliera", "Codice prodotto")
        {
            Clustered = true;
        }
    }
}
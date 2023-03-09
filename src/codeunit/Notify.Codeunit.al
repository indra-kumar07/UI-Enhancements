codeunit 50110 "Notify"
{
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeValidateEvent', 'Posting Date', false, false)]
    local procedure NotifyUser(var Rec: Record "Purchase Header";var xRec: Record "Purchase Header")
    var
        PurchaseDateChangeCheck : Notification;
        DateChangeMessageMsg : Label 'Posting Date Changed From %1 to %2 which is not same as Order Date %3', comment = '%1 - Current Posting Date; %2 - Previous Posting Date; %3 - Order Date';
    begin
        if Rec."Posting Date" <> Rec."Order Date" then begin
            PurchaseDateChangeCheck.Id := 'CDEF7890-ABCD-0123-1234-567890ABCDEF';
            PurchaseDateChangeCheck.Recall();            
            PurchaseDateChangeCheck.Message := StrSubstNo(DateChangeMessageMsg,xRec."Posting Date",Rec."Posting Date",Rec."Order Date");
            PurchaseDateChangeCheck.Scope := PurchaseDateChangeCheck.Scope::LocalScope;
            PurchaseDateChangeCheck.Send();
        end
        else begin
            PurchaseDateChangeCheck.Id := 'CDEF7890-ABCD-0123-1234-567890ABCDEF';
            PurchaseDateChangeCheck.Recall();
        end;
    end;
}

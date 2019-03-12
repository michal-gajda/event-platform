import { Component, OnInit, ViewChild } from "@angular/core";
import { select, Store } from "@ngrx/store";
import { getAddLoading, getFlashouts, getLoading, getSchools, State } from "./store/flashout-edit.reducer";
import { FlashoutEditDto } from "./components/flashout-form/dto/flashout-edit.dto";
import { AddFlashout, LoadFlashouts, LoadSchools } from "./store/flashout-edit.actions";
import { FlashoutFormComponent } from "./components/flashout-form/flashout-form.component";

@Component({
    selector: "app-flashout-add",
    templateUrl: "flashout-edit.template.html",
    styleUrls: ["./flashout-edit.style.scss"]
})
export class FlashoutEditComponent implements OnInit {
    @ViewChild(FlashoutFormComponent)
    private form: FlashoutFormComponent;

    flashouts$ = this.store$.pipe(select(getFlashouts));
    loading$ = this.store$.pipe(select(getLoading));
    addLoading$ = this.store$.pipe(select(getAddLoading));
    schools$ = this.store$.pipe(select(getSchools));

    public showCreateFlashoutCard = false;
    public dto = new FlashoutEditDto();

    constructor(private store$: Store<State>) {}

    public ngOnInit() {
        this.store$.dispatch(new LoadFlashouts());
        this.store$.dispatch(new LoadSchools());
    }

    public clickAddFlashout() {
        this.showCreateFlashoutCard = true;
    }

    public onCancelFlashout() {
        this.dto = new FlashoutEditDto();
        this.showCreateFlashoutCard = false;
    }

    public onAdd() {
        if (!this.form.validate()) {
            return;
        }
        this.store$.dispatch(new AddFlashout(this.dto));
        this.onCancelFlashout();
    }
}

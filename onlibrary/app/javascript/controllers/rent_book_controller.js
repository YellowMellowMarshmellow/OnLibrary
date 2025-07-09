import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["dateInput", "form", "button"]

  connect() {
    console.log("RentBookController connected")
    if (this.hasDateTarget) {
      flatpickr(this.dateInputTarget, {
        mode: "range",
        dateFormat: "Y-m-d"
      })
    }
  }

  openForm(event) {
    event.preventDefault()
    if (this.hasFormTarget) {
      this.buttonTarget.classList.add("d-none")
      this.formTarget.classList.remove("d-none")
    }
  }
}

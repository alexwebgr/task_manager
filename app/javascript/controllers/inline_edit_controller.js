import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  submitForm(event) {
    if (event.key === "Enter") {
      event.preventDefault();
      this.element.requestSubmit();
    }
  }
}

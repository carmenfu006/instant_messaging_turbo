import { Controller } from 'stimulus'

export default class extends Controller {
  static values = { message: String };

  connect() {
    console.log(this.messageValue)
  }

  confirm(event) {
    if (!(window.confirm(this.messageValue))) {
      event.preventDefault();
      event.stopImmediatePropagation();
    };
  };
}
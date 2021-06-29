import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ['list', 'error']

  create(event) {
    // to check if the form has been successfully submitted
    // this has to do with your controller redirection
    // console.log(event.detail.formSubmission.result.fetchResponse.response.redirected)
    let response = event.detail.formSubmission.result.fetchResponse.response
    let redirected = response.redirected

    if (redirected) {
      let url = response.url
      let form = event.detail.formSubmission.formElement
      let board_name = form.querySelector('[id="board_name"]').value
      let board_id = url.split('=')[1]
      console.log()
      let element = document.createElement('div');
      let list = this.listTarget

      element.innerHTML = `<br>
                          <div class="single-board">
                            <a href="/boards/${board_id}">
                              ${board_name}
                            </a>  
                          </div>`

      list.appendChild(element);

    } else {
      this.errorTarget.textContent = 'Name cannot be blank'
    }
  }
}
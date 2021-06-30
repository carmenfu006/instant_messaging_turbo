import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ['list', 'image', 'error']

  create(event) {
    let response = event.detail.formSubmission.result.fetchResponse.response
    let redirected = response.redirected

    if (redirected) {
      let url = response.url;
      let form = event.detail.formSubmission.formElement;
      let pin_title = form.querySelector('[id="pin_title"]').value;
      let pin_id = url.split('=')[1];
      let attachment_input = form.querySelector('[id="pin_image"]');

      let element = document.createElement('div');
      let list = this.listTarget
          
      element.innerHTML = `<br>
                          <div class="single-pin">
                            <a href="/pins/${pin_id}">
                              <img style="width: 100px;" data-pin-target="image" src="">
                              ${pin_title}
                            </a>        
                          </div>`
      
      list.appendChild(element);

      if (attachment_input.files && attachment_input.files[0]) {
        let pinImage = this.imageTargets[this.imageTargets.length-1];
        let reader = new FileReader();

        reader.onload = function(e) {
          pinImage.src = e.target.result;
        }
  
        reader.readAsDataURL(attachment_input.files[0]);
      }
      
    } else {
      this.errorTarget.textContent = 'Image cannot be blank'
    }
  }
}
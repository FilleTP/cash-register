import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add('fade-out')
    }, 3000)

    this.element.addEventListener('transitionend', () => {
      console.log(this.element)
      this.element.remove()
    })
  }
}

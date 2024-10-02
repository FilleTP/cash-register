import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  increment() {
    let value = parseInt(this.inputTarget.value, 10)
    this.inputTarget.value = value + 1
  }

  decrement() {
    let value = parseInt(this.inputTarget.value, 10)
    if (value > 1) {
      this.inputTarget.value = value - 1
    }
  }
}

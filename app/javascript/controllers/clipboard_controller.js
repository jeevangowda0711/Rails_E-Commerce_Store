// app/javascript/conrollers/clipboard_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = { text: String }

    copy() {
        navigator.clipboard.writeText(this.textValue)
    }
}

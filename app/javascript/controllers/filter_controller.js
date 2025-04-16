import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle"]

  toggle() {
    const showPublished = this.toggleTarget.checked
    const url = new URL(window.location)
    if (showPublished) {
      url.searchParams.set("published", "1")
    } else {
      url.searchParams.delete("published")
    }
    Turbo.visit(url.toString())
  }
}

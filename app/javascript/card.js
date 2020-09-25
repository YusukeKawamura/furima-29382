const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY)
  const form = document.getElementById("charge-form")
  form.addEventListener("submit", (e) => {
    e.preventDefault()

    const formResult = document.getElementById("charge-form")
    const formData = new FormData(formResult)

    const card = {
      card_number: formData.get("card_number"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
      card_cvc: formData.get("card_cvc"),
    }

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id
        const renderDom = document.getElementById("charge-form")
        const tokenObj = `<input value=${token} type="hidden" name='token'>`
        renderDom.insertAdjacentHTML("beforeend", tokenObj)
      }
    })
  })
}
addEventListener("load", pay)
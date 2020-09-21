function calc() {
  const calcTax = document.getElementById("item-price")
  const putTax = document.getElementById("add-tax-price")
  const putProfit = document.getElementById("profit")
  calcTax.addEventListener('input', function () {
    const Price = document.getElementById("item-price").value
    const Tax = parseInt(Price / 10)
    putTax.innerText = Tax
    putProfit.innerText = Price - Tax
  })
}
addEventListener("load", calc) 
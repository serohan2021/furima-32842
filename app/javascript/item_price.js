window.addEventListener('input', () => {
  const priceInput = document.getElementById('item-price');
  const addTaxDom = document.getElementById("add-tax-price");
  const salesProfit = document.getElementById("profit");

  const inputValue = priceInput.value;
  const taxDomValue = Math.floor(inputValue * 0.1);
  const profitValue = Math.floor(inputValue - taxDomValue);

  addTaxDom.innerHTML = taxDomValue.toLocaleString();
  salesProfit.innerHTML = profitValue.toLocaleString();

})

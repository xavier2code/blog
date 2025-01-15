function debounce(func, wait) {
  var timeout;

  return function () {
    var context = this;
    var args = arguments;
    clearTimeout(timeout);

    timeout = setTimeout(function () {
      timeout = null;
      func.apply(context, args);

    }, wait);
  };
}

function makeTeaser(body, terms) {

}

function formatSearchResultItem(item, terms) {

}

function initSearch() {

}

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

// 行儀が悪いが、グローバルに展開してしまう
import { handleEnterKeypressListItem, handleClickListItem, handleDeleteListItem, clear_form, updateItemPerPage, handleOnChangePagyItemsSelectorJs } from "./ya-common"
window.handleEnterKeypressListItem = handleEnterKeypressListItem;
window.handleClickListItem = handleClickListItem;
window.handleDeleteListItem = handleDeleteListItem;
window.clear_form = clear_form;
window.updateItemPerPage = updateItemPerPage;
window.handleOnChangePagyItemsSelectorJs = handleOnChangePagyItemsSelectorJs;


import "tom-select";

function initTomSelect() {
  document.querySelectorAll('select').forEach((e) => {
    if (!e.tomselect) {
      new TomSelect(e, {
        plugins: {
          remove_button: {
            title:'Remove this item',
          }
        },
        field: 'text',
        direction: 'asc'
      });
    }
  });
}

document.addEventListener('turbo:load', () => {
  initTomSelect();
});

document.addEventListener('turbo:render', () => {
  initTomSelect();
});


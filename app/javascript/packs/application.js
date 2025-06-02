

import Rails from "@rails/ujs"
Rails.start()

import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap/dist/js/bootstrap'
import "bootstrap"

import $ from 'jquery'
global.$ = jQuery;

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', () => {
  const dropdownToggle = document.querySelector('#dropdownMenuLink');
  const dropdownMenu = document.querySelector('#dropdownMenu');

  if (dropdownToggle && dropdownMenu) {
    // 初期状態でメニューを隠す
    dropdownMenu.classList.remove('show');

    dropdownToggle.addEventListener('click', (e) => {
      e.preventDefault();
      dropdownMenu.classList.toggle('show');
    });

    document.addEventListener('click', (e) => {
      if (!dropdownToggle.contains(e.target) && !dropdownMenu.contains(e.target)) {
        dropdownMenu.classList.remove('show');
      }
    });
  }
});



//console.log(dropdownToggle, dropdownMenu);

   

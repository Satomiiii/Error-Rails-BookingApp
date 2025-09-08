// app/javascript/packs/application.js

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

// （必要なら）Bootstrap の JS を使う場合
import "bootstrap";

// jQuery を他の場所で使っているなら残す
import $ from "jquery";
global.$ = $;

Rails.start();
Turbolinks.start();
ActiveStorage.start();

document.addEventListener("turbolinks:load", () => {
  const toggle = document.getElementById("dropdownMenuLink");
  const menu   = document.getElementById("dropdownMenu");

  if (!toggle || !menu) return;

  // 初期状態は閉じる
  menu.classList.remove("show");

  // クリックで開閉
  const onToggleClick = (e) => {
    e.preventDefault();
    e.stopPropagation(); // 直後の document クリックで閉じないように
    menu.classList.toggle("show");
  };
  toggle.addEventListener("click", onToggleClick);

  // メニュー外をクリックしたら閉じる
  const onDocClick = (e) => {
    if (!toggle.contains(e.target) && !menu.contains(e.target)) {
      menu.classList.remove("show");
    }
  };
  document.addEventListener("click", onDocClick);

  // ESC キーで閉じる
  const onKeyDown = (e) => {
    if (e.key === "Escape") menu.classList.remove("show");
  };
  document.addEventListener("keydown", onKeyDown);

  // Turbolinks のキャッシュに入る前に強制的に閉じる
  document.addEventListener("turbolinks:before-cache", () => {
    menu.classList.remove("show");
  }, { once: true });
});

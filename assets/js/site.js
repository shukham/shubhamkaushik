(() => {
  "use strict";

  const root = document.documentElement;

  // Theme: an explicit choice is remembered; otherwise the OS setting applies.
  const themeToggle = document.querySelector("[data-theme-toggle]");
  const prefersDark = window.matchMedia("(prefers-color-scheme: dark)");

  themeToggle?.addEventListener("click", () => {
    const current = root.dataset.theme || (prefersDark.matches ? "dark" : "light");
    const next = current === "dark" ? "light" : "dark";
    root.dataset.theme = next;
    try {
      localStorage.setItem("theme", next);
    } catch (error) {
      // Storage can be unavailable (private mode); the choice lasts for this page only.
    }
  });

  // Mobile navigation menu.
  const navToggle = document.querySelector("[data-nav-toggle]");
  const nav = navToggle && document.getElementById(navToggle.getAttribute("aria-controls"));

  const setNavOpen = (open) => {
    navToggle.setAttribute("aria-expanded", String(open));
    navToggle.setAttribute("aria-label", open ? "Close menu" : "Open menu");
    nav.classList.toggle("is-open", open);
  };

  if (nav) {
    navToggle.addEventListener("click", () => {
      setNavOpen(navToggle.getAttribute("aria-expanded") !== "true");
    });
    document.addEventListener("keydown", (event) => {
      if (event.key === "Escape" && nav.classList.contains("is-open")) {
        setNavOpen(false);
        navToggle.focus();
      }
    });
  }

  // Expandable publication panels (abstract, citation).
  document.querySelectorAll("[data-toggle]").forEach((button) => {
    const panel = document.getElementById(button.getAttribute("aria-controls"));
    button.addEventListener("click", () => {
      const open = button.getAttribute("aria-expanded") !== "true";
      button.setAttribute("aria-expanded", String(open));
      panel.hidden = !open;
    });
  });

  // Copy a citation to the clipboard; where the clipboard API is unavailable,
  // select the text so it can be copied manually.
  document.querySelectorAll("[data-copy]").forEach((button) => {
    const label = button.querySelector("span");
    const source = document.getElementById(button.dataset.copy);
    button.addEventListener("click", async () => {
      try {
        await navigator.clipboard.writeText(source.textContent);
        label.textContent = "Copied";
      } catch (error) {
        window.getSelection().selectAllChildren(source);
        label.textContent = "Selected";
      }
      setTimeout(() => {
        label.textContent = "Copy";
      }, 2000);
    });
  });
})();

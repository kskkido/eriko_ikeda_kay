import "../css/app.scss";

const main = (w) => {
  const toggles = [...w.document.querySelectorAll("[aria-expanded]")];
  const overlays = [...w.document.querySelectorAll("#page-body-overlay")];

  const subscriptions = [
    (() => {
      const handleKeyDown = (event) => {
        if (event.defaultPrevented) {
          return;
        }
        switch (event.key) {
          case "Escape": {
            for (const toggle of toggles) {
              toggle.setAttribute("aria-expanded", "false");
            }
          }
        }
      };
      w.addEventListener("keydown", handleKeyDown);
      return () => {
        w.removeEventListener("keydown", handleKeyDown);
      };
    })(),
    ...toggles.map((toggle) => {
      const handleClick = () => {
        const expanded = toggle.getAttribute("aria-expanded") === "true";
        if (expanded) {
          toggle.setAttribute("aria-expanded", "false");
        } else {
          toggle.setAttribute("aria-expanded", "true");
        }
      };
      toggle.addEventListener("click", handleClick);
      return () => {
        toggle.removeEventListener("click", handleClick);
      };
    }),
    ...overlays.map((overlay) => {
      const handleClick = () => {
        for (const toggle of toggles) {
          toggle.setAttribute("aria-expanded", "false");
        }
      };
      overlay.addEventListener("click", handleClick);
      return () => {
        overlay.removeEventListener("click", handleClick);
      };
    }),
  ];

  return subscriptions.reduce(
    (subscription, acc) => () => {
      subscription();
      acc();
    },
    () => {},
  );
};

window.addEventListener("DOMContentLoaded", () => {
  main(window);
});

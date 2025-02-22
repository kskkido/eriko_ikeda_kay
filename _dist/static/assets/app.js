(() => {
  // js/app.js
  var main = (w) => {
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
      })
    ];
    return subscriptions.reduce(
      (subscription, acc) => () => {
        subscription();
        acc();
      },
      () => {
      }
    );
  };
  window.addEventListener("DOMContentLoaded", () => {
    main(window);
  });
})();
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsiLi4vLi4vLi4vYXNzZXRzL2pzL2FwcC5qcyJdLAogICJzb3VyY2VzQ29udGVudCI6IFsiaW1wb3J0IFwiLi4vY3NzL2FwcC5zY3NzXCI7XG5cbmNvbnN0IG1haW4gPSAodykgPT4ge1xuICBjb25zdCB0b2dnbGVzID0gWy4uLncuZG9jdW1lbnQucXVlcnlTZWxlY3RvckFsbChcIlthcmlhLWV4cGFuZGVkXVwiKV07XG4gIGNvbnN0IG92ZXJsYXlzID0gWy4uLncuZG9jdW1lbnQucXVlcnlTZWxlY3RvckFsbChcIiNwYWdlLWJvZHktb3ZlcmxheVwiKV07XG5cbiAgY29uc3Qgc3Vic2NyaXB0aW9ucyA9IFtcbiAgICAoKCkgPT4ge1xuICAgICAgY29uc3QgaGFuZGxlS2V5RG93biA9IChldmVudCkgPT4ge1xuICAgICAgICBpZiAoZXZlbnQuZGVmYXVsdFByZXZlbnRlZCkge1xuICAgICAgICAgIHJldHVybjtcbiAgICAgICAgfVxuICAgICAgICBzd2l0Y2ggKGV2ZW50LmtleSkge1xuICAgICAgICAgIGNhc2UgXCJFc2NhcGVcIjoge1xuICAgICAgICAgICAgZm9yIChjb25zdCB0b2dnbGUgb2YgdG9nZ2xlcykge1xuICAgICAgICAgICAgICB0b2dnbGUuc2V0QXR0cmlidXRlKFwiYXJpYS1leHBhbmRlZFwiLCBcImZhbHNlXCIpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgfTtcbiAgICAgIHcuYWRkRXZlbnRMaXN0ZW5lcihcImtleWRvd25cIiwgaGFuZGxlS2V5RG93bik7XG4gICAgICByZXR1cm4gKCkgPT4ge1xuICAgICAgICB3LnJlbW92ZUV2ZW50TGlzdGVuZXIoXCJrZXlkb3duXCIsIGhhbmRsZUtleURvd24pO1xuICAgICAgfTtcbiAgICB9KSgpLFxuICAgIC4uLnRvZ2dsZXMubWFwKCh0b2dnbGUpID0+IHtcbiAgICAgIGNvbnN0IGhhbmRsZUNsaWNrID0gKCkgPT4ge1xuICAgICAgICBjb25zdCBleHBhbmRlZCA9IHRvZ2dsZS5nZXRBdHRyaWJ1dGUoXCJhcmlhLWV4cGFuZGVkXCIpID09PSBcInRydWVcIjtcbiAgICAgICAgaWYgKGV4cGFuZGVkKSB7XG4gICAgICAgICAgdG9nZ2xlLnNldEF0dHJpYnV0ZShcImFyaWEtZXhwYW5kZWRcIiwgXCJmYWxzZVwiKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICB0b2dnbGUuc2V0QXR0cmlidXRlKFwiYXJpYS1leHBhbmRlZFwiLCBcInRydWVcIik7XG4gICAgICAgIH1cbiAgICAgIH07XG4gICAgICB0b2dnbGUuYWRkRXZlbnRMaXN0ZW5lcihcImNsaWNrXCIsIGhhbmRsZUNsaWNrKTtcbiAgICAgIHJldHVybiAoKSA9PiB7XG4gICAgICAgIHRvZ2dsZS5yZW1vdmVFdmVudExpc3RlbmVyKFwiY2xpY2tcIiwgaGFuZGxlQ2xpY2spO1xuICAgICAgfTtcbiAgICB9KSxcbiAgICAuLi5vdmVybGF5cy5tYXAoKG92ZXJsYXkpID0+IHtcbiAgICAgIGNvbnN0IGhhbmRsZUNsaWNrID0gKCkgPT4ge1xuICAgICAgICBmb3IgKGNvbnN0IHRvZ2dsZSBvZiB0b2dnbGVzKSB7XG4gICAgICAgICAgdG9nZ2xlLnNldEF0dHJpYnV0ZShcImFyaWEtZXhwYW5kZWRcIiwgXCJmYWxzZVwiKTtcbiAgICAgICAgfVxuICAgICAgfTtcbiAgICAgIG92ZXJsYXkuYWRkRXZlbnRMaXN0ZW5lcihcImNsaWNrXCIsIGhhbmRsZUNsaWNrKTtcbiAgICAgIHJldHVybiAoKSA9PiB7XG4gICAgICAgIG92ZXJsYXkucmVtb3ZlRXZlbnRMaXN0ZW5lcihcImNsaWNrXCIsIGhhbmRsZUNsaWNrKTtcbiAgICAgIH07XG4gICAgfSksXG4gIF07XG5cbiAgcmV0dXJuIHN1YnNjcmlwdGlvbnMucmVkdWNlKFxuICAgIChzdWJzY3JpcHRpb24sIGFjYykgPT4gKCkgPT4ge1xuICAgICAgc3Vic2NyaXB0aW9uKCk7XG4gICAgICBhY2MoKTtcbiAgICB9LFxuICAgICgpID0+IHt9LFxuICApO1xufTtcblxud2luZG93LmFkZEV2ZW50TGlzdGVuZXIoXCJET01Db250ZW50TG9hZGVkXCIsICgpID0+IHtcbiAgbWFpbih3aW5kb3cpO1xufSk7XG4iXSwKICAibWFwcGluZ3MiOiAiOztBQUVBLE1BQU0sT0FBTyxDQUFDLE1BQU07QUFDbEIsVUFBTSxVQUFVLENBQUMsR0FBRyxFQUFFLFNBQVMsaUJBQWlCLGlCQUFpQixDQUFDO0FBQ2xFLFVBQU0sV0FBVyxDQUFDLEdBQUcsRUFBRSxTQUFTLGlCQUFpQixvQkFBb0IsQ0FBQztBQUV0RSxVQUFNLGdCQUFnQjtBQUFBLE9BQ25CLE1BQU07QUFDTCxjQUFNLGdCQUFnQixDQUFDLFVBQVU7QUFDL0IsY0FBSSxNQUFNLGtCQUFrQjtBQUMxQjtBQUFBLFVBQ0Y7QUFDQSxrQkFBUSxNQUFNLEtBQUs7QUFBQSxZQUNqQixLQUFLLFVBQVU7QUFDYix5QkFBVyxVQUFVLFNBQVM7QUFDNUIsdUJBQU8sYUFBYSxpQkFBaUIsT0FBTztBQUFBLGNBQzlDO0FBQUEsWUFDRjtBQUFBLFVBQ0Y7QUFBQSxRQUNGO0FBQ0EsVUFBRSxpQkFBaUIsV0FBVyxhQUFhO0FBQzNDLGVBQU8sTUFBTTtBQUNYLFlBQUUsb0JBQW9CLFdBQVcsYUFBYTtBQUFBLFFBQ2hEO0FBQUEsTUFDRixHQUFHO0FBQUEsTUFDSCxHQUFHLFFBQVEsSUFBSSxDQUFDLFdBQVc7QUFDekIsY0FBTSxjQUFjLE1BQU07QUFDeEIsZ0JBQU0sV0FBVyxPQUFPLGFBQWEsZUFBZSxNQUFNO0FBQzFELGNBQUksVUFBVTtBQUNaLG1CQUFPLGFBQWEsaUJBQWlCLE9BQU87QUFBQSxVQUM5QyxPQUFPO0FBQ0wsbUJBQU8sYUFBYSxpQkFBaUIsTUFBTTtBQUFBLFVBQzdDO0FBQUEsUUFDRjtBQUNBLGVBQU8saUJBQWlCLFNBQVMsV0FBVztBQUM1QyxlQUFPLE1BQU07QUFDWCxpQkFBTyxvQkFBb0IsU0FBUyxXQUFXO0FBQUEsUUFDakQ7QUFBQSxNQUNGLENBQUM7QUFBQSxNQUNELEdBQUcsU0FBUyxJQUFJLENBQUMsWUFBWTtBQUMzQixjQUFNLGNBQWMsTUFBTTtBQUN4QixxQkFBVyxVQUFVLFNBQVM7QUFDNUIsbUJBQU8sYUFBYSxpQkFBaUIsT0FBTztBQUFBLFVBQzlDO0FBQUEsUUFDRjtBQUNBLGdCQUFRLGlCQUFpQixTQUFTLFdBQVc7QUFDN0MsZUFBTyxNQUFNO0FBQ1gsa0JBQVEsb0JBQW9CLFNBQVMsV0FBVztBQUFBLFFBQ2xEO0FBQUEsTUFDRixDQUFDO0FBQUEsSUFDSDtBQUVBLFdBQU8sY0FBYztBQUFBLE1BQ25CLENBQUMsY0FBYyxRQUFRLE1BQU07QUFDM0IscUJBQWE7QUFDYixZQUFJO0FBQUEsTUFDTjtBQUFBLE1BQ0EsTUFBTTtBQUFBLE1BQUM7QUFBQSxJQUNUO0FBQUEsRUFDRjtBQUVBLFNBQU8saUJBQWlCLG9CQUFvQixNQUFNO0FBQ2hELFNBQUssTUFBTTtBQUFBLEVBQ2IsQ0FBQzsiLAogICJuYW1lcyI6IFtdCn0K

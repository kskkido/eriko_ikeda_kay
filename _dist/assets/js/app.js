(() => {
  // js/app.js
  var main = () => {
    const html = document.querySelector("html");
    const overlays = [...document.querySelectorAll(".overlay")];
    [
      ...document.querySelectorAll(".page-header-menu-icon[data-type='open']")
    ].forEach((icon) => {
      icon.addEventListener("click", () => {
        html.classList.add("no-scroll");
        window.scrollTo(0, 0);
        overlays.forEach((overlay) => {
          overlay.classList.add("visible");
        });
      });
    });
    [
      ...document.querySelectorAll(".page-header-menu-icon[data-type='close']")
    ].forEach((icon) => {
      icon.addEventListener("click", () => {
        html.classList.remove("no-scroll");
        overlays.forEach((overlay) => {
          overlay.classList.remove("visible");
        });
      });
    });
  };
  main();
})();
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsiLi4vLi4vLi4vLi4vYXNzZXRzL2pzL2FwcC5qcyJdLAogICJzb3VyY2VzQ29udGVudCI6IFsiaW1wb3J0IFwiLi4vY3NzL2FwcC5zY3NzXCI7XG5cbmNvbnN0IG1haW4gPSAoKSA9PiB7XG4gIGNvbnN0IGh0bWwgPSBkb2N1bWVudC5xdWVyeVNlbGVjdG9yKFwiaHRtbFwiKTtcbiAgY29uc3Qgb3ZlcmxheXMgPSBbLi4uZG9jdW1lbnQucXVlcnlTZWxlY3RvckFsbChcIi5vdmVybGF5XCIpXTtcbiAgW1xuICAgIC4uLmRvY3VtZW50LnF1ZXJ5U2VsZWN0b3JBbGwoXCIucGFnZS1oZWFkZXItbWVudS1pY29uW2RhdGEtdHlwZT0nb3BlbiddXCIpLFxuICBdLmZvckVhY2goKGljb24pID0+IHtcbiAgICBpY29uLmFkZEV2ZW50TGlzdGVuZXIoXCJjbGlja1wiLCAoKSA9PiB7XG4gICAgICBodG1sLmNsYXNzTGlzdC5hZGQoXCJuby1zY3JvbGxcIik7XG4gICAgICB3aW5kb3cuc2Nyb2xsVG8oMCwgMCk7XG4gICAgICBvdmVybGF5cy5mb3JFYWNoKChvdmVybGF5KSA9PiB7XG4gICAgICAgIG92ZXJsYXkuY2xhc3NMaXN0LmFkZChcInZpc2libGVcIik7XG4gICAgICB9KTtcbiAgICB9KTtcbiAgfSk7XG4gIFtcbiAgICAuLi5kb2N1bWVudC5xdWVyeVNlbGVjdG9yQWxsKFwiLnBhZ2UtaGVhZGVyLW1lbnUtaWNvbltkYXRhLXR5cGU9J2Nsb3NlJ11cIiksXG4gIF0uZm9yRWFjaCgoaWNvbikgPT4ge1xuICAgIGljb24uYWRkRXZlbnRMaXN0ZW5lcihcImNsaWNrXCIsICgpID0+IHtcbiAgICAgIGh0bWwuY2xhc3NMaXN0LnJlbW92ZShcIm5vLXNjcm9sbFwiKTtcbiAgICAgIG92ZXJsYXlzLmZvckVhY2goKG92ZXJsYXkpID0+IHtcbiAgICAgICAgb3ZlcmxheS5jbGFzc0xpc3QucmVtb3ZlKFwidmlzaWJsZVwiKTtcbiAgICAgIH0pO1xuICAgIH0pO1xuICB9KTtcbn07XG5cbm1haW4oKTtcbiJdLAogICJtYXBwaW5ncyI6ICI7O0FBRUEsTUFBTSxPQUFPLE1BQU07QUFDakIsVUFBTSxPQUFPLFNBQVMsY0FBYyxNQUFNO0FBQzFDLFVBQU0sV0FBVyxDQUFDLEdBQUcsU0FBUyxpQkFBaUIsVUFBVSxDQUFDO0FBQzFEO0FBQUEsTUFDRSxHQUFHLFNBQVMsaUJBQWlCLDBDQUEwQztBQUFBLElBQ3pFLEVBQUUsUUFBUSxDQUFDLFNBQVM7QUFDbEIsV0FBSyxpQkFBaUIsU0FBUyxNQUFNO0FBQ25DLGFBQUssVUFBVSxJQUFJLFdBQVc7QUFDOUIsZUFBTyxTQUFTLEdBQUcsQ0FBQztBQUNwQixpQkFBUyxRQUFRLENBQUMsWUFBWTtBQUM1QixrQkFBUSxVQUFVLElBQUksU0FBUztBQUFBLFFBQ2pDLENBQUM7QUFBQSxNQUNILENBQUM7QUFBQSxJQUNILENBQUM7QUFDRDtBQUFBLE1BQ0UsR0FBRyxTQUFTLGlCQUFpQiwyQ0FBMkM7QUFBQSxJQUMxRSxFQUFFLFFBQVEsQ0FBQyxTQUFTO0FBQ2xCLFdBQUssaUJBQWlCLFNBQVMsTUFBTTtBQUNuQyxhQUFLLFVBQVUsT0FBTyxXQUFXO0FBQ2pDLGlCQUFTLFFBQVEsQ0FBQyxZQUFZO0FBQzVCLGtCQUFRLFVBQVUsT0FBTyxTQUFTO0FBQUEsUUFDcEMsQ0FBQztBQUFBLE1BQ0gsQ0FBQztBQUFBLElBQ0gsQ0FBQztBQUFBLEVBQ0g7QUFFQSxPQUFLOyIsCiAgIm5hbWVzIjogW10KfQo=

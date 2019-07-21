import React from "react";
import ReactDOM from "react-dom";
import Signup from "../react/Signup";

document.addEventListener("DOMContentLoaded", () => {
  const currentScript = (() => {
    const scripts = document.getElementsByTagName("script");
    return scripts[scripts.length - 1];
  })();
  const dataAttributes = {};
  Object.entries(currentScript.parentElement.attributes).forEach(([, data]) => {
    dataAttributes[data.name.replace(/^data-/, "")] = JSON.parse(data.value);
  });

  ReactDOM.render(
    <Signup data={dataAttributes} />,
    currentScript.parentElement.appendChild(document.createElement("div"))
  );
});

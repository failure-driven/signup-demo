import React from "react";
import ReactDOM from "react-dom";
// import Input from "../react/Input";
const Input = () => (<div />);

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
    <Input data={dataAttributes} />,
    currentScript.parentElement.appendChild(document.createElement("div"))
  );
});

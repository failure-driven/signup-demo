import React from "react";
import ReactDOM from "react-dom";
// import Input from "../react/Input";
const Input = () => <input />;

document.addEventListener("DOMContentLoaded", () => {
  const currentScript = (() => {
    const scripts = document.getElementsByTagName("script");
    return scripts[scripts.length - 1];
  })();
  const dataAttributes = {};
  Object.entries(currentScript.parentElement.attributes).forEach(([, data]) => {
    console.log(JSON.stringify(data.value));
    dataAttributes[data.name.replace(/^data-/, "")] = JSON.parse(data.value);
  });
  console.log(JSON.stringify(dataAttributes));

  ReactDOM.render(
    <Input data={dataAttributes} />,
    currentScript.parentElement.appendChild(document.createElement("div"))
  );
});

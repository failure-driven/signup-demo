import React from "react";
import ReactDOM from "react-dom";
import Signup from "../react/Signup";

document.addEventListener("DOMContentLoaded", () => {
  const node = document.getElementById("user_data");
  const user = JSON.parse(node.getAttribute("data"));
  ReactDOM.render(
    <Signup user={user} />,
    document
      .getElementById("signupUsernameReact")
      .appendChild(document.createElement("div"))
  );
});

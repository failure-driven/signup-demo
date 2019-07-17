import React, { useState } from "react";
import { shape, string } from "prop-types";
import { attempt } from "../api/Api";

const Signup = ({ user }) => {
  const [username, setUsername] = useState(user.username || "");
  const [error, setError] = useState();

  const updateUsername = event => {
    event.preventDefault();
    setUsername(event.target.value);
    attempt(event.target.value).then(result => {
      const { errors } = result;
      if (errors) {
        setError(errors);
      } else {
        setError();
      }
    });
  };

  return (
    <input
      type="text"
      placeholder="Username"
      onChange={updateUsername}
      name="user[username]"
      value={username}
      className={error ? "field_with_errors" : ""}
    />
  );
};
Signup.propTypes = {
  user: shape({
    username: string
  }).isRequired
};

export default Signup;

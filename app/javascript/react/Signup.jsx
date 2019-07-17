import React, { useState } from "react";
import { shape, string } from "prop-types";

const Signup = ({ user }) => {
  const [username, setUsername] = useState(user.username || "");

  const updateUsername = event => {
    event.preventDefault();
    setUsername(event.target.value);
  };

  return (
    <input
      type="text"
      placeholder="Username"
      onChange={updateUsername}
      name="user[username]"
      value={username}
    />
  );
};
Signup.propTypes = {
  user: shape({
    username: string
  }).isRequired
};

export default Signup;

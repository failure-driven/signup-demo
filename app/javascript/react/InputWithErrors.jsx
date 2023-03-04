import React, { useState } from "react";

const InputWithErrors = () => {
  const [value, setValue] = useState("");

  const updateState = event => setValue(event.target.value);

  return (
    <input
      value={value}
      name="user[username]"
      onChange={updateState}
    />
  );
};

export default InputWithErrors;

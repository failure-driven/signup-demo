import React, { useState } from "react";
import { object as objectType, shape, string } from "prop-types";
import { attempt } from "../api/Api";

const Input = ({ data }) => {
  const [modelField, setModelField] = useState(data.data[data.fieldname] || "");
  const [error, setError] = useState();

  const updateUsername = event => {
    setModelField(event.target.value);
    attempt(event.target.value).then(({ errors }) => {
      if (errors) {
        setError(true);
      }
    });
  };

  return (
    <input
      type="text"
      placeholder={data.placeholder}
      onChange={updateUsername}
      name={`${data.modelname}[${data.fieldname}]`}
      value={modelField}
      className={error ? "field_with_errors" : ""}
    />
  );
};
Input.propTypes = {
  data: shape({
    data: objectType.isRequired,
    modelname: string.isRequired,
    placeholder: string.isRequired,
    fieldname: string.isRequired
  }).isRequired
};

export default Input;

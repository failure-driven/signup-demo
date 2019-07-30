import React, { useState } from "react";
import { object as objectType, shape, string } from "prop-types";
import { attempt } from "../api/Api";

const Input = ({ data }) => {
  const [modelField, setModelField] = useState(data.data[data.fieldname] || "");
  const [error, setError] = useState();

  const updateUsername = event => {
    event.preventDefault();
    setModelField(event.target.value);
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

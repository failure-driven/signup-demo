import React, { useState } from "react";
import { object as objectType, shape, string } from "prop-types";
import { attempt } from "../api/Api";

function InputWithErrors({ data }) {
  const [modelField, setModelField] = useState(
    (data.data && data.data[data.fieldname]) || ""
  );
  const [error, setError] = useState();

  const joinClasses = (classes) => {
    return classes.filter((className) => className != null).join(" ");
  };

  const updateUsername = (event) => {
    setModelField(event.target.value);
    attempt(event.target.value).then(({ errors }) => {
      if (errors) {
        setError(true);
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
      className={joinClasses([data.class, error && "is-invalid"])}
    />
  );
}
InputWithErrors.propTypes = {
  data: shape({
    data: objectType,
    modelname: string,
    placeholder: string,
    fieldname: string,
    class: string,
  }),
};
InputWithErrors.defaultProps = {
  data: {},
};
export default InputWithErrors;

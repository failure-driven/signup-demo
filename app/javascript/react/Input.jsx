import React, { useState } from "react";

const Input = () => {
  return <input value="" />;
};

export default Input;











































// const Input = () => {
//   const [value, setValue] = useState("");
//
//   const updateState = event => setValue(event.target.value);
//
//   return <input value={value} onChange={updateState} />;
// };
//
// const Input = ({ data }) => {
//   const [value, setValue] = useState(
//     (data.data && data.data[data.fieldname]) || ""
//   );
//
//   const updateState = event => setValue(event.target.value);
//
//   return (
//     <input
//       value={value}
//       name={`${data.modelname}[${data.fieldname}]`}
//       placeholder={data.placeholder}
//       onChange={updateState}
//     />
//   );
// };

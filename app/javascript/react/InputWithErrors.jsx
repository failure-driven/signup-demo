import React, { useState } from "react";

const InputWithErrors = () => {
  return(
    null
  );
};

export default InputWithErrors;






















// const InputWithErrors = ({ data }) => {
//   const [value, setValue] = useState(
//     (data.data && data.data["username"]) || ""
//   );
//
//   const valueChange = event => {
//     setValue(event.target.value);
//   };
//
//   return (
//     <input
//       value={value}
//       name={`${data.modelname}[${data.fieldname}]`}
//       onChange={valueChange}
//     />
//   );
// };
//
// export default InputWithErrors;

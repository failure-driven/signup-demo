// import React from "react";
// import { shallow } from "enzyme";
// import Input from "./Input";
//
// describe("Input", () => {
//   it("binds username to the input field value", () => {
//     const wrapper = shallow(<Input data={{}} />);
//     expect(wrapper.find("input").prop("value")).toEqual("");
//     wrapper.find("input").simulate("change", { target: { value: "username" } });
//     expect(wrapper.find("input").prop("value")).toEqual("username");
//   });
//
//   it("pre-populates username from the passed in data", () => {
//     const data = {
//       data: { username: "the username" },
//       modelname: "the_model",
//       fieldname: "username",
//       placeholder: "Username Placeholder"
//     };
//     const wrapper = shallow(<Input data={data} />);
//     expect(wrapper.find("input").prop("value")).toEqual("the username");
//     expect(wrapper.find("input").prop("name")).toEqual("the_model[username]");
//     expect(wrapper.find("input").prop("placeholder")).toEqual(
//       "Username Placeholder"
//     );
//     expect(wrapper).toMatchInlineSnapshot();
//   });
// });

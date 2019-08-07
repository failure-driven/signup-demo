import React from "react";
import { shallow } from "enzyme";
import Input from "./Input";

describe("Input", () => {
  it("renders an input box with the passed in username", () => {
    // const data = {
    //   data: { username: "the username" },
    //   modelname: "the model",
    //   placeholder: "the placeholder",
    //   fieldname: "username"
    // };
    // const wrapper = shallow(<Input data={data} />);
    // expect(wrapper.find("input").prop("value")).toEqual("the username");
    // expect(wrapper).toMatchInlineSnapshot(`
    //   <input
    //     name="the model[username]"
    //     onChange={[Function]}
    //     placeholder="the placeholder"
    //     type="text"
    //     value="the username"
    //   />
    // `);
  });

  it("username is bound to the input field value", () => {
    // const data = {
    //   data: { username: null },
    //   modelname: "the model",
    //   placeholder: "the placeholder",
    //   fieldname: "username"
    // };
    // const wrapper = shallow(<Input data={data} />);
    // const input = () => wrapper.find("input");
    // expect(input().prop("value")).toEqual("");
    // input().simulate("change", { target: { value: "username" } });
    // expect(input().prop("value")).toEqual("username");
  });
});

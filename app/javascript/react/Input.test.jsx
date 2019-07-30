import React from "react";
import { shallow } from "enzyme";
import Input from "./Input";

describe("Input", () => {
  it("renders an input box with the passed in username", () => {
    const data = {
      data: { username: "the username" },
      modelname: "the model",
      placeholder: "the placeholder",
      fieldname: "username"
    };
    const wrapper = shallow(<Input data={data} />);
    expect(wrapper.find("input").prop("value")).toEqual("the username");
    expect(wrapper).toMatchInlineSnapshot(`
      <input
        className=""
        name="the model[username]"
        onChange={[Function]}
        placeholder="the placeholder"
        type="text"
        value="the username"
      />
    `);
  });

  it("defaults username to be an empty string", () => {
    const data = {
      data: { username: null },
      modelname: "the model",
      placeholder: "the placeholder",
      fieldname: "username"
    };
    const wrapper = shallow(<Input data={data} />);
    expect(wrapper.find("input").prop("value")).toEqual("");
  });
});

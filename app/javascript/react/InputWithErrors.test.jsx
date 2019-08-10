import React from "react";
import { shallow } from "enzyme";
import InputWithErrors from "./InputWithErrors";

describe("InputWithErrors", () => {
  it("binds username to the input field value", () => {
    const wrapper = shallow(<InputWithErrors data={{}} />);
    expect(wrapper.find("input").prop("value")).toEqual("");
    wrapper.find("input").simulate("change", { target: { value: "username" } });
    expect(wrapper.find("input").prop("value")).toEqual("username");
  });

  // it("pre-populates username from the passed in data", () => {
  //   const data = {
  //     data: { username: "the username" },
  //     modelname: "the_model",
  //     fieldname: "username",
  //   };
  //   const wrapper = shallow(<InputWithErrors data={data} />);
  //   expect(wrapper.find("input").prop("value")).toEqual("the username");
  //   expect(wrapper.find("input").prop("name")).toEqual("the_model[username]");
  // });
});

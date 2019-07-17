import React from "react";
import { shallow } from "enzyme";
import Signup from "./Signup";

describe("Signup", () => {
  it("renders an input box with the passed in username", () => {
    const user = { username: "the username" };
    const wrapper = shallow(<Signup user={user} />);
    expect(wrapper.find("input").prop("value")).toEqual("the username");
    expect(wrapper).toMatchInlineSnapshot(`
      <input
        name="user[username]"
        onChange={[Function]}
        placeholder="Username"
        type="text"
        value="the username"
      />
    `);
  });

  it("defaults username to be an empty string", () => {
    const user = { username: null };
    const wrapper = shallow(<Signup user={user} />);
    expect(wrapper.find("input").prop("value")).toEqual("");
  });
});

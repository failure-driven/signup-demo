import React from "react";
import { shallow } from "enzyme";
import Input from "./Input";
import { attempt } from "../api/Api";

jest.mock("../api/Api");

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

  describe("username is filled in", () => {
    const data = {
      data: { username: null },
      modelname: "the model",
      placeholder: "the placeholder",
      fieldname: "username"
    };
    beforeEach(() => {
      attempt.mockClear();
    });

    it("username is bound to the input field value", () => {
      attempt.mockResolvedValue({ dryrunPassed: true });
      const wrapper = shallow(<Input data={data} />);
      const input = () => wrapper.find("input");
      expect(input().prop("value")).toEqual("");
      input().simulate("change", { target: { value: "username" } });
      expect(input().prop("value")).toEqual("username");
    });

    it("username attempt errors as username is taken", async () => {
      attempt.mockResolvedValue({
        dryrunPassed: false,
        errors: { username: [{ message: "Username is taken" }] }
      });
      const wrapper = shallow(<Input data={data} />);
      const input = () => wrapper.find("input");
      input().simulate("change", { target: { value: "taken-username" } });
      expect(attempt).toHaveBeenCalledTimes(1);
      expect(attempt).toHaveBeenCalledWith("taken-username");
      await attempt();
      expect(input().prop("className")).toEqual("field_with_errors");
    });
  });
});

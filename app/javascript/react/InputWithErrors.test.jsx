import React from "react";
import { shallow } from "enzyme";
import InputWithErrors from "./InputWithErrors";
import { attempt } from "../api/Api";

jest.mock("../api/Api");

describe("InputWithErrors", () => {
  beforeEach(() => {
    attempt.mockClear();
  });

  it("binds username to the input field value", () => {
    attempt.mockResolvedValue({ dryrunPassed: true });
    const wrapper = shallow(<InputWithErrors data={{}} />);
    const input = () => wrapper.find("input");
    expect(input().prop("value")).toEqual("");
    expect(wrapper).toMatchInlineSnapshot(`
      <input
        className=""
        name="undefined[undefined]"
        onChange={[Function]}
        type="text"
        value=""
      />
    `);
    input().simulate("change", { target: { value: "username" } });
    expect(input().prop("value")).toEqual("username");
  });

  it("pre-populates username from the passed in data", () => {
    const data = {
      data: { username: "the username" },
      modelname: "the_model",
      fieldname: "username",
      placeholder: "Username Placeholder",
    };
    const wrapper = shallow(<InputWithErrors data={data} />);
    expect(wrapper.find("input").prop("value")).toEqual("the username");
    expect(wrapper.find("input").prop("name")).toEqual("the_model[username]");
    expect(wrapper.find("input").prop("placeholder")).toEqual(
      "Username Placeholder"
    );
  });

  it("sets error state when username attempt errors", async () => {
    attempt.mockResolvedValue({
      dryrunPassed: false,
      errors: { username: [{ message: "Username is taken" }] },
    });
    const wrapper = shallow(<InputWithErrors data={{}} />);
    const input = () => wrapper.find("input");
    input().simulate("change", { target: { value: "taken-username" } });
    expect(attempt).toHaveBeenCalledTimes(1);
    expect(attempt).toHaveBeenCalledWith("taken-username");
    await attempt();
    expect(input().prop("className")).toEqual("is-invalid");
  });

  it("unsets error state on subsequent username attempt being success", async () => {
    const wrapper = shallow(<InputWithErrors data={{}} />);
    const input = () => wrapper.find("input");

    attempt.mockResolvedValue({
      dryrunPassed: false,
      errors: { username: [{ message: "Username is taken" }] },
    });
    input().simulate("change", { target: { value: "taken-username" } });
    await attempt();
    expect(input().prop("className")).toEqual("is-invalid");

    attempt.mockResolvedValue({ dryrunPassed: true });
    input().simulate("change", { target: { value: "taken-username" } });
    await attempt();
    expect(input().prop("className")).toEqual("");
  });
});

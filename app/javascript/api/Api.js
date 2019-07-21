const attempt = username => {
  return fetch(`/api/attempt?username=${encodeURI(username)}`, {
    method: "GET",
    headers: {
      "Content-type": "application/json",
      Accept: "application/json"
    }
  })
    .then(response => {
      if (response.ok) {
        return response;
      }
      return response.json().then(error => {
        this.setState({ error });
        throw new Error(`Request rejected with status ${response.status}`);
      });
    })
    .then(response => response.json());
};

export { attempt };
export default { attempt };

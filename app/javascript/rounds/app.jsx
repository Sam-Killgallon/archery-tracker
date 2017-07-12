import React from 'react'

export default class RoundsApp extends React.Component {
  constructor(props) {
    super();
    this.state = {
      rounds: []
    };
  }

  componentDidMount() {
    this.getUrl('/rounds').then((rounds) => {
      this.setState({
        rounds: rounds
      });
    });
  }

  render() {
    const rounds = this.state.rounds.map((round) => {
      return <h1 key={round.id}>{round.name}</h1>
    });
    return <div>{rounds}</div>;
  }

  getUrl(url) {
    return new Promise(function(resolve, reject) {
      let req = new XMLHttpRequest();
      req.open('GET', url);
      req.setRequestHeader('Accept', 'application/json');

      req.onload = function() {
        if (req.status == 200) {
          resolve(JSON.parse(req.response));
        } else {
          reject(Error(req.statusText));
        }
      };

      req.onerror = function() {
        reject(Error("Network Error"));
      };

      req.send();
    });
  }
}

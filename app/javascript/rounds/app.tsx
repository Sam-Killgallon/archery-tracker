import * as React from 'react';
import RoundDetails from 'rounds/details';

export default class RoundsApp extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      rounds: [],
      active: null
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
    const rounds = this.roundList();
    return (
      <div>
        <ul className="vertical-nav-items col-sm-3">{rounds}</ul>
        <RoundDetails className="section col-sm-9" round={this.state.active} />
      </div>
    );
  }
  
  handleClick(round) {
    this.setState({
      active: round
    });
  }

  roundList() {
    const rounds = this.state.rounds.map((round) => {
      return (
        <li className={round === this.state.active ? 'active' : null} key={round.id}>
          <a href="#" onClick={() => this.handleClick(round)}>{round.name}</a>
        </li>
      )
    });
    return rounds;
  }


  getUrl(url) {
    return new Promise((resolve, reject) => {
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

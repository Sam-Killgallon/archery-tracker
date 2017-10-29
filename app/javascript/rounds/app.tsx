import * as React from 'react';
import Round from 'models/round';
import RoundDetails from 'rounds/details';

interface State {
  rounds: Round[];
  active: Round;
}

export default class RoundsApp extends React.Component<{}, State> {
  constructor(props: object) {
    super(props);
    this.state = {
      rounds: [],
      active: null
    };
  }
  componentDidMount(): void {
    this.getUrl('/rounds').then((rounds: object[]) => {
      this.setState({
        rounds: rounds.map(round => new Round(round))
      });
    });
  }

  render(): JSX.Element {
    const rounds = this.roundList();
    return (
      <div>
        <ul className="vertical-nav-items col-sm-3">{rounds}</ul>
        <RoundDetails className="section col-sm-9" round={this.state.active} />
      </div>
    );
  }
  
  handleClick(round: Round): void {
    this.setState({
      active: round
    });
  }

  roundList(): JSX.Element[] {
    const rounds = this.state.rounds.map((round) => {
      return (
        <li className={round === this.state.active ? 'active' : null} key={round.id}>
          <a href="#" onClick={() => this.handleClick(round)}>{round.name}</a>
        </li>
      )
    });
    return rounds;
  }

  getUrl(url): Promise<object> {
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

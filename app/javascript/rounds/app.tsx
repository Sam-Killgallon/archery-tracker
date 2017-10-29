import * as React from 'react';
import Round from 'models/round';
import RoundList from 'rounds/list';

interface State {
  rounds: Round[];
}

export default class RoundsApp extends React.Component<{}, State> {
  constructor(props: {}) {
    super(props);

    this.state = {
      rounds: []
    }
  }

  render() {
    return (
      <div>
        <RoundList rounds={this.state.rounds} />
      </div>
    );
  }

  async componentDidMount() {
    const rounds = await this.getUrl('/rounds');
    let round_objs: Round[] = rounds.map(round=> new Round(round));
    round_objs.sort((a, b) => a.name.localeCompare(b.name));

    this.setState({
      rounds: round_objs
    });
  }

  async getUrl(url): Promise<object[]> {
    return new Promise<object[]>((resolve, reject) => {
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
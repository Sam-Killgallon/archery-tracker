import * as React from 'react';
import Round from 'models/round';
import RoundList from 'rounds/list';
import SearchBar from 'search_bar';

interface State {
  rounds: Round[];
  filteredRounds: Round[];
  searchParams: {
    'search-term': string,
    'metric-filter': boolean,
    'imperial-filter': boolean,
    'indoor-filter': boolean,
    'outdoor-filter': boolean
  }
}

export default class RoundsApp extends React.Component<{}, State> {
  constructor(props: {}) {
    super(props);

    this.state = {
      rounds: [],
      filteredRounds: [],
      searchParams: {
        'search-term': '',
        'metric-filter': true,
        'imperial-filter': true,
        'indoor-filter': true,
        'outdoor-filter': true
      }
    }
  }

  render() {
    return (
      <div className="container">
        <div className="row search-bar">
          <SearchBar onChange={(ev) => this.filterRounds(ev)} />
        </div>
        <div className="row">
          <RoundList rounds={this.state.filteredRounds} />
        </div>
      </div>
    );
  }

  filterRounds(ev: React.ChangeEvent<HTMLInputElement>): void {
    const obj = this.state.searchParams;
    if (Object.prototype.hasOwnProperty.call(ev.target, 'checked')) {
      obj[ev.target.id] = ev.target.checked;
    } else {
      obj[ev.target.id] = ev.target.value;
    }
    this.setState({searchParams: obj}, this.updateList)
  }

  updateList() {
    const searchParams = this.state.searchParams;
    const searchTerm = searchParams['search-term'].toLowerCase();
    const rounds = this.state.rounds;

    let filteredRounds = rounds.filter(round => {
      return round.name.toLowerCase().includes(searchTerm)
    })

    filteredRounds = filteredRounds.filter(round => {
      return (
        round.indoor && searchParams['indoor-filter'] ||
        !round.indoor && searchParams['outdoor-filter']
      );
    })

    filteredRounds = filteredRounds.filter(round => {
      return (
        round.metric && searchParams['metric-filter'] ||
        !round.metric && searchParams['imperial-filter']
      );
    })

    this.setState({
      filteredRounds: filteredRounds
    })
  }

  async componentDidMount() {
    const rounds = await this.getUrl('/rounds');
    let round_objs: Round[] = rounds.map(round=> new Round(round));
    round_objs.sort((a, b) => a.name.localeCompare(b.name));

    this.setState({
      rounds: round_objs,
      filteredRounds: round_objs
    }, this.updateList);
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
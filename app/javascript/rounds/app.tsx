import * as React from 'react';
import Round from 'models/round';
import RoundList from 'rounds/list';
import SearchBar from 'search_bar';
import RoundService from 'services/round_service';

interface Props {
}

interface State {
  rounds: Round[];
  filteredRounds: Round[];
  activeRound: Round | null;
  searchParams: {
    'search-term': string,
    'metric-filter': boolean,
    'imperial-filter': boolean,
    'indoor-filter': boolean,
    'outdoor-filter': boolean
  }
}

export default class RoundsApp extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);

    this.state = {
      rounds: [],
      filteredRounds: [],
      activeRound: null,
      searchParams: {
        'search-term': '',
        'metric-filter': true,
        'imperial-filter': true,
        'indoor-filter': true,
        'outdoor-filter': true
      }
    }
  }

  render(): JSX.Element {
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

  updateList(): void {
    const searchParams = this.state.searchParams;
    const rounds = this.state.rounds;
    const service = new RoundService();

    this.setState({
      filteredRounds: service.filterRounds(rounds, searchParams)
    })
  }

  async componentDidMount(): Promise<void> {
    const service = new RoundService();
    const roundList = await service.getRoundList();
    this.setState({
      rounds: roundList,
      filteredRounds: roundList
    }, this.updateList);
  }
}

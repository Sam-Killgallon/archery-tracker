import * as React from 'react';
import Round from 'models/round';
import RoundService from 'services/round_service';
import RoundsList from 'components/rounds_list';
import RoundDetails from 'components/round_details';
import SearchBar from 'components/search_bar';
import RoundSearch from 'services/round_search';

interface Props {}
interface State {
  rounds: Round[];
  activeRound: Round | null;
  search: RoundSearch;
}

export default class RoundsViewer extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);

    const rounds: Round[] = [];
    const searchFieldDefaults = {
      term: '',
      indoor: true,
      outdoor: true,
      metric: true,
      imperial: true
    };

    this.state = {
      rounds: rounds,
      activeRound: null,
      search: new RoundSearch(searchFieldDefaults)
    };
  }
  render() {
    const rounds = this.state.rounds;
    const search = this.state.search;
    const activeRound = this.state.activeRound;

    return (
      <div>
        <div className="row">
          <div className="col-4">
            <SearchBar onChange={this.search} searchFields={search.searchFields} />
          </div>
        </div>

        <div className="row">
          <div className="col-4 full-page-scrollable">
            <RoundsList
            rounds={search.filter(rounds)}
            activeRound={activeRound}
            onClick={this.selectRound} />
          </div>

          <div className="col-8">
            <RoundDetails round={activeRound} />
          </div>
        </div>
      </div>
    )
  }

  private search = (identifier: string, value: string | boolean): void => {
    const search = this.state.search;

    this.setState({
      search: search.update({ [identifier]: value})
    })
  }

  // Ensure the callback is bound to this object
  private selectRound = (round: Round): void => {
    this.setState({
      activeRound: round
    });
  }

  async componentDidMount(): Promise<void> {
    const roundList = await new RoundService().getRoundList();

    this.setState({
      rounds: roundList
    });
  }
}

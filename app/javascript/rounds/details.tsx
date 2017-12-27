import * as React from 'react';
import Round from 'models/round';
import RoundDistanceTable from 'rounds/distance_table';

interface Props {
  round: Round | null;
  className: string;
}

interface State {
}

export default class RoundDetails extends React.Component<Props, State> {
  render(): JSX.Element {
    if (!this.props.round) { return this.noRoundSelected() }
    const round = new Round(this.props.round);

    return (
      <div className={this.props.className}>
        <h3 className="text-center">
          {round.name} - {round.type()} - {round.location()}
        </h3>
        <ul>
          <li>Distances: {round.formattedDistances()}</li>
          <li>Total arrows: {round.total_arrows}</li>
          <li>Max score: {round.max_score}</li>
        </ul>

        <RoundDistanceTable round={round} />
      </div>
    );
  }

  noRoundSelected(): JSX.Element {
    return (
      <div className={this.props.className}>
        <h3 className="text-center">Please select a round</h3>
      </div>
    )
  }
}

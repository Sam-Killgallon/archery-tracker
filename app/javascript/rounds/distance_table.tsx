import * as React from 'react';
import Round from 'models/round';

interface Props {
  round: Round;
}

interface State {
}

export default class RoundDistanceTable extends React.Component<Props, State> {
  render(): JSX.Element {
    const round = this.props.round;
    const roundDistances = round.round_distances;

    const rows = roundDistances.map(roundDistance => {
      return (
        <tr key={roundDistance.id}>
          <th>{roundDistance.distance}</th>
          <td>{roundDistance.arrows_per_end}</td>
          <td>{roundDistance.ends}</td>
          <td>{roundDistance.total_arrows}</td>
        </tr>
      )
    })

    return (
      <table className="table table-hover distances-table">
        <thead>
          <tr>
            <th>Distance ({round.distanceUnits()})</th>
            <th>Arrows per end</th>
            <th>Ends</th>
            <th>Total arrows</th>
          </tr>
        </thead>
        <tbody>
          {rows}
        </tbody>
      </table>
    )
  }
}

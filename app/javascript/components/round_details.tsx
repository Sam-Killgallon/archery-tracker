import * as React from 'react';
import Round from 'models/round';
import RoundDistance from 'models/round_distance';

interface Props {
  round: Round | null;
}

interface State {}

export default class RoundDetails extends React.Component<Props, State> {
  render() {
    const round = this.props.round;

    if (!round) {
      return <h3 className="text-center">Please select a round</h3>;
    }
    const roundDistances = round.round_distances;


    return (
      <div>
        <h3 className="text-center">
          {round.name} - {round.type()} - {round.location()}
        </h3>

        <ul>
          <li>Distances: {round.formattedDistances()}</li>
          <li>Total arrows: {round.total_arrows}</li>
          <li>Max score: {round.max_score}</li>
        </ul>

        <div className="text-center">
          Scoresheet:
          &nbsp;
          <a href={round.scoreSheetPath()} target="_blank">View</a>
          &nbsp;
          |
          &nbsp;
          <a href={round.scoreSheetPath()} download>Download</a>
        </div>


        <table className="table table-equal-width">
          <thead>
            <tr>
              <th scope="col">Distance ({round.distanceUnits()})</th>
              <th scope="col">Arrows per end</th>
              <th scope="col">Ends</th>
              <th scope="col">Total arrows</th>
            </tr>
          </thead>
          <tbody>
            {this.rows(roundDistances)}
          </tbody>
        </table>
      </div>
    )
  }

  private rows(roundDistances: RoundDistance[]) {
    return roundDistances.map(roundDistance => {
      return (
        <tr key={roundDistance.id}>
          <th scope="row">{roundDistance.distance}</th>
          <td>{roundDistance.arrows_per_end}</td>
          <td>{roundDistance.ends}</td>
          <td>{roundDistance.total_arrows}</td>
        </tr>
      )
    })
  }
}

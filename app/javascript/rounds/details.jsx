import React from 'react'

export default class RoundDetails extends React.Component {
  render() {
    const round = this.props.round;
    if (!round) { return <div className={this.props.className}>Please select a round</div>}
    return (
      <div className={this.props.className}>
        <h3>{round.name} - {round.metric ? 'Metric' : 'Imperial'} - {round.indoor ? 'Indoor' : 'Outdoor'}</h3>
        <ul>
          <li>Distances: {round.distances.join(', ')}</li>
          <li>Total arrows: {round.total_arrows}</li>
          <li>Max score: {round.max_score}</li>
        </ul>
      </div>
    );
  }
}

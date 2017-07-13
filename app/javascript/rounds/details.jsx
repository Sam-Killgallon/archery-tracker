import React from 'react'

export default class RoundDetails extends React.Component {
  render() {
    const round = this.props.round;
    if (!round) { return <div className={this.props.className}>Please select a round</div>}
    return (
      <div className={this.props.className}>
        <p>{round.name} - {round.metric ? 'Metric' : 'Imperial'} - {round.indoor ? 'Indoor' : 'Outdoor'}</p>
      </div>
    );
  }
}

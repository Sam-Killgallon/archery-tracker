import * as React from 'react';

export default class RoundDistanceTable extends React.Component {
  render() {
    const roundDistances = this.props.roundDistances;

    if (roundDistances.length <= 1) { return <div></div> }

    const headers = roundDistances.map(roundDistance => {
     return <th key={roundDistance.id}>{roundDistance.distance}</th>
    })
    const arrowsPerEnd = roundDistances.map(roundDistance => {
     return <td key={roundDistance.id}>{roundDistance.arrows_per_end}</td>
    })
    const ends = roundDistances.map(roundDistance => {
     return <td key={roundDistance.id}>{roundDistance.ends}</td>
    })
    const totalArrows = roundDistances.map(roundDistance => {
     return <td key={roundDistance.id}>{roundDistance.total_arrows}</td>
    })

    return (
      <table className="table distances-table">
        <thead>
          <tr>
            <th></th>
            {headers}
          </tr>
        </thead>
        <tbody>
          <tr>
            <th className="col-sm-3">Arrows per end</th>
            {arrowsPerEnd}
          </tr>
          <tr>
            <th className="col-sm-3">Ends</th>
            {ends}
          </tr>
          <tr>
            <th className="col-sm-3">Total arrows</th>
            {totalArrows}
          </tr>
        </tbody>
      </table>
    )
  }
}

import * as React from 'react';
import Round from 'models/round';

interface Props {
  rounds: Round[];
  activeRound: Round | null;
  onClick: (round: Round) => void;
}

interface State {}

export default class RoundsList extends React.Component<Props, State> {
  render() {
    const rounds = this.props.rounds;
    const activeRound = this.props.activeRound;

    const listElements = rounds.map(round => {
      let listItemClasses = 'list-group-item-large text-left';
      if (activeRound === round) {
        listItemClasses += ' active';
      }

      return (
        <button
        type="button"
        onClick={() => this.props.onClick(round)}
        className={listItemClasses}
        key={round.id}>
        {round.name}
        </button>
      );
    })

    return (
      <div className="list-group">
        {listElements}
      </div>
    )
  }
}

import * as React from 'react';
import Round from 'models/round';

interface Props {
  rounds: Round[];
  active: Round | null;
  className: string;
  onClick: (round: Round) => void;
}

interface State {
}

export default class RoundList extends React.Component<Props, State> {
  render(): JSX.Element {
    const rounds = this.roundList();
    const classes = `list-group ${this.props.className}`
    return <ul className={classes}>{rounds}</ul>;
  }

  roundList(): JSX.Element[] {
    return this.props.rounds.map((round) => {
      return this.entry(round);
    });
  }

  private entry(round: Round): JSX.Element {
    const click = this.props.onClick
    return (
      <li
        className={this.classes(round)}
        key={round.id}
        onClick={(_event) => click(round)}
      >
        {round.name}
      </li>
    )
  }

  private classes(round: Round): string {
    let classes = "";
    classes += 'list-group-item';
    if (round === this.props.active) {
      classes += ' active';
    }

    return classes;
  }
}

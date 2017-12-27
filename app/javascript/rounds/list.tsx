import * as React from 'react';
import Round from 'models/round';
import RoundDetails from 'rounds/details';

interface Props {
  rounds: Round[];
}

interface State {
  active: Round | null;
}

export default class RoundList extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);

    this.state = {
      active: null
    }
  }

  render(): JSX.Element {
    const rounds = this.roundList();
    return (
      <div>
        <ul className="list-group col-sm-4">{rounds}</ul>
        <RoundDetails className="section col-sm-8" round={this.state.active} />
      </div>
    );
  }

  handleClick(round: Round): void {
    this.setState({
      active: round
    });
  }

  roundList(): JSX.Element[] {
    const rounds = this.props.rounds.map((round) => {
      let classes = "";
      classes += 'list-group-item';
      if (round === this.state.active) {
        classes += ' active';
      }
      return (
        <li className={classes} key={round.id} onClick={(_event) => this.handleClick(round)}>
          {round.name}
        </li>
      )
    });
    return rounds;
  }
}

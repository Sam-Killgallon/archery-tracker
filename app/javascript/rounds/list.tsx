import * as React from 'react';
import Round from 'models/round';
import RoundDetails from 'rounds/details';

interface Props {
  rounds: Round[];
}

interface State {
  active: Round;
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
        <ul className="vertical-nav-items col-sm-3">{rounds}</ul>
        <RoundDetails className="section col-sm-9" round={this.state.active} />
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
      return (
        <li className={round === this.state.active ? 'active' : null} key={round.id}>
          <a href="#" onClick={() => this.handleClick(round)}>{round.name}</a>
        </li>
      )
    });
    return rounds;
  }
}
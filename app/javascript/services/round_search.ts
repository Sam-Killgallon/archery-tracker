import Round from "models/round";

export interface SearchFields  {
  [index: string]: string | boolean;
  term: string;
  indoor: boolean;
  outdoor: boolean;
  metric: boolean;
  imperial: boolean;
}

export default class RoundSearch {
  constructor(public searchFields: SearchFields) {}

  public filter(rounds: Round[]): Round[] {
    const term = this.searchFields.term.toLowerCase();

    let filteredRounds = rounds.filter(round => {
      return round.name.toLowerCase().includes(term);
    })

    filteredRounds = filteredRounds.filter(round => {
      return (
        round.indoor && this.searchFields.indoor ||
        !round.indoor && this.searchFields.outdoor
      );
    })

    filteredRounds = filteredRounds.filter(round => {
      return (
        round.metric && this.searchFields.metric ||
        !round.metric && this.searchFields.imperial
      );
    })

    return filteredRounds;
  }

  public update(newSearchFields: Partial<SearchFields>): RoundSearch {
    const updatedFields = Object.assign({}, this.searchFields, newSearchFields);
    return new RoundSearch(updatedFields);
  }
}

import Round from 'models/round';

export default class RoundService {
  async getRoundList(): Promise<Round[]> {
    const rounds = await this.getUrl('/rounds');
    let round_objs: Round[] = rounds.map(round=> new Round(round));
    return round_objs.sort((a, b) => a.name.localeCompare(b.name));
  }

  filterRounds(rounds: Round[], searchParams: object): Round[] {
    const searchTerm = searchParams['search-term'].toLowerCase();

    let filteredRounds = rounds.filter(round => {
      return round.name.toLowerCase().includes(searchTerm)
    })

    filteredRounds = filteredRounds.filter(round => {
      return (
        round.indoor && searchParams['indoor-filter'] ||
        !round.indoor && searchParams['outdoor-filter']
      );
    })

    filteredRounds = filteredRounds.filter(round => {
      return (
        round.metric && searchParams['metric-filter'] ||
        !round.metric && searchParams['imperial-filter']
      );
    })

    return filteredRounds;
  }

  private async getUrl(url: string): Promise<object[]> {
    return new Promise<object[]>((resolve, reject) => {
      let req = new XMLHttpRequest();
      req.open('GET', url);
      req.setRequestHeader('Accept', 'application/json');

      req.onload = function() {
        if (req.status == 200) {
          resolve(JSON.parse(req.response));
        } else {
          reject(Error(req.statusText));
        }
      };

      req.onerror = function() {
        reject(Error("Network Error"));
      };

      req.send();
    });
  }
}

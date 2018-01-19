import Round, { RoundAttributes } from 'models/round';

export default class RoundService {
  async getRoundList(): Promise<Round[]> {
    const rounds = await this.getUrl('/rounds') as RoundAttributes[];
    const round_objs: Round[] = rounds.map(round => new Round(round));
    return round_objs.sort((a, b) => a.name.localeCompare(b.name));
  }

  private async getUrl(url: string): Promise<object[]> {
    return new Promise<object[]>((resolve, reject) => {
      const req = new XMLHttpRequest();
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

import RoundDistance from 'models/round_distance';

export interface RoundAttributes {
  id: number;
  name: string;
  indoor: boolean;
  total_arrows: number;
  max_score: number;
  metric: boolean;
  round_distances: RoundDistance[];
}
export default class Round implements RoundAttributes {
  public id: number;
  public name: string;
  public indoor: boolean;
  public total_arrows: number;
  public max_score: number;
  public metric: boolean;
  public round_distances: RoundDistance[];

  constructor(round_json: RoundAttributes) {
    Object.assign(this, round_json);
  }

  type(): string {
    return this.metric ? 'Metric' : 'Imperial';
  }

  location(): string {
    return this.indoor ? 'Indoor' : 'Outdoor';
  }

  distanceUnits(): string {
   return this.metric ? 'm' : 'y';
  }

  formattedDistances(): string {
    const unit = this.distanceUnits();
    const distances = this.round_distances.sort().map(roundDistance => {
      return `${roundDistance.distance}${unit}`;
    });

    return distances.join(', ');
  }

  scoreSheetPath(): string {
    return `/system/score_sheets/${this.name}.pdf`
  }
}

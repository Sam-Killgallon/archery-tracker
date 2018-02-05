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
  public readonly id: number;
  public readonly name: string;
  public readonly indoor: boolean;
  public readonly total_arrows: number;
  public readonly max_score: number;
  public readonly metric: boolean;
  public readonly round_distances: RoundDistance[];

  constructor(round_attrs: RoundAttributes) {
    this.id              = round_attrs.id;
    this.name            = round_attrs.name;
    this.indoor          = round_attrs.indoor;
    this.total_arrows    = round_attrs.total_arrows;
    this.max_score       = round_attrs.max_score;
    this.metric          = round_attrs.metric;
    this.round_distances = round_attrs.round_distances;
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

import RoundDistance from 'models/round_distance';

export default class Round {
  id: number;
  name: string;
  metric: boolean;
  indoor: boolean;
  total_arrows: number;
  max_score: number;
  round_distances: RoundDistance[];

  constructor(round) {
    Object.keys(round).forEach(attribute => this[attribute] = round[attribute]);
  }

  type(): string {
    return this.metric ? 'Metric' : 'Imperial';
  }

  location(): string {
    return this.indoor ? 'Indoor' : 'Outdoor';
  }

  formattedDistances(): string {
    const unit = this.metric ? 'm' : 'y';
    const distances = this.round_distances.sort().map(roundDistance => {
      return `${roundDistance.distance}${unit}`;
    });

    return distances.join(', ');
  }
}

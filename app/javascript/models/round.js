export default class Round {
  constructor(round) {
    Object.keys(round).forEach(attribute => this[attribute] = round[attribute]);
  }

  type() {
    return this.metric ? 'Metric' : 'Imperial';
  }

  location() {
    return this.indoor ? 'Indoor' : 'Outdoor';
  }

  formattedDistances() {
    const unit = this.metric ? 'm' : 'y';
    const distances = this.round_distances.sort().map(roundDistance => {
      return `${roundDistance.distance}${unit}`;
    });

    return distances.join(', ')
  }
}

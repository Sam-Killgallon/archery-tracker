import * as React from 'react';

interface Props {
  onChange: (ev: React.ChangeEvent<HTMLInputElement>) => void;
}

interface State {
}

export default class SearchBar extends React.Component<Props, State> {
  render() {
    return (
      <form onSubmit={(e) => e.preventDefault()}>
        <div>
          <div>
            <input
              id="search-term"
              type="text"
              placeholder="Enter a round name"
              onChange={this.props.onChange}
            />
          </div>
        </div>

        <div>
          <div>
            <label>
              <input type="checkbox" id="indoor-filter" value="" onChange={this.props.onChange} defaultChecked/>
              Indoor
            </label>
          </div>

          <div>
            <label>
              <input type="checkbox" id="outdoor-filter" value="" onChange={this.props.onChange} defaultChecked/>
              Outdoor
            </label>
          </div>

          <div>
            <label>
              <input type="checkbox" id="metric-filter" value="" onChange={this.props.onChange} defaultChecked/>
              Metric
            </label>
          </div>

          <div>
            <label>
              <input type="checkbox" id="imperial-filter" value="" onChange={this.props.onChange} defaultChecked/>
              Imperial
            </label>
          </div>
        </div>
      </form>
    )
  }
}

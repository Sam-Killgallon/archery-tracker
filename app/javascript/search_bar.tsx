import * as React from 'react';

interface Props {
  onChange: (ev: React.ChangeEvent<HTMLInputElement>) => void;
}

export default class SearchBar extends React.Component<Props, {}> {
  render() {
    return (
      <div>
        <input 
          id="search-bar"
          type="text"
          className="form-control"
          placeholder="Enter a round name"
          onChange={this.props.onChange}
          >
        </input>
      </div>
    )
  }
}
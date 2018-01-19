import * as React from 'react';
import { SearchFields } from 'services/round_search';

interface Props {
  onChange: (identifier: string, value: string | boolean) => void;
  searchFields: SearchFields;
}
interface State {}

export default class SearchBar extends React.Component<Props, State> {
  render() {
    const checkboxes = ['Indoor', 'Outdoor', 'Metric', 'Imperial'].map(this.checkbox);
    const value = this.props.searchFields.term;

    return (
      <form className="search-bar">
        <div className="form-group">
          <input
          className="form-control"
          id="search-term" // Used by tests
          type="search"
          placeholder="Enter a round name"
          onChange={(event) => this.props.onChange('term', event.currentTarget.value)}
          value={value}
          />
        </div>

        {checkboxes}
      </form>
    );
  }

  private checkbox = (identifier: string): JSX.Element => {
    const checkboxId = identifier.toLowerCase();
    const value = this.props.searchFields[checkboxId];

    if (typeof(value) !== 'boolean') {
      throw Error('Value must be boolean!')
    }

    return (
      <div className="form-check form-check-inline" key={identifier}>
        <input
        id={checkboxId}
        className="form-check-input"
        type="checkbox"
        onChange={(event) => this.props.onChange(checkboxId, event.currentTarget.checked)}
        checked={value}
        />
        <label className="form-check-label" htmlFor={checkboxId}>
          {identifier}
        </label>
      </div>
    )
  }
}

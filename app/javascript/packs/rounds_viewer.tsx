import * as React from 'react'
import * as ReactDOM from 'react-dom'
import RoundsApp from 'rounds/app'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <div className="container">
      <RoundsApp />
    </div>,
    document.getElementById('root')
  )
})

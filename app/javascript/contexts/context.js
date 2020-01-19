import React from 'react'

export default React.createContext({
  vehicles: [],
  fetchingVehicle: false,
  fetchingFuelEntries: false,
  flashMessage: {}
})

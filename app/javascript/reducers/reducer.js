export default function reducer(state, action) {
  switch(action.type) {
    case 'CREATE_VEHICLE_REQUEST':
      return {
        ...state,
        fetchVehicle: true
      }
    case 'CREATE_VEHICLE_SUCCESS':
      return {
        ...state,
        fetchVehicle: false,
        vehicles: [...state.vehicles, action.payload]
      }
    case 'CREATE_VEHICLE_FAILURE':
      return {
        ...state,
        fetchVehicle: false,
        errorMessage: action.payload
      }
    default:
      return state
  }
}

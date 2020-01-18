export default function reducer(state, action) {
  switch(action.type) {
    case 'CREATE_VEHICLE_REQUEST':
      return {
        ...state,
        fetchingVehicle: true
      }
    case 'CREATE_VEHICLE_SUCCESS':
      return {
        ...state,
        fetchingVehicle: false,
        vehicles: [...state.vehicles, action.payload],
        successMessage: action.payload
      }
    case 'CREATE_VEHICLE_FAILURE':
      return {
        ...state,
        fetchingVehicle: false,
        errorMessage: action.payload
      }
    default:
      return state
  }
}

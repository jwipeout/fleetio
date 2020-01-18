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
        flashMessage: {
          message: 'Successfully created vehicle',
          flashType: 'success'
        }
      }
    case 'CREATE_VEHICLE_FAILURE':
      return {
        ...state,
        fetchingVehicle: false,
        flashMessage: {
          message: action.payload,
          flashType: 'danger'
        }
      }
    default:
      return state
  }
}

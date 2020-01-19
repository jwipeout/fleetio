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
          flashType: 'success',
          show: true
        }
      }
    case 'CREATE_VEHICLE_FAILURE':
      return {
        ...state,
        fetchingVehicle: false,
        flashMessage: {
          message: action.payload,
          flashType: 'danger',
          show: true
        }
      }
    case 'UPDATE_VEHICLE_FUEL_EFFICIENCY_REQUEST':
      return {
        ...state,
        fetchingFuelEntries: true
      }
    case 'UPDATE_VEHICLE_FUEL_EFFICIENCY_SUCCESS':
      return {
        ...state,
        fetchingFuelEntries: false,
        vehicles: state.vehicles.map(vehicle => {
          if(vehicle.id === action.payload.id) {
            return { ...vehicle, fuel_efficiency: action.payload.fuel_efficiency }
          } else {
            return vehicle
          }
        })
      }
    case 'UPDATE_VEHICLE_FUEL_EFFICIENCY_FAILURE':
      return {
        ...state,
        fetchingFuelEntries: false,
        flashMessage: {
          message: action.payload,
          flashType: 'danger',
          show: true
        }
      }
    case 'CLOSE_FLASH_MESSAGE':
      return {
        ...state,
        flashMessage: {
          ...state.flashMessage,
          show: false
        }
      }
    default:
      return state
  }
}

import axios from 'axios'

export async function createVehicle(dispatch, vinValue) {
  try {
    await dispatch({ type: 'CREATE_VEHICLE_REQUEST' })

    const createResponse = await axios({
      method: 'post',
      url: '/vehicles.json',
      data: {
        vehicle: {
          vin: vinValue
        }
      }
    })

    await dispatch({ type: 'CREATE_VEHICLE_SUCCESS', payload: createResponse.data })

    return createResponse
  } catch(error) {
    dispatch({ type: 'CREATE_VEHICLE_FAILURE', payload: error.response.data })
  }
}

export async function updateVehicleFuelEfficiency(dispatch, vehicleId) {
  try {
    await dispatch({ type: 'UPDATE_VEHICLE_FUEL_EFFICIENCY_REQUEST', payload: vehicleId })

    const updateResponse = await axios({
      method: 'post',
      url: `/vehicles/${vehicleId}/update_fuel_efficiency.json`
    })

    dispatch({ type: 'UPDATE_VEHICLE_FUEL_EFFICIENCY_SUCCESS', payload: updateResponse.data })
  } catch(error) {
    dispatch({ type: 'CREATE_VEHICLE_FAILURE', payload: error.response.data })
  }
}

import React, { useContext, useState, useReducer } from 'react'
import Store from '../contexts/context'
import { Card, Form, Button, Spinner } from 'react-bootstrap'
import axios from 'axios'

export default function VehicleForm() {
  const { state, dispatch } = useContext(Store)
  const [vin, setVin] = useState('')

  function handleChange(e) {
    setVin(e.target.value)
  }

  function handleSubmit(e) {
    e.preventDefault()
    fetchVehicle(vin)
  }

  async function fetchVehicle(vinValue) {
    try {
      dispatch({ type: 'CREATE_VEHICLE_REQUEST' })

      const createResponse = await axios({
        method: 'post',
        url: '/vehicles.json',
        data: {
          vehicle: {
            vin: vinValue
          }
        }
      })

      dispatch({ type: 'CREATE_VEHICLE_SUCCESS', payload: createResponse.data })

      dispatch({ type: 'UPDATE_VEHICLE_FUEL_EFFICIENCY_REQUEST', paylod: createResponse.data.id })

      const updateResponse = await axios({
        method: 'post',
        url: `/vehicles/${createResponse.data.id}/update_fuel_efficiency.json`
      })

      dispatch({ type: 'UPDATE_VEHICLE_FUEL_EFFICIENCY_SUCCESS', payload: updateResponse.data })
    } catch(error) {
      if(error.response.config.url === '/vehicles.json') {
        dispatch({ type: 'CREATE_VEHICLE_FAILURE', payload: error.response.data })
      } else {
        dispatch({ type: 'UPDATE_VEHICLE_FUEL_EFFICIENCY_FAILURE', payload: error.response.data })
      }
    }
  }

  return(
    <Card className="vehicle-form">
      <Card.Body>
				<Form onSubmit={handleSubmit}>
					<Form.Group>
            <h3>Add Your Vehicle</h3>

						<Form.Label>Search by VIN</Form.Label>

						<Form.Control
              type="text"
              placeholder="Enter VIN"
              value={vin}
              onChange={handleChange}
            />

						<Form.Text className="text-muted">
							We'll calculate fuel efficiency after adding vehicle
						</Form.Text>
					</Form.Group>

          {
            state.fetchingVehicle ? (
							<Button variant="primary" disabled>
                <Spinner
                  as="span"
                  animation="grow"
                  size="sm"
                  role="status"
                  aria-hidden="true"
                />
                Fetching...
              </Button>
            ) : (
              <Button variant="primary" type="submit">
                Submit
              </Button>
            )
          }
				</Form>
      </Card.Body>
    </Card>
  )
}

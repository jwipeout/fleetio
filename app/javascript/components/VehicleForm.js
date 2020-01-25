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

      dispatch({ type: 'UPDATE_VEHICLE_FUEL_EFFICIENCY_REQUEST', payload: createResponse.data.id })

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
    <Form onSubmit={handleSubmit}>
      <Form.Group>
        <h2>Add Your Vehicle</h2>

        <p>
          Welcome! Add your vehicle by searhing by vin.
          After we have found it we will update the fuel
          efficiency column.
        </p>

        <Form.Label>Search by VIN</Form.Label>

        <Form.Control
          required
          type="text"
          placeholder="Enter VIN"
          value={vin}
          onChange={handleChange}
        />

        <Form.Text className="text-muted">
          Vehicle will automatically be added to list below.
        </Form.Text>
      </Form.Group>

      {
        state.fetchingVehicle ? (
          <Button variant="success" disabled>
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
          <Button variant="success" type="submit">
            Submit
          </Button>
        )
      }
    </Form>
  )
}

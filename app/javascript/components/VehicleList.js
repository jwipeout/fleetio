import React from 'react'
import { Table, Spinner } from 'react-bootstrap'

export default function VehicleList(props) {
  return(
    <>
      <h3>List of Vehicles</h3>

      <Table bordered hover>
        <thead>
          <tr>
            <th>Vin</th>

            <th>Make</th>

            <th>Model</th>

            <th>Fuel Efficiency</th>
          </tr>
        </thead>

        <tbody>
          {
            props.vehicles
              .sort((a, b) =>
                b.id - a.id
              )
              .map(vehicle =>
                <tr key={vehicle.id}>
                  <td>{vehicle.vin}</td>

                  <td>{vehicle.make}</td>

                  <td>{vehicle.model}</td>

                  <td>
                    {
                      props.fetchingFuelEntries.currentStatus
                        && props.fetchingFuelEntries.vehicleId === vehicle.id ? (
                        <Spinner
                          animation="grow"
                          variant="primary"
                          size="sm"
                        />
                      ) : (
                        vehicle.fuel_efficiency
                      )
                    }
                  </td>
                </tr>
              )
          }
        </tbody>
      </Table>
    </>
  )
}

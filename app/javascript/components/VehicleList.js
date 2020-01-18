import React from 'react'
import { Table, Spinner } from 'react-bootstrap'

export default function VehicleList(props) {
  return(
    <Table striped bordered hover>
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
                    props.fetchingFuelEntries ? (
                      <Spinner animation="grow" variant="primary" />
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
  )
}

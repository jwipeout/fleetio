import React from 'react'
import { Table } from 'react-bootstrap'

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
          props.vehicles.map(vehicle =>
            <tr key={vehicle.id}>
              <td>{vehicle.vin}</td>

              <td>{vehicle.make}</td>

              <td>{vehicle.model}</td>

              <td>{vehicle.fuel_efficiency}</td>
            </tr>
          )
        }
      </tbody>
    </Table>
  )
}

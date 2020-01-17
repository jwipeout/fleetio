import React, { useContext } from 'react'
import Store from '../contexts/context'
import { Card, Form, Button } from 'react-bootstrap'

export default function VehicleForm() {
  const { state, dispatch } = useContext(Store)

  return(
    <Card className="vehicle-form">
      <Card.Body>
				<Form>
					<Form.Group>
						<Form.Label>VIN</Form.Label>

						<Form.Control type="text" placeholder="Enter VIN" />

						<Form.Text className="text-muted">
							We'll calculate fuel efficiency after adding vehicle
						</Form.Text>
					</Form.Group>

          <Button variant="primary" type="submit">
            Submit
          </Button>
				</Form>
      </Card.Body>
    </Card>
  )
}

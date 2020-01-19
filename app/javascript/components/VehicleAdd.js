import React, { useContext, useReducer } from 'react'
import reducer from '../reducers/reducer'
import Store from '../contexts/context'
import { ListGroup, Container, Col, Row, Image } from 'react-bootstrap'
import NavbarMain from './NavbarMain'
import VehicleList from './VehicleList'
import VehicleForm from './VehicleForm'
import FlashMessage from './FlashMessage'
import axios from 'axios'
import setupCsrfToken from '../helpers/setupCsrfToken'

export default function VehicleAdd(props) {
  setupCsrfToken()
  const globalStore = useContext(Store)
  const [state, dispatch] = useReducer(reducer, { ...globalStore, vehicles: props.vehicles })


  return(
    <Store.Provider value={{ state, dispatch }}>
      <NavbarMain />

      <div className="banner">
        <Container>
          <FlashMessage />

          <Row>
            <Col md={6}>
              <VehicleForm />
            </Col>

            <Col md={6}>
              <Image src="https://fleetiojosh.s3-us-west-1.amazonaws.com/asset-management.png" fluid />
            </Col>
          </Row>
        </Container>
      </div>

      <Container>
        <VehicleList
          vehicles={state.vehicles}
          fetchingFuelEntries={state.fetchingFuelEntries}
        />
      </Container>
    </Store.Provider>
  )
}

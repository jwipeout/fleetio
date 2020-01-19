import React, { useContext, useReducer } from 'react'
import reducer from '../reducers/reducer'
import Store from '../contexts/context'
import { ListGroup, Container } from 'react-bootstrap'
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

      <Container>
        <FlashMessage />

        <VehicleForm />

        <VehicleList
          vehicles={state.vehicles}
          fetchingFuelEntries={state.fetchingFuelEntries}
        />
      </Container>
    </Store.Provider>
  )
}

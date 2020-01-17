import React, { useContext, useReducer } from 'react'
import reducer from '../reducers/reducer'
import Store from '../contexts/context'
import { ListGroup, Container } from 'react-bootstrap'
import NavbarMain from './NavbarMain'
import VehicleList from './VehicleList'
import VehicleForm from './VehicleForm'

export default function VehicleAdd(props) {
  const initialState = { vehicles: props.vehicles }
  const [state, dispatch] = useReducer(reducer, initialState)

  return(
    <Store.Provider value={{ state, dispatch }}>
      <NavbarMain />

      <Container>
        <VehicleForm />

        <VehicleList vehicles={state.vehicles} />
      </Container>
    </Store.Provider>
  )
}

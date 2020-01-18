import React, { useContext, useReducer } from 'react'
import reducer from '../reducers/reducer'
import Store from '../contexts/context'
import { ListGroup, Container } from 'react-bootstrap'
import NavbarMain from './NavbarMain'
import VehicleList from './VehicleList'
import VehicleForm from './VehicleForm'
import axios from 'axios'

export default function VehicleAdd(props) {
  const initialState = { vehicles: props.vehicles }
  const [state, dispatch] = useReducer(reducer, initialState)
  const csrfToken = document.querySelector('[name=csrf-token]').content

  axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken

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

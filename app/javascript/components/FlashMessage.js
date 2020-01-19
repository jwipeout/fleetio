import React, { useContext } from 'react'
import Store from '../contexts/context'
import { Alert } from 'react-bootstrap'

export default function FlashMessage() {
  const {state, dispatch} = useContext(Store)

  function handleClose() {
    dispatch({ type: 'CLOSE_FLASH_MESSAGE' })
  }

  if (state.flashMessage.show) {
    return (
      <Alert
        variant={state.flashMessage.flashType}
        onClose={handleClose}
        dismissible
      >
        { state.flashMessage.message }
      </Alert>
    );
  }

  return null
}

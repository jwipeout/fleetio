import React, { useState } from 'react'
import { Alert } from 'react-bootstrap'

export default function FlashMessage(props) {
  const [show, setShow] = useState(true);

  if (show && props.message) {
    return (
      <Alert variant={props.flashType} onClose={() => setShow(false)} dismissible>
        { props.message }
      </Alert>
    );
  }

  return null
}

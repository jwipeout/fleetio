import React from 'react'
import { Navbar, Nav, Container } from 'react-bootstrap'

export default function NavbarMain() {
  return(
    <Navbar bg="light" expand="md">
      <Container>
        <Navbar.Brand href="#home">
          <img
            alt=""
            src="https://fleetiojosh.s3-us-west-1.amazonaws.com/fleetio_logo.png"
            height="30"
            className="d-inline-block align-top"
          />
        </Navbar.Brand>

        <Navbar.Toggle aria-controls="basic-navbar-nav" />

        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="mr-auto">
            <Nav.Link href="/">Home</Nav.Link>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  )
}

import React from 'react'
import { Navbar, Nav, Container } from 'react-bootstrap'

export default function NavbarMain() {
  return(
    <Navbar bg="dark" expand="md" variant="dark">
      <Container>
        <Navbar.Brand href="#home">Fleetio</Navbar.Brand>

        <Navbar.Toggle aria-controls="basic-navbar-nav" />

        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="mr-auto">
            <Nav.Link href="#home">Home</Nav.Link>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  )
}

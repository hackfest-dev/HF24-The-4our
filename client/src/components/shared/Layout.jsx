import React from 'react'
import Sidebar from './Sidebar'
import { Outlet } from 'react-router-dom'

export default function Layout() {
  return (
    <div>
        <div><Sidebar/></div>
        <div>Navbar</div>
        <div>{<Outlet/>}</div>
    </div>
  )
}

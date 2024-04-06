import React from 'react'
import Sidebar from './Sidebar'
import Navbar from './Navbar'
import { Outlet } from 'react-router-dom'

export default function Layout() {
  return (
    <div>
      <div className='flex flex-row h-screen w-screen '>
        <Sidebar/>
        <div className='flex flex-col h-screen w-screen '>
          <Navbar/>
          <Outlet/>
        </div>
      </div>
    </div>
  )
}

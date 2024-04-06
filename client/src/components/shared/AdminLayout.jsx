import React from 'react'
import AdminSidebar from './AdminSidebar'
import AdminNavbar from './AdminNavbar'
import { Outlet } from 'react-router-dom'

export default function AdminLayout() {
  return (
    <div>
      <div className='flex flex-row h-screen w-screen '>
        <AdminSidebar/>
        <div className='flex flex-col h-screen w-screen '>
          <AdminNavbar/>
          <Outlet/>
        </div>
      </div>
    </div>
  )
}

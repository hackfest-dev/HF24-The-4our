import React from 'react'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Layout from './components/shared/Layout'
import LoginForm from './components/LoginForm'
import SignupForm from './components/SignupForm'
import AdminLoginForm from './components/AdminLoginForm'
import Dashboard from './components/Dashboard'
import Farms from './components/Farms'
import CreateFarms from './components/CreateFarms'
import Settings from './components/Settings'
import Help from './components/Help'
import FullPageCard from './components/FullPageCard'
import { FARM_DATA } from './consts/farmdata'

export default function App() {
  return (
    <Router>
    <Routes>
      <Route path='/' element={<Layout/>}>
        <Route index element={<Dashboard/>}/>
        <Route path='/farms' element={<Farms/>}/>
          <Route path="/farms/:id" element={<FullPageCard farmData={FARM_DATA}/>} />
        <Route/>
        
        <Route path='/createfarms' element={<CreateFarms/>}/>
        <Route path='/settings' element={<Settings/>}/>
        <Route path='/help' element={<Help/>}/>
      </Route>
      <Route path='/login' element={<LoginForm/>}/>
      <Route path='/signup' element={<SignupForm/>}/>
      <Route path='/adminlogin' element={<AdminLoginForm/>}/>

    </Routes>
    </Router>
  )
}


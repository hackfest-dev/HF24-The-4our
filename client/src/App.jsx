import React from 'react'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Layout from './components/shared/Layout'
import LoginForm from './components/LoginForm'
import SignupForm from './components/SignupForm'
import AdminLoginForm from './components/AdminLoginForm'

export default function App() {
  return (
    <Router>
    <Routes>
      <Route path='/' element={<Layout/>}>
        <Route/>
      </Route>
      <Route path='/login' element={<LoginForm/>}/>
      <Route path='/signup' element={<SignupForm/>}/>
      <Route path='/adminlogin' element={<AdminLoginForm/>}/>

    </Routes>
    </Router>
  )
}


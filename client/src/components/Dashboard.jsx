import React from 'react'
import hero from '../images/hero.png'
import { Link } from 'react-router-dom'

export default function Dashboard() {
  return (
    <div className='flex w-3/4 h-screen justify-between items-center ml-60'>
      <div className='flex flex-col justify-start m-10 gap-14'>
    <div className="hero min-h-screen bg-base-200">
      <div className="hero-content text-center">
        <div className="max-w-md">
        <h1 className="text-5xl font-bold">Hello Organisation!</h1>
        <p className="py-6">Welcome back to Ecosavvy! We have everything maintained and running for you.</p>
        <Link to='/farms' className="btn btn-primary">Check My Farms</Link>
    </div>
  </div>
</div>
      </div>
      <div className='flex flex-col justify-end'>
        <img className='h-[500px]' src={hero} alt="" />
        <div className='flex flex-col text-center text-3xl' style={{fontFamily: 'Dancing Script'}}>Power To The People</div>
      </div>
    </div>
  )
}

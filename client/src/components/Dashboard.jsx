import React from 'react'
import hero from '../images/hero.png'

export default function Dashboard() {
  return (
    <div className='flex w-3/4 h-screen justify-between items-center ml-60'>
      <div className='flex flex-col justify-start text-8xl m-10 gap-14' style={{fontFamily: 'Dancing Script'}}>

      </div>
      <div className='flex flex-col justify-end'>
        <img className='h-[500px]' src={hero} alt="" />
        <div className='flex flex-col text-center text-3xl' style={{fontFamily: 'Dancing Script'}}>Power To The People</div>
      </div>
    </div>
  )
}

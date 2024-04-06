import React from 'react'
import hero from '../images/hero.png'

export default function Dashboard() {
  return (
    <div className='flex w-screen h-screen justify-end items-center'>
      <img className='h-[500px]' src={hero} alt="" />
    </div>
  )
}

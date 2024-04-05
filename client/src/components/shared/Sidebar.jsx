import React from 'react'
import { PiTreeEvergreenFill } from "react-icons/pi";
import { DASHBOARD_SIDEBAR_LINKS } from '../../consts/navigation';
import {Link, useLocation} from 'react-router-dom'

const linkClasses = "flex items-center gap-2 font-light px-3 py-2 hover:bg-neutral-700 hover:no-underine"


export default function Sidebar() {
  return (
    <div className='bg-neutral-900 flex flex-col w-60 text-white'>
      <div className='flex'>
        <div className='flex items-center gap-2 pt-4 pl-2'>
          <div className='pt-1 px-2'><PiTreeEvergreenFill fontSize={20}/></div>
          <div className='text-xl pt-1'>Ecosavvy</div>
        </div>
      </div>
      <div className='flex-1 pl-2 pt-10'>
        {DASHBOARD_SIDEBAR_LINKS.map((item) => (
          <SidebarLink key={item.key} item={item}/>
        ))}
      </div>
    </div>
  )
}

function SidebarLink({item}){

  const {pathname} = useLocation()
  return (
    <Link to={item.path} className={linkClasses}>
      <span className='text-xl'>{item.icon}</span>
      {item.label}
    </Link>
  )
}

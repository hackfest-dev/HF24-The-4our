import {TbSolarPanel2} from 'react-icons/tb'
import {HiOutlineViewGrid} from 'react-icons/hi'
import {IoAdd} from 'react-icons/io5'
import { IoMdSettings } from "react-icons/io";
import { IoIosHelpCircleOutline } from "react-icons/io";
import { MdLogout } from "react-icons/md";
import { FaCheck } from "react-icons/fa";


export const ADMIN_DASHBOARD_SIDEBAR_LINKS = [
    {
        key: 'admindashboard',
        label: 'Admin Dashboard',
        path: '/admin',
        icon: <HiOutlineViewGrid/>
    },
    {
        key: 'adminfarms',
        label: 'Admin Farms',
        path: '/adminfarms',
        icon: <TbSolarPanel2/>
    },
    {
        key: 'createfarms',
        label: 'Approve Farms',
        path: '/approvefarms',
        icon: <FaCheck/>
    },
]

export const DASHBOARD_SIDEBAR_LINKS = [
    {
        key: 'dashboard',
        label: 'Dashboard',
        path: '/',
        icon: <HiOutlineViewGrid/>
    },
    {
        key: 'farms',
        label: 'Farms',
        path: '/farms',
        icon: <TbSolarPanel2/>
    },
    {
        key: 'createfarms',
        label: 'Create Farms',
        path: '/createfarms',
        icon: <IoAdd/>
    },
]

export const DASHBOARD_SIDEBAR_LINKS_BOTTOM = [
        {
        key: 'settings',
        label: 'Settings',
        path: '/settings',
        icon: <IoMdSettings/>
    },
    {
        key: 'help',
        label: 'Help',
        path: '/help',
        icon: <IoIosHelpCircleOutline/>
    },
    {
        key: 'logout',
        label: 'Logout',
        path: '/login',
        icon: <MdLogout/>
    },    
]
export const ADMIN_DASHBOARD_SIDEBAR_LINKS_BOTTOM = [
        {
        key: 'adminsettings',
        label: 'Settings',
        path: '/adminsettings',
        icon: <IoMdSettings/>
    },
    {
        key: 'help',
        label: 'Help',
        path: '/help',
        icon: <IoIosHelpCircleOutline/>
    },
    {
        key: 'logout',
        label: 'Logout',
        path: '/adminlogin',
        icon: <MdLogout/>
    },    
]
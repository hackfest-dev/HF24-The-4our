import {TbSolarPanel2} from 'react-icons/tb'
import {HiOutlineViewGrid} from 'react-icons/hi'
import {IoAdd} from 'react-icons/io5'

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
        label: 'CreateFarms',
        path: '/createfarms',
        icon: <IoAdd/>
    },
]
import React from 'react'

export default function FarmAnalytics() {
  return (
    <div className=' flex flex-col mt-20 ml-60' >
        <div className='text-3xl mx-10 text-gray-300'>
            Farm Name
        </div>
        <div className='text-xl mx-10 text-gray-500'>
            Category
        </div>
        <div className='text-xl mx-10 text-gray-500'>
            Location
        </div>
        <div className='Graph'>
            {/* graph code here */}
        </div>


        <div>
         <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pl-80 pt-0 w-5/6">
            <div>

      <div className="mt-6 border-t border-gray-100">
        <dl className="divide-y divide-gray-100">
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Average Energy Output
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              value
            </dd>
          </div>
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Average Returns
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              value
            </dd>
          </div>
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Highest Output
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              value
            </dd>
          </div>
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Highest Last Year
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              value
            </dd>
          </div>
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">

            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">

            </dd>
          </div>
        </dl>
      </div>
    </div>
    <div>
      <div className="mt-6 border-t border-gray-100">
        <dl className="divide-y divide-gray-100">
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Lowest Last Year
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              value
            </dd>
          </div>
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Farm Degrade Percent
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              value
            </dd>
          </div>
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Farm Maintainance Percent
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              value
            </dd>
          </div>
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Current Output
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              value
            </dd>
          </div>
          <div className="px-4 py-3">
            <dt className="text-sm font-medium leading-6 text-gray-300">

            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
 
            </dd>
          </div>
        </dl>
      </div>
    </div>
              </div>
        </div>

    </div>
  )
}

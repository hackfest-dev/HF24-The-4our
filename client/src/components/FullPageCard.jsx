import React from 'react';
import { useLocation } from 'react-router-dom';
import { FARM_DATA } from '../consts/farmdata'; // Assuming FARM_DATA is imported correctly

export default function FullPageCard() {
  const location = useLocation();
  const pathArray = location.pathname.split('/');
  const farmId = pathArray[pathArray.length - 1]; // Get the farm ID from the URL

  const farm = FARM_DATA.find((farm) => farm.farmID === farmId);

  if (!farm) {
    // Farm not found, handle this case as needed (e.g., show a message or redirect)
    return <div>Farm not found</div>;
  }

  return (
    <div className='flex'>
    <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pl-80 pt-0">
      <div>
        <div className="px-4 sm:px-0">
          <h3 className="text-base font-semibold leading-7 text-gray-900">Farm Information</h3>
          <p className="mt-1 max-w-2xl text-sm leading-6 text-gray-500">Details about the farm.</p>
        </div>
        <div className="mt-6 border-t border-gray-100">
          <dl className="divide-y divide-gray-100">
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">Farm ID</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">{farm.farmID}</dd>
            </div>
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">Farm Name</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">{farm.farmName}</dd>
            </div>
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">Energy Category</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">{farm.energyCategory}</dd>
            </div>
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">Location</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">{farm.Location}</dd>
            </div>
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">News</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">
                <ul>
                  {farm.news.map((newsItem, index) => (
                    <li key={index}>{newsItem}</li>
                  ))}
                </ul>
              </dd>
            </div>
          </dl>
        </div>
      </div>
      <div>
        <div className="px-4 sm:px-0">
          <h3 className="text-base font-semibold leading-7 text-gray-900">Financial Information</h3>
          <p className="mt-1 max-w-2xl text-sm leading-6 text-gray-500">Financial details about the farm.</p>
        </div>
        <div className="mt-6 border-t border-gray-100">
          <dl className="divide-y divide-gray-100">
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">Farm Valuation</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">${farm.farmValuation}</dd>
            </div>
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">Total Investors</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">{farm.totalInvestors}</dd>
            </div>
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">Number of Shares</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">{farm.numberOfShares}</dd>
            </div>
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">Available Shares</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">{farm.availableShares}</dd>
            </div>
            <div className="px-4 py-6">
              <dt className="text-sm font-medium leading-6 text-gray-900">Each Share Price</dt>
              <dd className="mt-1 text-sm leading-6 text-gray-700">${farm.eachSharePrice}</dd>
            </div>
          </dl>
        </div>
      </div>
    </div>

    <div class="max-w-md mx-auto bg-white rounded-xl shadow-md overflow-hidden md:max-w-2xl m-5">
    <div class="p-8">
        <div class="uppercase tracking-wide text-sm text-indigo-500 font-semibold">Event Name</div>
        <p class="block mt-1 text-lg leading-tight font-medium text-black">Event Date</p>
        <p class="mt-2 text-gray-500">Event Description</p>
        <p class="mt-2 text-gray-500">Event Details...</p>
    </div>
    </div>
    </div>
  );
}

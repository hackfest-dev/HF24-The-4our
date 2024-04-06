import React, { useState } from "react";
import { useParams } from "react-router-dom";
import { FARM_DATA } from "../consts/farmdata"; // Assuming FARM_DATA is imported correctly

export default function FullPageCard() {
  const id = useParams();
  const apiurl = process.env.REACT_APP_API_URL;

  const [farm, setFarmData] = useState([]);

  async function fetchFarmData() {
    try {
      const response = await fetch(`${apiurl}/fetch/${id}`, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      });
      if (!response.ok) {
        throw new Error("Failed to fetch data");
      }
      const data = await response.json();
      console.log(data);
    } catch (error) {}
  }

  if (!farm) {
    // Farm not found, handle this case as needed (e.g., show a message or redirect)
    return <div>Farm not found</div>;
  }

  return (
    <div className="flex flex-col mt-20">
      <div className="flex flex-row">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pl-80 pt-0 w-5/6">
          <div>
            <div className="px-4 sm:px-0">
              <h3 className="text-base font-semibold leading-7 text-gray-900">
                Farm Information
              </h3>
              <p className="mt-1 max-w-2xl text-sm leading-6 text-gray-500">
                Details about the farm.
              </p>
            </div>
            <div className="mt-6 border-t border-gray-100">
              <dl className="divide-y divide-gray-100">
                <div className="px-4 py-6">
                  <dt className="text-sm font-medium leading-6 text-gray-900">
                    Farm ID
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-700">
                    {farm.farmID}
                  </dd>
                </div>
                <div className="px-4 py-6">
                  <dt className="text-sm font-medium leading-6 text-gray-900">
                    Farm Name
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-700">
                    {farm.farmName}
                  </dd>
                </div>
                <div className="px-4 py-6">
                  <dt className="text-sm font-medium leading-6 text-gray-900">
                    Energy Category
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-700">
                    {farm.energyCategory}
                  </dd>
                </div>
                <div className="px-4 py-6">
                  <dt className="text-sm font-medium leading-6 text-gray-900">
                    Location
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-700">
                    {farm.Location}
                  </dd>
                </div>
              </dl>
            </div>
          </div>
          <div>
            <div className="px-4 sm:px-0">
              <h3 className="text-base font-semibold leading-7 text-gray-900">
                Financial Information
              </h3>
              <p className="mt-1 max-w-2xl text-sm leading-6 text-gray-500">
                Financial details about the farm.
              </p>
            </div>
            <div className="mt-6 border-t border-gray-100">
              <dl className="divide-y divide-gray-100">
                <div className="px-4 py-6">
                  <dt className="text-sm font-medium leading-6 text-gray-900">
                    Farm Valuation
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-700">
                    ${farm.farmValuation}
                  </dd>
                </div>
                <div className="px-4 py-6">
                  <dt className="text-sm font-medium leading-6 text-gray-900">
                    Total Investors
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-700">
                    {farm.totalInvestors}
                  </dd>
                </div>
                <div className="px-4 py-6">
                  <dt className="text-sm font-medium leading-6 text-gray-900">
                    Number of Shares
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-700">
                    {farm.numberOfShares}
                  </dd>
                </div>
                <div className="px-4 py-6">
                  <dt className="text-sm font-medium leading-6 text-gray-900">
                    Available Shares
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-700">
                    {farm.availableShares}
                  </dd>
                </div>
                <div className="px-4 py-6">
                  <dt className="text-sm font-medium leading-6 text-gray-900">
                    Each Share Price
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-700">
                    ${farm.eachSharePrice}
                  </dd>
                </div>
              </dl>
            </div>
          </div>
        </div>

        <div className="flex flex-col w-1/2 pl-20">
          {farm.news.map((newsItem) => (
            <div
              key={newsItem.id}
              className="w-1/2 bg-white rounded-xl shadow-md overflow-hidden m-5"
            >
              <div className="p-8">
                <div className="uppercase tracking-wide text-sm text-indigo-500 font-semibold">
                  {newsItem}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

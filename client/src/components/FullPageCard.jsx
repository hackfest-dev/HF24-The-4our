import React, { useState } from "react"
import { useParams } from "react-router-dom"
import { FARM_DATA } from "../consts/farmdata" // Assuming FARM_DATA is imported correctly

export default function FullPageCard() {
  const { id } = useParams()
  const apiurl = process.env.REACT_APP_API_URL

  const [farm, setFarmData] = useState({})

  async function fetchFarmData() {
    try {
      const response = await fetch(`${apiurl}/fetch/farm/${id}`, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      })
      if (!response.ok) {
        throw new Error("Failed to fetch data")
      }
      const data = await response.json()
      const obj = { ...data.farm, org: data.organisation }
      console.log(obj)
      setFarmData(obj)
    } catch (error) {}
  }

  const [news, setNews] = useState("")

  useState(() => {
    fetchFarmData()
    console.log(farm)
  }, [])

  if (!farm) {
    // Farm not found, handle this case as needed (e.g., show a message or redirect)
    return <div>Farm not found</div>
  }

  const handleChange = (e) => {
    setNews(e.target.value)
  }

  // Function to handle form submission
  const handleSubmit = async (e) => {
    e.preventDefault()

    try {
      // Make API call to authenticate user
      const response = await fetch(`${apiurl}/farm/addnews`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          farmID: id,
          news: news,
        }),
      })

      const data = await response.json()

      // Check if login was successful
      if (response.ok) {
        setNews('')
      } else {
        // Handle login error
        console.error("No news! :(")
        // Display error message to the user
      }
    } catch (error) {
      console.error("Error during login:", error)
      // Display error message to the user
    }
  }

  return (
    <div className="flex flex-col mt-20">
      <div className="flex flex-row">
  <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pl-80 pt-0 w-5/6">
    <div>
      <div className="px-4 sm:px-0">
        <h3 className="text-base font-semibold leading-7 text-gray-300">
          Farm Information
        </h3>
        <p className="mt-1 max-w-2xl text-sm leading-6 text-gray-400">
          Details about the farm.
        </p>
      </div>
      <div className="mt-6 border-t border-gray-100">
        <dl className="divide-y divide-gray-100">
          <div className="px-4 py-6">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Farm ID
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              {farm.farmID}
            </dd>
          </div>
          <div className="px-4 py-6">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Farm Name
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              {farm.farmName}
            </dd>
          </div>
          <div className="px-4 py-6">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Energy Category
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              {farm.energyCategory}
            </dd>
          </div>
          <div className="px-4 py-6">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Location
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              {farm.Location}
            </dd>
          </div>
        </dl>
      </div>
    </div>
    <div>
      <div className="px-4 sm:px-0">
        <h3 className="text-base font-semibold leading-7 text-gray-300">
          Financial Information
        </h3>
        <p className="mt-1 max-w-2xl text-sm leading-6 text-gray-400">
          Financial details about the farm.
        </p>
      </div>
      <div className="mt-6 border-t border-gray-100">
        <dl className="divide-y divide-gray-100">
          <div className="px-4 py-6">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Farm Valuation
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              ${farm.farmValuation}
            </dd>
          </div>
          <div className="px-4 py-6">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Total Investors
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              {farm.totalInvestors}
            </dd>
          </div>
          <div className="px-4 py-6">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Number of Shares
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              {farm.numberOfShares}
            </dd>
          </div>
          <div className="px-4 py-6">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Available Shares
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              {farm.availableShares}
            </dd>
          </div>
          <div className="px-4 py-6">
            <dt className="text-sm font-medium leading-6 text-gray-300">
              Each Share Price
            </dt>
            <dd className="mt-1 text-sm leading-6 text-gray-400">
              ${farm.eachSharePrice}
            </dd>
          </div>
        </dl>
      </div>
    </div>
  </div>

        <div className="flex flex-col w-1/2 pl-20 mr-10">
          {farm.news?.map((newsItem) => (
            <div
              key={newsItem.id}
              className="w-full bg-base-200 rounded-xl shadow-md overflow-hidden m-5"
            >
              <div className="p-8">
                <div className="uppercase tracking-wide text-sm text-[#747FFF] font-semibold">
                  {newsItem}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="w-2/3 ml-72">
        <form
          onSubmit={handleSubmit}
          className="bg-base-200 shadow-md rounded px-8 pb-8 mb-4"
        >
          <div className="mb-4">
            <label
              htmlFor="textInput"
              className="block text-gray-300 text-sm font-bold mb-2 pt-2"
            >
              Enter News:
            </label>
            <input
              type="text"
              id="textInput"
              value={news}
              onChange={handleChange}
              placeholder="Type something..."
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-300 leading-tight focus:outline-none focus:shadow-outline"
            />
          </div>
          <div className="flex items-center justify-center">
            <button
              type="submit"
              className="bg-[#747FFF] hover:bg-blue-700 text-gray-300 font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
            >
              Submit
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}

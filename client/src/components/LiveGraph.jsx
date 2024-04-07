import React, { useState } from 'react'

export default function LiveGraph() {

  const apiurl = process.env.REACT_APP_API_URL;

  const [allFarms, setAllFarms] = useState([])

  const getAllFarms = async() => {
    const response = await fetch(`${apiurl}/fetch/getallfarms`, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      });
      if (!response.ok) {
        throw new Error("Failed to fetch data");
      }
      const data = await response.json();
      setAllFarms(data)
  }

  useState(() => {
    getAllFarms()
    const farmsData = allFarms.forEach(async(farm) => {
          const response = await fetch(`${apiurl}/fetch/${farm.farmID}/returns`, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      });
      if (!response.ok) {
        throw new Error("Failed to fetch data");
      }
      const data = await response.json();
      console.log(data)
      return data
    })

    console.log(farmsData)
  }, [])





  return (
    <div>LiveGraph</div>
  )
}

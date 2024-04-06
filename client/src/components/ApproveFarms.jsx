import React, { useState, useEffect } from "react";
import FarmCard from '../components/FarmCard'
import { Link } from 'react-router-dom'

const ApproveFarms = () => {
  const [farmsData, setFarmsData] = useState([]);
  const [approvedFarms, setApprovedFarms] = useState([]);
  const [rejectedFarms, setRejectedFarms] = useState([]);
  const apiurl = process.env.REACT_APP_API_URL;

  useEffect(() => {
    const fetchFarms = async () => {
      try {
        const response = await fetch(`${apiurl}/fetch/getallfarms`);
        if (!response.ok) {
          throw new Error("Failed to fetch farms");
        }
        const data = await response.json();
        setFarmsData(data);
      } catch (error) {
        console.error("Error fetching farms:", error);
      }
    };

    fetchFarms();
  }, []);

  const handleApprove = (farm) => {
    setApprovedFarms((prevApproved) => [...prevApproved, farm]);
    setFarmsData((prevData) => prevData.filter((item) => item.farmID !== farm.farmID));
  };

  const handleReject = (farm) => {
    setRejectedFarms((prevRejected) => [...prevRejected, farm]);
    setFarmsData((prevData) => prevData.filter((item) => item.farmID !== farm.farmID));
  };

  return (
    <div className="ml-60 pt-20">
      <div className="text-2xl ml-5 mb-10">
        Pending Approvals
      </div>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 overflow-scroll ">
        {Array.isArray(farmsData) && farmsData.length > 0 ? (
          farmsData.map((item) => (
            <div key={item.farmID}>
              <Link to={`/farms/${item.farmID}`}>
                <FarmCard
                  key={item.farmID}
                  imageUrl={item.imgurl}
                  title={item.farmName}
                  category={item.energyCategory}
                  location={item.Location}
                />
              </Link>
              <div className=" m-4 ml-8">
                <button className="focus:outline-none text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 w-24" onClick={() => handleApprove(item)}>Approve</button>
                <button className="focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 w-24" onClick={() => handleReject(item)}>Reject</button>
              </div>
            </div>
          ))
        ) : (
          <h1>NO MORE PENDING APPROVALS...</h1>
        )}
      </div>
    </div>
  );
};

export default ApproveFarms;

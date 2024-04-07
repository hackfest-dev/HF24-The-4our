import React, { useState, useEffect } from "react";
import FarmAnalytics from "./FarmAnalytics";

export default function AdminDashboard() {
  const apiurl = process.env.REACT_APP_API_URL;

  const [allFarms, setAllFarms] = useState([]);

  const getAllFarms = async () => {
    try {
      const response = await fetch(`${apiurl}/fetch/getallfarms`, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      });
      if (!response.ok) {
        throw new Error("Failed to fetch farms data");
      }
      const data = await response.json();
      setAllFarms(data.map((farm) => ({ ...farm, returns: null }))); // Initialize returns as null for each farm
    } catch (error) {
      console.error("Error fetching farms data:", error);
    }
  };

  const getFarmReturns = async (farmID) => {
    try {
      const response = await fetch(
        `${apiurl}/fetch/${farmID}/returns?duration=1M`,
        {
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${localStorage.getItem("token")}`,
          },
        }
      );
      if (!response.ok) {
        throw new Error("Failed to fetch returns data for farm ID: " + farmID);
      }
      const data = await response.json();
      // Update the allFarms state by mapping over it and updating the returns for the specific farmID
      setAllFarms((prevFarms) =>
        prevFarms.map((farm) =>
          farm.farmID === farmID ? { ...farm, returns: data } : farm
        )
      );
    } catch (error) {
      console.error("Error fetching returns data for farm ID:", farmID, error);
    }
  };

  useEffect(() => {
    getAllFarms();
  }, []);

  useEffect(() => {
    // Fetch returns data for each farm
    allFarms.forEach((farm) => {
      if (!farm.returns) {
        getFarmReturns(farm.farmID);
      }
    });

    console.log(allFarms);
  }, [allFarms]);

  return (
    <div className=" sm:grid-cols-2 md:grid-cols-3 gap-4 pt-20 overflow-scroll ml-60">
      {Array.isArray(allFarms) && allFarms.length > 0 ? (
        allFarms.map((item) => <FarmAnalytics farm={item} />)
      ) : (
        <h1>LOADING...</h1>
      )}
    </div>
  );
}

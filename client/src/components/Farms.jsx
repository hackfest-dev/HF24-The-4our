import React, { useEffect, useState } from "react";
import FarmGrid from "./FarmGrid";
import { Link } from "react-router-dom";
import FarmCard from "./FarmCard";

export default function Farms() {
  const apiurl = process.env.REACT_APP_API_URL;
  const [farmsData, setFarmsData] = useState([]);

  const getFarms = async () => {
    try {
      const response = await fetch(`${apiurl}/organisation/getorgfarms`, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      });
      if (!response.ok) {
        throw new Error("Failed to fetch data");
      }
      const data = await response.json();
      const arr = data.farms;
      console.log(arr);
      setFarmsData(arr);
      console.log(farmsData);
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    getFarms();
  }, []);

  useEffect(() => {
    console.log("Updated farmsData:", farmsData);
  }, [farmsData]);

  return (
    <div>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 pt-20 overflow-scroll ml-60">
        {Array.isArray(farmsData) && farmsData.length > 0 ? (
          farmsData.map((item) => (
            <Link to={`/farms/${item.farmID}`} key={item.farmID}>
              <FarmCard
                key={item.farmID}
                imageUrl={item.imgurl}
                title={item.farmName}
                category={item.energyCategory}
                location={item.Location}
              />
            </Link>
          ))
        ) : (
          <h1>LOADING...</h1>
        )}
      </div>
    </div>
  );
}

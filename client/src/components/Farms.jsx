import React, { useEffect, useState } from "react";
import FarmGrid from "./FarmGrid";

export default function Farms() {
  const apiurl = process.env.REACT_APP_API_URL;
  const [farmsData, setFarmsData] = useState([]);

  const getFarms = async () => {
    try {
      const response = await fetch(`${apiurl}/session/list`, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      });
      if (!response.ok) {
        throw new Error("Failed to fetch data");
      }
      const data = await response.json();
      // setFarmsData(data);
      console.log(data);
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    getFarms();
  }, []);

  return (
    <div>
      <FarmGrid farmsData={farmsData} />
    </div>
  );
}

import React, { useState, useEffect } from "react";
import FarmCard from '../components/FarmCard'
import {Link} from 'react-router-dom'

const AdminFarms = () => {
  const [farmsData, setFarmsData] = useState([]);
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
        console.log(data); // Log the fetched data to the console
      } catch (error) {
        console.error("Error fetching farms:", error);
      }
    };

    fetchFarms();
    console.log(farmsData)
  }, []);

  return <div>
    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 pt-20 overflow-scroll ml-60">
      {Array.isArray(farmsData) && farmsData.length > 0 ? (
        farmsData.map((item) => (
          <Link to={`/admin/adminfarms/${item.farmID}`} key={item.farmID}>
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
  </div>;
};

export default AdminFarms;

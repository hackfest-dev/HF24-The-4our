import React, { useState, useEffect } from "react";

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
  }, []);

  return <div></div>;
};

export default AdminFarms;

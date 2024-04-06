import React, { useEffect } from "react";
import FarmCard from "./FarmCard";
import Solarfarm from "../images/solarfarm.jpeg";
import { Link } from "react-router-dom";
import { FARM_DATA } from "../consts/farmdata";

const FarmGrid = (farmsdata) => {
  useEffect(() => {
    console.log("Updated farmsData in GRID:", farmsdata);
  }, [farmsdata]);

  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 pt-20 overflow-scroll ml-60">
      {Array.isArray(farmsdata) && farmsdata.length > 0 ? (
        farmsdata.map((item) => (
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
  );
};

export default FarmGrid;

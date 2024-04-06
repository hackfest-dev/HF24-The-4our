import React from 'react';
import FarmCard from './FarmCard';
import Solarfarm from '../images/solarfarm.jpeg'
import { Link } from 'react-router-dom';
import { FARM_DATA } from '../consts/farmdata';

const FarmGrid = () => {



  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 pt-20 overflow-scroll ml-60">
      {FARM_DATA.map((item) => (
        <Link to={`/farms/${item.farmID}`} key={item.farmID}>
        <FarmCard
          key={item.farmID}
          imageUrl={item.imageUrl}
          title={item.farmName}
          category={item.energyCategory}
          location={item.Location}
        />
        </Link>
      ))}
    </div>
  );
};

export default FarmGrid;

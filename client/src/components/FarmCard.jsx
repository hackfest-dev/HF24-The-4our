import React from 'react';
import Solarfarm from '/Users/ratnesh/Desktop/Ecosavvy/client/src/images/solarfarm.jpeg'

const FarmCard = ({ imageUrl, title, category, location}) => {
  return (
    <div className="m-auto rounded-lg shadow-lg cursor-pointer h-90 w-60 md:w-80">
      <a href="#" className="block w-full h-full">
        <img
          alt="farm photo"
          src={imageUrl}
          className="object-cover w-full max-h-40"
        />
        <div className="w-full p-4 bg-white">
          <p className="font-medium text-indigo-500 text-md">{title}</p>
          <p className="mb-2 text-xl font-medium text-gray-800">{category}</p>
          <p className="font-light text-gray-400 text-md">{location}</p>
          <div className="flex items-center mt-4">
            </div>
          </div>
      </a>
    </div>
  );
};

export default FarmCard;

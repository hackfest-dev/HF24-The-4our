import React, { useState } from 'react';
import { FARM_DATA } from '../consts/farmdata'; // Assuming FARM_DATA is imported correctly

export default function FarmForm() {
  const [formData, setFormData] = useState({
    farmID: '',
    imageUrl: '',
    farmName: '',
    energyCategory: '',
    Location: '',
    news: [],
    farmValuation: 0,
    totalInvestors: 0,
    numberOfShares: 0,
    availableShares: 0,
    eachSharePrice: 0,
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Append the new farm data to FARM_DATA array
    FARM_DATA.push(formData);
    // You can perform additional actions here, like sending data to the server
    // or resetting the form
    console.log('New farm added:', formData);
    // Reset the form after submission
    setFormData({
      farmID: '',
      imageUrl: '',
      farmName: '',
      energyCategory: '',
      Location: '',
      news: [],
      farmValuation: 0,
      totalInvestors: 0,
      numberOfShares: 0,
      availableShares: 0,
      eachSharePrice: 0,
    });
  };

  return (
    <form onSubmit={handleSubmit} className="max-w-md mx-auto pt-20 text-black ">
      <div className="grid md:grid-cols-2 md:gap-6">
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="farmID"
            value={formData.farmID}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Farm ID"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="imageUrl"
            value={formData.imageUrl}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Image URL"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="farmName"
            value={formData.farmName}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Farm Name"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="energyCategory"
            value={formData.energyCategory}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Energy Category"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="Location"
            value={formData.Location}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Location"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="farmValuation"
            value={formData.farmValuation}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Farm Valuation"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="number"
            name="totalInvestors"
            value={formData.totalInvestors}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Total Investors"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="number"
            name="numberOfShares"
            value={formData.numberOfShares}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Number of Shares"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="number"
            name="availableShares"
            value={formData.availableShares}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Available Shares"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="number"
            name="eachSharePrice"
            value={formData.eachSharePrice}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Each Share Price"
            required
          />
        </div>
      </div>
      <button
        type="submit"
        className="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center "
      >
        Submit
      </button>
    </form>
  );
}

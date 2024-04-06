import React, { useState } from "react";

export default function FarmForm() {
  const apiurl = process.env.REACT_APP_API_URL;

  const [formData, setFormData] = useState({
    farmID: "",
    imgurl: "",
    farmName: "",
    energyCategory: "",
    Location: "",
    news: [],
    farmValuation: null,
    numberOfShares: null,
    eachSharePrice: null,
    govtSubsidy: null,
    expectedEnergyOutput: null,
    orgInvestment: null,
    latitude: "",
    longitude: "",
    energyUnit: "",
    farmReady: false,
    description: "",
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      // Make API call to authenticate user
      const response = await fetch(`${apiurl}/farm/create`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
        body: JSON.stringify(formData),
      });

      const data = await response.json();

      // Check if login was successful
      if (response.ok) {
        // Store token in localStorage
        localStorage.setItem("token", data.token);
      } else {
        // Handle login error
        console.error("Login failed:", data.error);
        // Display error message to the user
      }
    } catch (error) {
      console.error("Error during login:", error);
      // Display error message to the user
    }

    setFormData({
      farmID: "",
      imgurl: "",
      farmName: "",
      energyCategory: "",
      Location: "",
      news: [],
      farmValuation: null,
      numberOfShares: null,
      eachSharePrice: null,
      govtSubsidy: null,
      expectedEnergyOutput: null,
      orgInvestment: null,
      expectedDateOfReturns: "",
      farmExpectedReadyDate: "",
      latitude: "",
      longitude: "",
      energyUnit: "",
      farmReady: false,
      description: "",
    });
  };

  return (
    <form onSubmit={handleSubmit} className="w-1/2 mx-auto pt-20 text-black ">
      <div className="grid md:grid-cols-2 md:gap-3 ">
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="imgurl"
            value={formData.imgurl}
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
            name="description"
            value={formData.description}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Farm Description"
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
            name="eachSharePrice"
            value={formData.eachSharePrice}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Each Share Price"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="number"
            name="govtSubsidy"
            value={formData.govtSubsidy}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Government Subsidy"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="number"
            name="orgInvestment"
            value={formData.orgInvestment}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Organisation investment"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="number"
            name="expectedEnergyOutput"
            value={formData.expectedEnergyOutput}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Expected Energy Output"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="energyUnit"
            value={formData.energyUnit}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Energy Unit"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="date"
            name="farmExpectedReadyDate"
            value={formData.farmExpectedReadyDate}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Farm expected ready date"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="date"
            name="expectedDateOfReturns"
            value={formData.expectedDateOfReturns}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Farm expected date of returns"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="latitude"
            value={formData.latitude}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Latitude"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="text"
            name="longitude"
            value={formData.longitude}
            onChange={handleInputChange}
            className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none  focus:outline-none focus:ring-0 focus:border-blue-600 peer"
            placeholder="Longitude"
            required
          />
        </div>
        <div className="relative z-0 w-full mb-5 group">
          <input
            type="checkbox"
            id="farmReady"
            name="farmReady"
            checked={formData.farmReady}
            onChange={(e) =>
              setFormData({ ...formData, farmReady: e.target.checked })
            }
            className="peer h-4 w-4 border-gray-300 rounded focus:ring-blue-500 text-blue-600"
          />
          <label
            htmlFor="Farm Ready"
            className="ml-2 text-sm font-medium text-gray-700"
          >
            Farm Ready
          </label>
        </div>
      </div>
      <button
        type="submit"
        className="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center ="
      >
        Submit
      </button>
    </form>
  );
}

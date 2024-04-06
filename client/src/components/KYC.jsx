import React, { useEffect, useState } from "react";
import CustomerCard from "../components/CustomerCard";

export default function KYC() {
  const apiurl = process.env.REACT_APP_API_URL;
  const [cardsData, setCardsData] = useState([]);

  const getNonKyc = async () => {
    try {
      const response = await fetch(`${apiurl}/admin/getnonkyc`, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      });
      if (!response.ok) {
        throw new Error("Failed to fetch data");
      }
      const data = await response.json();
      console.log(data);
      setCardsData(data);
      console.log(cardsData);
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    getNonKyc();
  }, []);

  useEffect(() => {
    console.log("Updated farmsData:", cardsData);
  }, [cardsData]);

  const handleApprove = async (person) => {
    setCardsData((prevData) =>
      prevData.filter((item) => item.aadharNumber !== person.aadharNumber)
    );

    const response = await fetch(
      `${apiurl}/admin/approvekyc/${person.aadharNumber}`
    );
  };

  return (
    // <div className='mt-60 ml-60' >
    //     <CustomerCard/>
    // </div>
    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 pt-20 overflow-scroll ml-60">
      {Array.isArray(cardsData) && cardsData.length > 0 ? (
        cardsData.map((item) => (
          <div>
            <div className=" w-full max-w-sm bg-white border border-gray-200 rounded-lg shadow">
              <div className=" flex flex-row justify-between px-5 pb-5">
                <div className="flex flex-col items-start pt-6">
                  <div>
                    <h5 className="text-xl font-semibold tracking-tight text-gray-900">
                      {item.name}
                    </h5>
                  </div>
                  <div class="flex flex-col items-left mt-2.5 mb-2.5">
                    <div className="flex font-bold items-center space-x-1 rtl:space-x-reverse">
                      Aadhar Number:
                    </div>
                    <div className="flex items-center space-x-1 rtl:space-x-reverse">
                      {item.aadharNumber}
                    </div>
                    <div className="flex font-bold items-center space-x-1 rtl:space-x-reverse">
                      Pan Number:
                    </div>
                    <div className="flex items-center space-x-1 rtl:space-x-reverse">
                      {item.panNumber}
                    </div>
                  </div>
                </div>
                <div class="flex flex-col items-center justify-evenly pt-4">
                  <a
                    href="#"
                    className="w-24 text-white bg-blue-700 hover:bg-blue-800  font-medium rounded-lg text-sm px-5 py-2.5 text-center"
                    onClick={() => handleApprove(item)}
                  >
                    Approve
                  </a>
                  <a
                    href="#"
                    className="w-24 text-white bg-red-700 hover:bg-red-800  font-medium rounded-lg text-sm px-5 py-2.5 text-center"
                  >
                    Reject
                  </a>
                </div>
              </div>
            </div>
          </div>
        ))
      ) : (
        <h1>LOADING...</h1>
      )}
    </div>
  );
}

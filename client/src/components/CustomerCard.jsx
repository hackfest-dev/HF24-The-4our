import React from "react";

export default function CustomerCard() {
  return (
    <div>
      <div className=" w-full max-w-sm bg-white border border-gray-200 rounded-lg shadow">
        <div className=" flex flex-row justify-between px-5 pb-5">
          <div className="flex flex-col items-start pt-6">
            <div>
              <h5 className="text-xl font-semibold tracking-tight text-gray-900">
                Ratnesh Kherudkar
              </h5>
            </div>
            <div class="flex flex-col items-left mt-2.5 mb-2.5">
              <div className="flex items-center space-x-1 rtl:space-x-reverse">
                200910389422
              </div>
              <div className="flex items-center space-x-1 rtl:space-x-reverse">
                EXHPK8368G
              </div>
            </div>
          </div>
          <div class="flex flex-col items-center justify-evenly pt-4">
            <a
              href="#"
              className="w-24 text-white bg-blue-700 hover:bg-blue-800  font-medium rounded-lg text-sm px-5 py-2.5 text-center"
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
  );
}
